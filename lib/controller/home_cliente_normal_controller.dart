import 'package:flutter/material.dart';

import '../views/cliente/auth/login_view.dart';

class HomeClienteNormalController {
  const HomeClienteNormalController();

  void onLoginPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  void onSchedulePressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agendar avaliação (em breve)')),
    );
  }

  void onPlansPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ver planos (em breve)')),
    );
  }
}
