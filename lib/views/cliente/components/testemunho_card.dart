import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class TestemunhoCard extends StatefulWidget {
  const TestemunhoCard({
    super.key,
    required this.title,
    required this.description,
    required this.mediaType, // image | video
    required this.mediaAsset, // asset path
    required this.likes,
    required this.comments,
  });

  final String title;
  final String description;
  final String mediaType;
  final String mediaAsset;
  final String likes;
  final String comments;

  @override
  State<TestemunhoCard> createState() => _TestemunhoCardState();
}

class _TestemunhoCardState extends State<TestemunhoCard> {
  late int _likes;
  late int _comments;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    _likes = int.tryParse(widget.likes) ?? 0;
    _comments = int.tryParse(widget.comments) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.mediaType == 'video';
    final isNarrow = MediaQuery.of(context).size.width < 360;
    final mediaHeight = isNarrow ? 84.0 : 98.0;
    final cardHeight = isNarrow ? 214.0 : 222.0;

    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        height: cardHeight,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.88),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.10),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: AppColors.primary.withOpacity(0.12), width: 1),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Media
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: mediaHeight,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: widget.mediaAsset.isEmpty
                            ? Container(color: AppColors.secondary.withOpacity(0.25))
                            : Image.asset(
                                widget.mediaAsset,
                                fit: BoxFit.cover,
                                color: const Color(0xFF6BB6FF).withOpacity(0.07),
                                colorBlendMode: BlendMode.srcATop,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.secondary.withOpacity(0.22),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                    ),
                                  );
                                },
                              ),
                      ),
                      if (isVideo)
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.00),
                                  Colors.black.withOpacity(0.30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (isVideo)
                        Center(
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Title + description
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      height: 1.28,
                      fontSize: 12,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 5),

              // Actions (gostar + comentar na mesma linha)
              Row(
                children: [
                  Expanded(
                    child: _ActionPill(
                      icon: Icons.favorite_rounded,
                      label: 'Gostar',
                      count: _likes,
                      accent: AppColors.primary,
                      onPressed: () {
                        setState(() {
                          _liked = !_liked;
                          _likes += _liked ? 1 : -1;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_liked ? 'Gostou!' : 'Gostar removido'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      active: _liked,
                      compact: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CommentPill(
                      icon: Icons.comment_rounded,
                      label: 'Comentar',
                      count: _comments,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Área de comentários em breve'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      compact: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
      
        )));
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.count,
    required this.accent,
    required this.onPressed,
    required this.active,
    this.compact = false,
  });

  final IconData icon;
  final String label;
  final int count;
  final Color accent;
  final VoidCallback onPressed;
  final bool active;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final pad = compact
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 10);
    final iconSize = compact ? 16.0 : 18.0;
    final fontSize = compact ? 12.0 : 13.0;
    final gap = compact ? 5.0 : 6.0;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: pad,
        decoration: BoxDecoration(
          color: active ? accent.withOpacity(0.12) : Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active ? accent.withOpacity(0.25) : AppColors.primary.withOpacity(0.10),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: active ? accent : AppColors.textSecondary),
            SizedBox(width: gap),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: active ? accent : AppColors.textPrimary,
                fontSize: fontSize,
              ),
            ),
            SizedBox(width: gap),
            Text(
              '$count',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentPill extends StatelessWidget {
  const _CommentPill({
    required this.icon,
    required this.label,
    required this.count,
    required this.onPressed,
    this.compact = false,
  });

  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final pad = compact
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 10);
    final iconSize = compact ? 16.0 : 18.0;
    final fontSize = compact ? 12.0 : 13.0;
    final gap = compact ? 5.0 : 6.0;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: pad,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.10), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: AppColors.primary),
            SizedBox(width: gap),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                fontSize: fontSize,
              ),
            ),
            SizedBox(width: gap),
            Text(
              '$count',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
