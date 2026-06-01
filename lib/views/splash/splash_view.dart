import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../cliente/home-cliente-normal/home_cliente_normal_view.dart';
import '_dots_loading.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'assets/logo.png',
                  width: 130,
                  height: 130,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),

                Text(
                  'Saúde em Casa',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                        fontSize: 24,
                      ),
                ),
                const SizedBox(height: 6),

                Text(
                  'Serviço de cuidados ao Domicílio',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                ),

                const SizedBox(height: 18),

                DotsLoading(color: AppColors.primary),

                const SizedBox(height: 26),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Card(
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                        _SectionTitle(title: 'Escolha de Acessibilidade'),
                        const SizedBox(height: 12),
                        _ChoiceCard(
                          icon: Icons.accessibility_new_rounded,
                          title: 'Modo normal',
                          description: 'Experiência padrão do sistema.',
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomeClienteNormalView(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        _ChoiceCard(
                          icon: Icons.person_rounded,
                          title: 'Modo Fácil (idosos)',
                          description: 'Maior visibilidade.',
                          titleAndIconColor: const Color(0xFF22C55E),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomeClienteNormalView(),
                              ),
                            );
                          },
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                Text(
                  'Esta escolha poderá ser alterada posteriormente nas configurações.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color? titleAndIconColor;

  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.titleAndIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE8EEF6), // cinza claro
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: titleAndIconColor ?? AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: titleAndIconColor ?? AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.35,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
