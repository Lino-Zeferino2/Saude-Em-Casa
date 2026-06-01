import 'package:flutter/material.dart';

class DotsLoading extends StatefulWidget {
  final Color color;
  const DotsLoading({super.key, required this.color});

  @override
  State<DotsLoading> createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<DotsLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(int index) {
    final t = _controller.value;
    final phase = (t * 3 - index).clamp(0.0, 2.0);

    // Opacidade e deslocamento vertical para “3 pontos animados”
    final opacity = 0.25 + 0.75 * (1 - (phase - 1).abs() * 0.8);
    final dy = 6 * (1 - (opacity - 0.25) / 0.75);

    return Transform.translate(
      offset: Offset(0, dy),
      child: Opacity(
        opacity: opacity.clamp(0.15, 1.0),
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _dot(0),
          const SizedBox(width: 8),
          _dot(1),
          const SizedBox(width: 8),
          _dot(2),
        ],
      ),
    );
  }
}
