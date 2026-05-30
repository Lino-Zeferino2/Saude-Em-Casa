import 'package:flutter/material.dart';

import '../../../model/home_cliente_normal_model.dart';
import '../../../theme/app_colors.dart';

import 'testemunho_card.dart';

class TestemunhosSection extends StatefulWidget {
  const TestemunhosSection({
    super.key,
  });

  @override
  State<TestemunhosSection> createState() => _TestemunhosSectionState();
}

class _TestemunhosSectionState extends State<TestemunhosSection> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollBy(double dx) {
    if (!_scrollController.hasClients) return;

    final current = _scrollController.offset;
    final target = (current + dx).clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

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
              _ScrollControls(
                onLeft: () => _scrollBy(-260),
                onRight: () => _scrollBy(260),
              ),
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: (_) {},
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.separated(
                  controller: _scrollController,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  shrinkWrap: false,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  clipBehavior: Clip.hardEdge,
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
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollControls extends StatelessWidget {
  const _ScrollControls({
    required this.onLeft,
    required this.onRight,
  });

  final VoidCallback onLeft;
  final VoidCallback onRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ControlButton(
          icon: Icons.chevron_left,
          onPressed: onLeft,
        ),
        const SizedBox(width: 10),
        _ControlButton(
          icon: Icons.chevron_right,
          onPressed: onRight,
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
