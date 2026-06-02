import 'package:flutter/material.dart';

import '../../../controller/home_cliente_servicos_controller.dart';
import '../../../model/home_cliente_servicos_model.dart';
import '../../../theme/app_colors.dart';

import '../components/app_footer.dart';
import '../components/app_menu.dart';
import 'home_cliente_formacao_view.dart';
import 'home_cliente_servico_detalhe_view.dart';

class HomeClienteServicosView extends StatefulWidget {
  const HomeClienteServicosView({super.key});

  @override
  State<HomeClienteServicosView> createState() =>
      _HomeClienteServicosViewState();
}

class _HomeClienteServicosViewState extends State<HomeClienteServicosView> {
  final controller = const HomeClienteServicosController();
  String activeMenu = 'Serviços';

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  bool get isMobile => MediaQuery.of(context).size.width < 700;

  String _normalizeMenu(String s) {
    final v = s.trim().toLowerCase();
    return v
        .replaceAll('á', 'a')
        .replaceAll('à', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('â', 'a')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ç', 'c');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleMenuSelection(String item) {
    setState(() => activeMenu = item);

    final normalized = _normalizeMenu(item);
    if (normalized == 'formacao') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HomeClienteFormacaoView(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Em breve: $item')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double logoSize = isMobile ? 44.0 : 64.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile
          ? Drawer(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Saúde em Casa',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...[
                      'Inicio',
                      'Serviços',
                      'Formaçao',
                      'Parceiros',
                      'Sobre nos',
                    ].map(
                      (item) {
                        final bool selected = item == activeMenu;
                        return ListTile(
                          title: Text(
                            item,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: selected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                          ),
                          selected: selected,
                          selectedTileColor:
                              AppColors.primary.withOpacity(0.08),
                          onTap: () {
                            Navigator.of(context).pop(); // fecha Drawer
                            _handleMenuSelection(item);
                          },
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 6,
        leading: isMobile
            ? AppMenu(
                items: const [
                  'Inicio',
                  'Serviços',
                  'Formaçao',
                  'Parceiros',
                  'Sobre nos',
                ],
                activeItem: activeMenu,
                onMenuSelected: (item) {
                  _handleMenuSelection(item);
                },
                onLoginPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login (em breve)')),
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
                _handleMenuSelection(item);
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
              _ServicesSearchBar(
                controller: _searchController,
                value: _searchQuery,
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 14),
              _ServicesList(query: _searchQuery),
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

class _ServicesSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String value;
  final ValueChanged<String> onChanged;

  const _ServicesSearchBar({
    required this.controller,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Pesquisar serviço...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: value.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.22),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.22),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.55),
          ),
        ),
      ),
    );
  }
}

class _ServicesList extends StatelessWidget {
  final String query;

  const _ServicesList({required this.query});

  @override
  Widget build(BuildContext context) {
    final allServices = HomeClienteServicosModel.services;
    final services = query.isEmpty
        ? allServices
        : allServices
            .where(
              (s) => s.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        final int crossAxisCount = maxWidth > 1200
            ? 6
            : maxWidth > 900
                ? 5
                : maxWidth > 600
                    ? 2
                    : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 220,
          ),
          itemBuilder: (context, i) {
            final s = services[i];
            return _ServiceCard(
              icon: s.icon,
              title: s.title,
              description: s.description,
              onVerDetalhes: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HomeClienteServicoDetalheView(
                      service: s,
                    ),
                  ),
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
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
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
              final bool isMobileButtons = constraints.maxWidth < 700;

              if (isMobileButtons) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
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
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
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
                  ],
                );
              }

              return Row(
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
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
