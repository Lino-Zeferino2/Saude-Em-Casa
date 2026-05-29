import 'package:flutter/material.dart';

import '../../../controller/home_cliente_normal_controller.dart';
import '../../../model/home_cliente_normal_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../components/app_menu.dart';
import '../components/hero_header.dart';
import '../components/services_horizontal_list.dart';
import '../components/equipe_educacao_bem_estar_section.dart';
import '../components/testemunhos_section.dart';

class HomeClienteNormalView extends StatelessWidget {
  const HomeClienteNormalView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = const HomeClienteNormalController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.96),
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 6,
          title: Row(
            children: [
              // Logo no lado esquerdo
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(
                  'logo.png',
                  height: 150,
                  width: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: const SizedBox.shrink(),
                    );
                  },
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Saúde em Casa',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                      color: AppColors.primary
                    ),
              ),
            ],
          ),
          actions: [
            // Menu no lado direito (Inicio, Serviços, Formação, Parceiros, Sobre nós + Login)
            AppMenu(
              items: HomeClienteNormalModel.menuItems,
              onLoginPressed: () => controller.onLoginPressed(context),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroHeader(
                  onSchedule: () => controller.onSchedulePressed(context),
                  onPlans: () => controller.onPlansPressed(context),
                ),

                const SizedBox(height: 14),
                ServicesHorizontalList(
                  services: HomeClienteNormalModel.services,
                ),

                const SizedBox(height: 18),
                EquipeEducacaoBemEstarSection(
                  onReadMore: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Em breve: mais conteúdos de bem-estar'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 18),
                const TestemunhosSection(),

                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(18),
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
                  child: const Text(
                    'Área reservada para a próxima secção (você vai definir depois).',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
