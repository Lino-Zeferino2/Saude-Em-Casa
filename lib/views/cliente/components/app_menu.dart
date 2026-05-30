import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class AppMenu extends StatelessWidget {
  final List<String> items;
  final VoidCallback onLoginPressed;

  const AppMenu({
    super.key,
    required this.items,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Sempre usar hambúrguer para evitar problemas de responsividade
    // (RenderFlex unbounded / overflow em Web).
    return IconButton(
      tooltip: 'Menu',
      icon: const Icon(Icons.menu_rounded),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
