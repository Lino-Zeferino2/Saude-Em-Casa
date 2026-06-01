import 'package:flutter/material.dart';

class RegisterModel {
  final String fullName;
  final String phone;
  final String email;
  final String birthDate; // yyyy-mm-dd (string)
  final String location;
  final String gender;
  final String password;

  const RegisterModel({
    this.fullName = '',
    this.phone = '',
    this.email = '',
    this.birthDate = '',
    this.location = '',
    this.gender = '',
    this.password = '',
  });

  bool get isFullNameValid => fullName.trim().length >= 3;

  bool get isPhoneCandidate {
    final t = phone.trim();
    if (t.isEmpty) return false;
    return RegExp(r'^\d{9}$').hasMatch(t);
  }

  bool get isEmailCandidate {
    final t = email.trim();
    if (t.isEmpty) return false;
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(t);
  }

  bool get isLocationValid => location.trim().length >= 3;

  bool get isBirthDateValid {
    final t = birthDate.trim();
    if (t.isEmpty) return false;
    // validação mínima: formato yyyy-mm-dd
    return RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(t);
  }

  bool get isGenderValid => gender.trim().isNotEmpty;

  bool get isValidPassword => password.trim().length >= 6;

  bool get isValidForm =>
      isFullNameValid &&
      isPhoneCandidate &&
      isEmailCandidate &&
      isBirthDateValid &&
      isLocationValid &&
      isGenderValid &&
      isValidPassword;

  String? fullNameError() {
    if (fullName.trim().isEmpty) return 'Nome completo é obrigatório';
    if (!isFullNameValid) return 'Informe um nome completo válido';
    return null;
  }

  String? phoneError() {
    if (phone.trim().isEmpty) return 'Telemóvel é obrigatório';
    if (!isPhoneCandidate) return 'Informe um telemóvel válido (9 dígitos)';
    return null;
  }

  String? emailError() {
    if (email.trim().isEmpty) return 'Email é obrigatório';
    if (!isEmailCandidate) return 'Informe um email válido';
    return null;
  }

  String? birthDateError() {
    if (birthDate.trim().isEmpty) return 'Data de nascimento é obrigatória';
    if (!isBirthDateValid) return 'Use o formato yyyy-mm-dd';
    return null;
  }

  String? locationError() {
    if (location.trim().isEmpty) return 'Localização é obrigatória';
    if (!isLocationValid) return 'Informe uma localização válida';
    return null;
  }

  String? genderError() {
    if (gender.trim().isEmpty) return 'Sexo é obrigatório';
    return null;
  }

  String? passwordError() {
    if (password.trim().isEmpty) return 'Senha é obrigatória';
    if (!isValidPassword) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  RegisterModel copyWith({
    String? fullName,
    String? phone,
    String? email,
    String? birthDate,
    String? location,
    String? gender,
    String? password,
  }) {
    return RegisterModel(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      location: location ?? this.location,
      gender: gender ?? this.gender,
      password: password ?? this.password,
    );
  }
}
