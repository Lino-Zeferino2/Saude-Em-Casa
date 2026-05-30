import 'package:flutter/material.dart';

import '../../../controller/home_cliente_normal_publicacoes_controller.dart';
import '../../../model/home_cliente_normal_publicacoes_model.dart';
import '../../../theme/app_colors.dart';
import 'post_card.dart';
import 'tip_card.dart';

class PublicacoesSection extends StatelessWidget {
  const PublicacoesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = const HomeClienteNormalPublicacoesController();
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 900;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeaderRow(
            leftTitle: 'Publicações',
            rightActionLabel: 'Ver tudo',
            onActionPressed: () => controller.onSeeAllPosts(context),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PostsColumn(
                      controller: controller,
                      onReadMore: () => controller.onSeeAllPosts(context),
                    ),
                    const SizedBox(height: 14),
                    _TipsColumn(
                      controller: controller,
                      onReadMore: () => controller.onSeeAllTips(context),
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left 65%
                  Expanded(
                    flex: 65,
                    child: _PostsColumn(
                      controller: controller,
                      onReadMore: () => controller.onSeeAllPosts(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Right 35%
                  Expanded(
                    flex: 35,
                    child: _TipsColumn(
                      controller: controller,
                      onReadMore: () => controller.onSeeAllTips(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.leftTitle,
    required this.rightActionLabel,
    required this.onActionPressed,
  });

  final String leftTitle;
  final String rightActionLabel;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Saúde em casa',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: -0.2,
              ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onActionPressed,
          child: Text(
            rightActionLabel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
      ],
    );
  }
}

class _PostsColumn extends StatelessWidget {
  const _PostsColumn({
    required this.controller,
    required this.onReadMore,
  });

  final HomeClienteNormalPublicacoesController controller;
  final VoidCallback onReadMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.10), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SubHeader(
            title: 'Lista de publicações',
            icon: Icons.notifications_none,
            onReadMore: onReadMore,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            itemCount: HomeClienteNormalPublicacoesModel.posts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final p = HomeClienteNormalPublicacoesModel.posts[index];
              return PostCard(
                controller: controller,
                title: p['author'] ?? '',
                subtitle: p['authorRole'] ?? '',
                content: p['content'] ?? '',
                mediaType: p['mediaType'] ?? 'none',
                mediaAsset: p['mediaAsset'] ?? '',
                likes: p['likes'] ?? '0',
                comments: p['comments'] ?? '0',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TipsColumn extends StatelessWidget {
  const _TipsColumn({
    required this.controller,
    required this.onReadMore,
  });

  final HomeClienteNormalPublicacoesController controller;
  final VoidCallback onReadMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.10), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SubHeader(
            title: 'Dicas rápidas',
            icon: Icons.lightbulb_outline,
            onReadMore: onReadMore,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            itemCount: HomeClienteNormalPublicacoesModel.dicas.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final t = HomeClienteNormalPublicacoesModel.dicas[index];
              return TipCard(
                controller: controller,
                title: t['title'] ?? '',
                description: t['description'] ?? '',
                mediaAsset: t['mediaAsset'] ?? '',
                likes: t['likes'] ?? '0',
                comments: t['comments'] ?? '0',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader({
    required this.title,
    required this.icon,
    required this.onReadMore,
  });

  final String title;
  final IconData icon;
  final VoidCallback onReadMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: onReadMore,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Ler tudo',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        )
      ],
    );
  }
}
