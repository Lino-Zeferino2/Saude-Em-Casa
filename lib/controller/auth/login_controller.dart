import 'package:flutter/material.dart';

import '../../model/auth/login_model.dart';

class LoginController extends ChangeNotifier {
  LoginModel _state = const LoginModel();

  LoginModel get state => _state;

  void setPhoneOrEmail(String value) {
    _state = _state.copyWith(phoneOrEmail: value);
    notifyListeners();
  }

  void setPassword(String value) {
    _state = _state.copyWith(password: value);
    notifyListeners();
  }

  void setCountryCode(String value) {
    _state = _state.copyWith(countryCode: value);
    notifyListeners();
  }

  void toggleShowPassword() {
    _state = _state.copyWith(showPassword: !_state.showPassword);
    notifyListeners();
  }

  String? validatePhoneOrEmail() {
    if (!_state.isValidPhoneOrEmail) return 'Informe telemóvel (9 dígitos) ou email válido';
    return null;
  }

  String? validatePassword() {
    if (!_state.isValidPassword) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  void onLoginPressed(BuildContext context) {
    final phoneOrEmailErr = validatePhoneOrEmail();
    final passwordErr = validatePassword();

    if (phoneOrEmailErr != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(phoneOrEmailErr)),
      );
      return;
    }

    if (passwordErr != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(passwordErr)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Entrando (em breve)')),
    );
  }

  void onForgotPasswordPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Esqueci a senha (em breve)')),
    );
  }

  void onRegisterPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastra-se aqui (em breve)')),
    );
  }
}
