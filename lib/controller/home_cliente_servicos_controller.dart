import 'package:flutter/material.dart';

class HomeClienteServicosController {
  const HomeClienteServicosController();

  void onVerDetalhes(BuildContext context, String serviceTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Detalhes de: $serviceTitle (em breve)')),
    );
  }

  void onSolicitarOrcamento(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Solicitar orçamento (em breve)')),
    );
  }

  void onFalarComConsultor(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Falar com Consultor (em breve)')),
    );
  }
}
