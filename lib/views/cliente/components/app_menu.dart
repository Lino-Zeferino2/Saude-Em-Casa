import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../theme/app_colors.dart';

class AppMenu extends StatelessWidget {
  final List<String> items;
  final VoidCallback onLoginPressed;

  /// Item atualmente ativo (para destacar no menu web).
  final String activeItem;

  /// Callback quando o usuário seleciona um item do menu (web/desktop).
  final ValueChanged<String> onMenuSelected;

  const AppMenu({
    super.key,
    required this.items,
    required this.onLoginPressed,
    required this.activeItem,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Garantir: mobile (não-web) mantém apenas ícone; web sempre lista.
        final isWeb = kIsWeb;
        final isMobile = !isWeb && constraints.maxWidth < 700;

        if (isMobile) {
          return IconButton(
            tooltip: 'Menu',
            icon: const Icon(
              Icons.menu_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }

        // Web/desktop: lista de menus (sem overflow) + botão Login
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 6,
              alignment: WrapAlignment.end,
              children: items.map((item) {
                final isActive = item == activeItem;
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => onMenuSelected(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 6),
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: isActive
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            fontWeight: isActive
                                ? FontWeight.w900
                                : FontWeight.w800,
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(width: 14),
            SizedBox(
              height: 40,
              child: FilledButton(
                onPressed: onLoginPressed,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
          ],
        );
      },
    );
  }
}
