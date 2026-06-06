class LocalStorageImpl {
  static String? getItem(String key) => null;

  static void setItem(String key, String value) {
    // no-op em builds não-web
  }

  static void removeItem(String key) {
    // no-op em builds não-web
  }
}
