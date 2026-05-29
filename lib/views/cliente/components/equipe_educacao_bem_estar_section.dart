import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../model/home_cliente_normal_model.dart';


class EquipeEducacaoBemEstarSection extends StatelessWidget {
  const EquipeEducacaoBemEstarSection({
    super.key,
    required this.onReadMore,
  });

  final VoidCallback onReadMore;

  IconData _iconFromString(String value) {
    switch (value) {
      case 'icons.security':
        return Icons.security;
      case 'icons.favorite':
        return Icons.favorite;
      case 'icons.health_and_safety':
        return Icons.health_and_safety;
      default:
        return Icons.medical_services_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 360;

    final media = MediaQuery.of(context);
    final sectionHeight = media.size.height * 0.48;
    final clampedHeight = sectionHeight.clamp(320.0, 520.0);

    return SizedBox(
      height: clampedHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: imagem da equipe + texto impactante
          Flexible(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: clampedHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/doctor_1.png',
                        fit: BoxFit.cover,
                        color: const Color(0xFF6BB6FF).withOpacity(0.10),
                        colorBlendMode: BlendMode.srcATop,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.00),
                              Colors.black.withOpacity(0.35),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              HomeClienteNormalModel.teamImpactTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: isNarrow ? 16 : 18,
                                    height: 1.15,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              HomeClienteNormalModel.teamImpactSubtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withOpacity(0.92),
                                    fontWeight: FontWeight.w600,
                                    fontSize: isNarrow ? 12.5 : 13.5,
                                    height: 1.25,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Right: educação + cards + botão
          Flexible(
            flex: 7,
            child: Container(
              height: clampedHeight,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.78),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  )
                ],
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.10),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HomeClienteNormalModel.educationSectionTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                          fontSize: isNarrow ? 16 : 18,
                          height: 1.2,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    HomeClienteNormalModel.educationSectionDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                          fontSize: isNarrow ? 13 : 14,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  Flexible(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: HomeClienteNormalModel.educationCards.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final card = HomeClienteNormalModel.educationCards[index];
                        final iconKey = card['icon'] ?? 'icons.health_and_safety';

                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.88),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.10),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: AppColors.primary.withOpacity(0.18),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  _iconFromString(iconKey),
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card['title'] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.textPrimary,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      card['description'] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppColors.textSecondary,
                                            height: 1.35,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: onReadMore,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        foregroundColor: AppColors.primary,
                      ),
                      child: Text(
                        'Ler mais  digas -->',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: isNarrow ? 13.5 : 14.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
