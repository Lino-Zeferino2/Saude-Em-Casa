class LoginModel {
  final String phoneOrEmail;
  final String password;
  final String countryCode;
  final bool showPassword;

  const LoginModel({
    this.phoneOrEmail = '',
    this.password = '',
    this.countryCode = '+244',
    this.showPassword = false,
  });

  bool get isPhoneCandidate {
    // Angola & PALOP: 9 dígitos (apenas número)
    final trimmed = phoneOrEmail.trim();
    if (trimmed.isEmpty) return false;
    if (!RegExp(r'^\d{9}$').hasMatch(trimmed)) return false;
    return true;
  }

  bool get isEmailCandidate {
    final trimmed = phoneOrEmail.trim();
    if (trimmed.isEmpty) return false;
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(trimmed);
  }

  bool get isValidPhoneOrEmail => isPhoneCandidate || isEmailCandidate;

  bool get isValidPassword => password.trim().length >= 6;

  LoginModel copyWith({
    String? phoneOrEmail,
    String? password,
    String? countryCode,
    bool? showPassword,
  }) {
    return LoginModel(
      phoneOrEmail: phoneOrEmail ?? this.phoneOrEmail,
      password: password ?? this.password,
      countryCode: countryCode ?? this.countryCode,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
