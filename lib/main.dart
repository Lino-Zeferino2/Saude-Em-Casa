import 'package:flutter/material.dart';

import 'views/cliente/home-cliente-normal/home_cliente_normal_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeClienteNormalView();
  }
}

