import 'package:flutter/material.dart';

import '../../model/auth/login_model.dart';
import '../../utils/local_storage_service.dart';
import '../../views/cliente/auth/register_view_v2.dart';
import '../../views/cliente/home-cliente-normal/home_cliente_normal_view.dart';

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
    if (!_state.isValidPhoneOrEmail) {
      return 'Informe telemóvel (9 dígitos) ou email válido';
    }
    return null;
  }

  String? validatePassword() {
    if (!_state.isValidPassword) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  Future<void> onLoginPressed(BuildContext context) async {
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

    final identity = _state.phoneOrEmail.trim();
    final user = await LocalStorageService.findUserByPhoneOrEmail(identity);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta não encontrada. Faça o cadastro.')),
      );
      return;
    }

    final storedPassword = (user['password'] ?? '').toString();
    if (storedPassword != _state.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha incorreta.')),
      );
      return;
    }

    await LocalStorageService.saveSession(
      session: <String, dynamic>{
        'userEmail': (user['email'] ?? '').toString(),
        'userPhone': (user['phone'] ?? '').toString(),
        'fullName': (user['fullName'] ?? '').toString(),
        'loginAt': DateTime.now().toIso8601String(),
      },
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login efetuado com sucesso!')),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeClienteNormalView()),
    );
  }

  void onForgotPasswordPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Esqueci a senha (em breve)')),
    );
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterViewV2()),
    );
  }
}
