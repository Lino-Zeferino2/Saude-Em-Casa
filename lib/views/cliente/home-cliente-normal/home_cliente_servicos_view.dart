import 'package:flutter/material.dart';

import '../../../controller/home_cliente_servicos_controller.dart';
import '../../../model/home_cliente_servicos_model.dart';
import '../../../theme/app_colors.dart';

import '../components/app_footer.dart';
import '../components/app_menu.dart';

class HomeClienteServicosView extends StatefulWidget {
  const HomeClienteServicosView({super.key});

  @override
  State<HomeClienteServicosView> createState() =>
      _HomeClienteServicosViewState();
}

class _HomeClienteServicosViewState extends State<HomeClienteServicosView> {
  final controller = const HomeClienteServicosController();
  String activeMenu = 'Serviços';

  bool get isMobile => MediaQuery.of(context).size.width < 700;

  @override
  Widget build(BuildContext context) {
    final double logoSize = isMobile ? 44.0 : 64.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 6,
        leading: isMobile
            ? IconButton(
                tooltip: 'Menu',
                icon: const Icon(Icons.menu_rounded,
                    color: AppColors.textPrimary),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menu (em breve)')),
                  );
                },
              )
            : null,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'logo.png',
                height: logoSize,
                width: logoSize,
                errorBuilder: (context, error, stackTrace) {
                  return CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                    child: const SizedBox.shrink(),
                  );
                },
              ),
            ),
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
        ),
        actions: [
          if (!isMobile)
            AppMenu(
              items: const [
                'Inicio',
                'Serviços',
                'Formaçao',
                'Parceiros',
                'Sobre nos',
              ],
              activeItem: activeMenu,
              onMenuSelected: (item) {
                setState(() => activeMenu = item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Em breve: $item')),
                );
              },
              onLoginPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login (em breve)')),
                );
              },
            ),
          if (!isMobile) const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              _Header(),
              const SizedBox(height: 14),
              _ServicesList(),
              const SizedBox(height: 18),
              _PersonalizedPlanCard(
                onSolicitarOrcamento: () =>
                    controller.onSolicitarOrcamento(context),
                onFalarComConsultor: () =>
                    controller.onFalarComConsultor(context),
              ),
              const SizedBox(height: 24),
              AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            HomeClienteServicosModel.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  fontSize: 22,
                ),
          ),
        ),
        const SizedBox(height: 8),
       
      ],
    );
  }
}

class _ServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final services = HomeClienteServicosModel.services;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Objetivo: 4 cards por linha (1ª linha) e por baixo mais 4, etc.
        final double maxWidth = constraints.maxWidth;

        // 4 colunas quando couber; caso contrário reduz para 2.
        final int crossAxisCount =
    maxWidth > 1200 ? 6 :
    maxWidth > 900 ? 5 :
    maxWidth > 600 ? 2 :
    2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: crossAxisCount,
  mainAxisSpacing: 12,
  crossAxisSpacing: 12,
  mainAxisExtent: 190,
),
          itemBuilder: (context, i) {
            final s = services[i];
            return _ServiceCard(
              icon: s.icon,
              title: s.title,
              description: s.description,
              onVerDetalhes: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Em breve: $s.title')),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onVerDetalhes;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onVerDetalhes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: AppColors.primary.withOpacity(0.16),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.22),
                      width: 1,
                    ),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 4),
  child: SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onVerDetalhes,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: const Text(
        'Ver detalhes',
        style: TextStyle(
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}

class _PersonalizedPlanCard extends StatelessWidget {
  final VoidCallback onSolicitarOrcamento;
  final VoidCallback onFalarComConsultor;

  const _PersonalizedPlanCard({
    required this.onSolicitarOrcamento,
    required this.onFalarComConsultor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: const EdgeInsets.symmetric(
  horizontal: 18,
  vertical: 32,
),
      decoration: BoxDecoration(
        color: const Color(0xFF6BB6FF).withOpacity(0.10),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.22),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            'Precisa de um plano personalizado?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Conte-nos o que precisa e nós orientamos os próximos passos de forma simples e humana.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 14),
        LayoutBuilder(
  builder: (context, constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: onSolicitarOrcamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Solicitar orçamento',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 170,
              child: OutlinedButton(
                onPressed: onFalarComConsultor,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.9),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Falar com Consultor',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
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
