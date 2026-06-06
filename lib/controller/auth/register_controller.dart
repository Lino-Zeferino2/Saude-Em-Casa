import 'package:flutter/material.dart';

import '../../model/auth/register_model.dart';
import '../../utils/local_storage_service.dart';
import '../../views/cliente/auth/login_view.dart';

class RegisterController extends ChangeNotifier {
  RegisterModel _state = const RegisterModel();

  RegisterModel get state => _state;

  void setFullName(String value) {
    _state = _state.copyWith(fullName: value);
    notifyListeners();
  }

  void setPhone(String value) {
    _state = _state.copyWith(phone: value);
    notifyListeners();
  }

  void setEmail(String value) {
    _state = _state.copyWith(email: value);
    notifyListeners();
  }

  void setBirthDate(String value) {
    _state = _state.copyWith(birthDate: value);
    notifyListeners();
  }

  void setLocation(String value) {
    _state = _state.copyWith(location: value);
    notifyListeners();
  }

  void setGender(String value) {
    _state = _state.copyWith(gender: value);
    notifyListeners();
  }

  void setPassword(String value) {
    _state = _state.copyWith(password: value);
    notifyListeners();
  }

  String? validateAndGetFirstError() {
    return state.fullNameError() ??
        state.phoneError() ??
        state.emailError() ??
        state.birthDateError() ??
        state.locationError() ??
        state.genderError() ??
        state.passwordError();
  }

  Future<void> onRegisterPressed(BuildContext context) async {
    final err = validateAndGetFirstError();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err)),
      );
      return;
    }

    final user = <String, dynamic>{
      'fullName': state.fullName.trim(),
      'phone': state.phone.trim(),
      'email': state.email.trim().toLowerCase(),
      'birthDate': state.birthDate.trim(),
      'location': state.location.trim(),
      'gender': state.gender.trim(),
      'password': state.password, // demo: senha em texto no localStorage
      'createdAt': DateTime.now().toIso8601String(),
    };

    await LocalStorageService.saveUser(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro efetuado com sucesso!')),
    );

    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  void onLoginPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  void onHelpPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ajuda (em breve)')),
    );
  }
}
