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
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...items.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // A navegação para as seções será conectada depois.
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  e,
                  style: textStyle?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        const SizedBox(width: 6),
        FilledButton(
          onPressed: onLoginPressed,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
