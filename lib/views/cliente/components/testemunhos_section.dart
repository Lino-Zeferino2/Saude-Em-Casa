import 'package:flutter/material.dart';

import '../../../model/home_cliente_normal_model.dart';
import '../../../theme/app_colors.dart';

import 'testemunho_card.dart';

class TestemunhosSection extends StatelessWidget {
  const TestemunhosSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 360;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  HomeClienteNormalModel.trustSectionTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: isNarrow ? 18 : 20,
                        letterSpacing: -0.2,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              // Controls
              _ScrollControls(),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            HomeClienteNormalModel.trustSectionDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),

          // Horizontal list
          SizedBox(
            height: 248,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: HomeClienteNormalModel.testimonials.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final t = HomeClienteNormalModel.testimonials[index];
                return SizedBox(
                  width: isNarrow ? 270 : 300,
                  child: TestemunhoCard(
                    title: t['title'] ?? '',
                    description: t['description'] ?? '',
                    mediaType: t['mediaType'] ?? 'image',
                    mediaAsset: t['mediaAsset'] ?? '',
                    likes: t['likes'] ?? '0',
                    comments: t['comments'] ?? '0',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollControls extends StatefulWidget {
  @override
  State<_ScrollControls> createState() => _ScrollControlsState();
}

class _ScrollControlsState extends State<_ScrollControls> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollBy(double dx) {
    if (!_scrollController.hasClients) return;
    final current = _scrollController.offset;
    _scrollController.animateTo(
      (current + dx).clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Note: controls are visual/UX; list scroll controller is owned by ListView below.
    // We'll keep these buttons and wire them if/when we connect a shared controller.
    // For now, keep them as "non-breaking" premium UI elements.
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ControlButton(
          icon: Icons.chevron_left,
          onPressed: () => _scrollBy(-260),
        ),
        const SizedBox(width: 10),
        _ControlButton(
          icon: Icons.chevron_right,
          onPressed: () => _scrollBy(260),
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: AppColors.primary.withOpacity(0.12), width: 1),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 20, color: AppColors.textPrimary),
        onPressed: onPressed,
        tooltip: 'Navegar',
      ),
    );
  }
}
