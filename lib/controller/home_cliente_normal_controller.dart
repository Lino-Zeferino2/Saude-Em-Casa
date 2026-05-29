import 'package:flutter/material.dart';

class HomeClienteNormalController {
  const HomeClienteNormalController();

  void onLoginPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login (em breve)')),
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
