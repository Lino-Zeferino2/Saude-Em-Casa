import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'views/cliente/home-cliente-normal/home_cliente_normal_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saúde em Casa',
      theme: AppTheme.light(),
      home: const HomeClienteNormalView(),
    );
  }
}

