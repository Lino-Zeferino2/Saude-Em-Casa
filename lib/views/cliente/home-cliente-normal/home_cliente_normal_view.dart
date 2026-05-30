import 'package:flutter/material.dart';

import '../../../controller/home_cliente_normal_controller.dart';
import '../../../model/home_cliente_normal_model.dart';
import '../../../theme/app_colors.dart';

import '../components/app_footer.dart';
import '../components/app_menu.dart';
import '../components/equipe_educacao_bem_estar_section.dart';
import '../components/hero_header.dart';
import '../components/publicacoes_section.dart';
import '../components/services_horizontal_list.dart';
import '../components/testemunhos_section.dart';

class HomeClienteNormalView extends StatelessWidget {
  const HomeClienteNormalView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = const HomeClienteNormalController();

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'logo.png',
                      height: 44,
                      width: 44,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          child: const SizedBox.shrink(),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Saúde em Casa',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: HomeClienteNormalModel.menuItems
                      .map(
                        (e) => ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          title: Text(
                            e,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Em breve: $e')),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.onLoginPressed(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 6,
        title: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 500;

            return Row(
              children: [
                // Logo no lado esquerdo
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset(
                    'logo.png',
                    height: isMobile ? 150 : 150,
                    width: isMobile ? 150 : 150,
                    errorBuilder: (context, error, stackTrace) {
                      return CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(0.15),
                        child: const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
                if (!isMobile) const SizedBox(width: 6),
                if (!isMobile)
                  Text(
                    'Saúde em Casa',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.2,
                          color: AppColors.primary,
                        ),
                  ),
              ],
            );
          },
        ),
        actions: [
          // Ícone do menu (abre drawer)
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
              const SizedBox(height: 34),
              const TestemunhosSection(),
              const SizedBox(height: 18),
              PublicacoesSection(),
              const SizedBox(height: 26),
              AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
