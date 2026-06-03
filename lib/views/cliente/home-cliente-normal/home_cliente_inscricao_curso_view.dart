import 'package:flutter/material.dart';

/// Esta tela foi incorporada em `home_cliente_formacao_view.dart`
/// para conseguir usar o tipo privado `_Course` que existe naquele arquivo.
///
/// Mantemos este arquivo para não quebrar imports locais antigas,
/// mas não há implementação aqui.
class HomeClienteInscricaoCursoView extends StatelessWidget {
  const HomeClienteInscricaoCursoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Página movida para Formação.'),
      ),
    );
  }
}
