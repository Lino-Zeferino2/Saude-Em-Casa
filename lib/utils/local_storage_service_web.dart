import 'dart:html';

class LocalStorageImpl {
  static String? getItem(String key) => window.localStorage[key];

  static void setItem(String key, String value) {
    window.localStorage[key] = value;
  }

  static void removeItem(String key) {
    window.localStorage.remove(key);
  }
}
