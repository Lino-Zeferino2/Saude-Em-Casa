import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'local_storage_service_stub.dart'
    if (dart.library.html) 'local_storage_service_web.dart';

/// API pública (usada por RegisterController/LoginController)
class LocalStorageService {
  static const String _usersKey = 'saude_em_casa_users_v1';
  static const String _sessionKey = 'saude_em_casa_session_v1';

  static List<Map<String, dynamic>> _decodeUsers(String? raw) {
    if (raw == null || raw.trim().isEmpty) return [];
    try {
      final v = jsonDecode(raw);
      if (v is List) {
        return v
            .whereType<Map>()
            .map((e) => e.map((k, val) => MapEntry(k.toString(), val)))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  static Map<String, dynamic> _decodeMap(String? raw) {
    if (raw == null || raw.trim().isEmpty) return {};
    try {
      final v = jsonDecode(raw);
      if (v is Map<String, dynamic>) return v;
      if (v is Map) return v.map((k, val) => MapEntry(k.toString(), val));
      return {};
    } catch (_) {
      return {};
    }
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    // ignore: avoid_web_libraries_in_flutter
    if (!kIsWeb) return;

    final currentUsers = _decodeUsers(LocalStorageImpl.getItem(_usersKey));
    final updatedUsers = [...currentUsers];

    final email = (user['email'] ?? '').toString().trim().toLowerCase();
    final phone = (user['phone'] ?? '').toString().trim();

    if (email.isNotEmpty || phone.isNotEmpty) {
      final idx = updatedUsers.indexWhere((u) {
        final uEmail = (u['email'] ?? '').toString().trim().toLowerCase();
        final uPhone = (u['phone'] ?? '').toString().trim();
        final emailMatch = email.isNotEmpty && uEmail == email;
        final phoneMatch = phone.isNotEmpty && uPhone == phone;
        return emailMatch || phoneMatch;
      });

      if (idx >= 0) {
        updatedUsers[idx] = user;
      } else {
        updatedUsers.add(user);
      }
    } else {
      updatedUsers.add(user);
    }

    LocalStorageImpl.setItem(_usersKey, jsonEncode(updatedUsers));
  }

  static Future<Map<String, dynamic>?> findUserByPhoneOrEmail(
    String phoneOrEmail,
  ) async {
    // ignore: avoid_web_libraries_in_flutter
    if (!kIsWeb) return null;

    final input = phoneOrEmail.trim();
    final maybeEmail = input.toLowerCase();

    final users = _decodeUsers(LocalStorageImpl.getItem(_usersKey));
    for (final u in users) {
      final uEmail = (u['email'] ?? '').toString().trim().toLowerCase();
      final uPhone = (u['phone'] ?? '').toString().trim();

      if (uEmail.isNotEmpty && maybeEmail.isNotEmpty && uEmail == maybeEmail) {
        return u;
      }
      if (uPhone.isNotEmpty && uPhone == input) {
        return u;
      }
    }
    return null;
  }

  static Future<void> saveSession({required Map<String, dynamic> session}) async {
    // ignore: avoid_web_libraries_in_flutter
    if (!kIsWeb) return;

    LocalStorageImpl.setItem(_sessionKey, jsonEncode(session));
  }

  static Future<Map<String, dynamic>?> getSession() async {
    // ignore: avoid_web_libraries_in_flutter
    if (!kIsWeb) return null;

    final raw = LocalStorageImpl.getItem(_sessionKey);
    final v = _decodeMap(raw);
    return v.isEmpty ? null : v;
  }

  static Future<void> clearSession() async {
    // ignore: avoid_web_libraries_in_flutter
    if (!kIsWeb) return;

    LocalStorageImpl.removeItem(_sessionKey);
  }

  /// Remove também os dados de usuários cadastrados (localStorage).
  static Future<void> clearUsers() async {
    // ignore: avoid_web_libraries_in_flutter
    if (!kIsWeb) return;

    LocalStorageImpl.removeItem(_usersKey);
  }
}
