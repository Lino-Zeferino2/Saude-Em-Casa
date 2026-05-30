import 'package:flutter/material.dart';

import '../../../controller/home_cliente_normal_publicacoes_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

class TipCard extends StatelessWidget {
  const TipCard({
    super.key,
    required this.title,
    required this.description,
    required this.mediaAsset,
    required this.likes,
    required this.comments,
    required this.controller,
  });

  final String title;
  final String description;
  final String mediaAsset;
  final String likes;
  final String comments;
  final HomeClienteNormalPublicacoesController controller;

  @override
  Widget build(BuildContext context) {
    final hasMedia = mediaAsset.trim().isNotEmpty;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => controller.onReadTip(context),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            )
          ],
          border: Border.all(color: AppColors.primary.withOpacity(0.10), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (hasMedia) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 110,
                  width: double.infinity,
                  color: AppColors.primary.withOpacity(0.08),
                  child: Image.asset(
                    mediaAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                _ActionPill(
                  icon: Icons.thumb_up_alt_outlined,
                  label: 'Gosto',
                  value: likes,
                  onTap: () => controller.onLike(context, label: 'Gosto'),
                ),
                const SizedBox(width: 10),
                _ActionPill(
                  icon: Icons.comment_outlined,
                  label: 'Comentários',
                  value: comments,
                  onTap: () => controller.onComment(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary.withOpacity(0.12), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    fontSize: 13,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
