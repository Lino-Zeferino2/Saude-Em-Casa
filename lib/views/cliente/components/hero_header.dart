import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../model/home_cliente_normal_model.dart';
import 'primary_button.dart';

class HeroHeader extends StatelessWidget {
  final VoidCallback onSchedule;
  final VoidCallback onPlans;

  const HeroHeader({
    super.key,
    required this.onSchedule,
    required this.onPlans,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPadding = media.padding.top;
    final heroHeight = media.size.height * 0.80;


    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: heroHeight,
        decoration: BoxDecoration(
          color: AppColors.card,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/heroimage.png',
                fit: BoxFit.cover,
                // opacidade bem baixa para não “lavar” a imagem
               color: const Color.fromARGB(255, 14, 14, 15).withOpacity(0.6),
                colorBlendMode: BlendMode.srcATop,
              ),
            ),

            // Overlay gradient para deixar os textos “premium” e legíveis
            Positioned.fill(
              child: DecoratedBox(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        const Color(0xFF0F172A).withOpacity(0.68),
        const Color(0xFF1E3A5F).withOpacity(0.30),
        Colors.transparent,
        Colors.transparent,
      ],
      stops: const [0.0, 0.35, 0.72, 1.0],
    ),
  ),
),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(18, topPadding + 26, 18, 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 360;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Primeiro texto: background (pill) + menor + mais atrativo
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.20),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.12),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: Text(
                          HomeClienteNormalModel.referenceTitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: isNarrow ? 13 : 14,
                                fontWeight: FontWeight.w900,
                                color: const Color.fromARGB(255, 171, 172, 173),
                                height: 1.05,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        HomeClienteNormalModel.themeTitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: const Color.fromARGB(255, 213, 216, 219),
                              fontWeight: FontWeight.w900,
                              fontSize: isNarrow ? 16 : 18,
                              height: 1.15,
                            ),
                        maxLines: 2,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        HomeClienteNormalModel.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: isNarrow ? 12.8 : 14,
                              height: 1.35,
                              color: const Color.fromARGB(255, 141, 141, 141)
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: isNarrow ? 185 : 210,
                            child: PrimaryButton(
                              height: 46,
                              label: 'Agendar Avaliaçao',
                              onPressed: onSchedule,
                              icon: Icons.event_available_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: isNarrow ? 150 : 175,
                            child: OutlinedButton(
                              onPressed: onPlans,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textPrimary,
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.4,
                                ),
                                backgroundColor: Colors.white.withOpacity(0.92),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.layers_outlined, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Ver planos',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
