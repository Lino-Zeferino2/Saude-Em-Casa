import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../components/app_footer.dart';
import '../components/app_menu.dart';
import 'home_cliente_agendamento_hospital_clinica_view.dart';
import 'home_cliente_farmacia_view.dart';


class HomeClienteParceirosView extends StatefulWidget {
  const HomeClienteParceirosView({super.key});

  @override
  State<HomeClienteParceirosView> createState() =>
      _HomeClienteParceirosViewState();
}

class _HomeClienteParceirosViewState extends State<HomeClienteParceirosView> {
  bool get isMobile => MediaQuery.of(context).size.width < 700;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  String activeFilter = 'Todos';

  static const List<String> filters = [
    'Todos',
    'Hospitais',
    'Clinicas',
    'Farmacias',
    'Laboratorios',
  ];

  final List<_PartnerCategory> categories = [
    _PartnerCategory(
      id: 'p1',
      tag: 'Hospitais',
      categoryLabel: 'Hospital',
      title: 'Hospital São Lucas',
      location: 'Lisboa',
      assetImage: 'assets/hospital Geral.jpg',
    ),
    _PartnerCategory(
      id: 'p2',
      tag: 'Clinicas',
      categoryLabel: 'Clínica',
      title: 'Clínica Vida Plena',
      location: 'Porto',
      assetImage: 'assets/clinica maxima.jpg',
    ),
    _PartnerCategory(
      id: 'p3',
      tag: 'Farmacias',
      categoryLabel: 'Farmácia',
      title: 'Farmácia Central',
      location: 'Braga',
      // Sem asset confirmado no /assets (fallback = ícone)
      assetImage: '',
    ),
    _PartnerCategory(
      id: 'p4',
      tag: 'Laboratorios',
      categoryLabel: 'Laboratório',
      title: 'Lab Diagnóstico Rápido',
      location: 'Coimbra',
      // Sem asset confirmado no /assets (fallback = ícone)
      assetImage: '',
    ),
    _PartnerCategory(
      id: 'p5',
      tag: 'Clinicas',
      categoryLabel: 'Clínica',
      title: 'Clínica Saúde & Bem Estar',
      location: 'Faro',
      assetImage: 'assets/clinica maxima.jpg',
    ),
    _PartnerCategory(
      id: 'p6',
      tag: 'Hospitais',
      categoryLabel: 'Hospital',
      title: 'Hospital Santa Maria',
      location: 'Setúbal',
      assetImage: 'assets/hospital militar.jpg',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesFilter(_PartnerCategory p) {
    if (activeFilter == 'Todos') return true;
    return p.tag == activeFilter;
  }

  List<_PartnerCategory> get _filtered {
    final q = _searchQuery.trim().toLowerCase();
    return categories.where((p) {
      if (!_matchesFilter(p)) return false;
      if (q.isEmpty) return true;
      return p.title.toLowerCase().contains(q) ||
          p.location.toLowerCase().contains(q) ||
          p.categoryLabel.toLowerCase().contains(q);
    }).toList();
  }

  int _gridCountForWidth(double width) {
    if (width < 420) return 2;
    if (width < 900) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final partnerList = _filtered;

    final width = MediaQuery.of(context).size.width;
    final gridCount = _gridCountForWidth(width);

    final int crossAxisCount = isMobile ? gridCount : gridCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Parceiros'),
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  tooltip: 'Menu',
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
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
              activeItem: 'Parceiros',
              onMenuSelected: (item) {
                if (item == 'Parceiros') return;
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
        ],
      ),
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...const [
                      'Inicio',
                      'Serviços',
                      'Formaçao',
                      'Parceiros',
                      'Sobre nos'
                    ].map((item) {
                      final selected = item == 'Parceiros';
                      return _MobileDrawerTile(
                        item: item,
                        selected: selected,
                      );
                    }),
                    const Spacer(),
                  ],
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Rede de Parceiros',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 22 : 26,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Conheça hospitais, clínicas, farmácias e laboratórios parceiros para apoiar seu cuidado com confiança.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 16),

              _FilterChips(
                filters: filters,
                active: activeFilter,
                onSelected: (v) => setState(() => activeFilter = v),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Pesquisar parceiros...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
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
              ),

              const SizedBox(height: 16),

              if (partnerList.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Nenhum parceiro encontrado.',
                    textAlign: TextAlign.center,
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: partnerList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: isMobile ? 220 : 210,
                  ),
                  itemBuilder: (context, i) {
                    final p = partnerList[i];
                    return _PartnerCard(
                      partner: p,
                      onDetails: () {
                        // Hospital/Clínica abre agendamento.
                        if (p.tag == 'Hospitais' || p.tag == 'Clinicas') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HomeClienteAgendamentoHospitalClinicaView(
                                partnerName: p.title,
                                partnerAddress: 'Localização: ${p.location}',
                                assetImage: p.assetImage,
                                partnerCategoryLabel: p.categoryLabel,
                              ),
                            ),
                          );
                          return;
                        }

                        // Farmácia abre tela de farmácia (demo).
                        if (p.tag == 'Farmacias') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HomeClienteFarmaciaView(
                                farmaciaName: p.title,
                                farmaciaAddress: 'Localização: ${p.location}',
                                assetImage: p.assetImage,
                                clienteName: 'Cliente (demo)',
                                clientePhone: '(demo)',
                                clienteEmail: '(demo@email.com)',
                                entregaRua: 'Rua (demo)',
                                entregaCidade: p.location,
                                entregaCodigoPostal: '0000-000',
                              ),
                            ),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Em breve: Ver detalhes')),
                        );
                      },
                    );
                  },
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

class _MobileDrawerTile extends StatelessWidget {
  final String item;
  final bool selected;

  const _MobileDrawerTile({
    required this.item,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: selected ? AppColors.primary : AppColors.textPrimary,
            ),
      ),
      selected: selected,
      selectedTileColor: AppColors.primary.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pop();
        if (item != 'Parceiros') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Em breve: $item')),
          );
        }
      },
    );
  }
}

class _FilterChips extends StatelessWidget {
  final List<String> filters;
  final String active;
  final ValueChanged<String> onSelected;

  const _FilterChips({
    required this.filters,
    required this.active,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final f in filters)
          ChoiceChip(
            label: Text(f),
            selected: f == active,
            selectedColor: AppColors.primary.withOpacity(0.16),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: f == active
                    ? AppColors.primary.withOpacity(0.55)
                    : AppColors.primary.withOpacity(0.18),
              ),
            ),
            onSelected: (_) => onSelected(f),
          ),
      ],
    );
  }
}

IconData _partnerCategoryIcon(String categoryLabel) {
  final label = categoryLabel.toLowerCase();

  if (label.contains('hospital')) return Icons.local_hospital_rounded;
  if (label.contains('farm')) return Icons.local_pharmacy_rounded;
  if (label.contains('labor')) return Icons.science_rounded;
  if (label.contains('clín')) return Icons.local_hospital_rounded;

  return Icons.local_hospital_rounded;
}

class _PartnerCard extends StatelessWidget {
  final _PartnerCategory partner;
  final VoidCallback onDetails;

  const _PartnerCard({
    required this.partner,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    const double baseRadius = 18.0;

    return SizedBox(
      height: 210,
      child: Card(
        elevation: 0,
        color: Colors.white.withOpacity(0.92),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(baseRadius),
          side: BorderSide(
            color: AppColors.primary.withOpacity(0.16),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.primary.withOpacity(0.10),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.18),
                  ),
                ),
                child: _buildPartnerImage(),
              ),
              const SizedBox(height: 10),
              Text(
                partner.categoryLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w800,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                partner.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Localização: ${partner.location}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              FilledButton.tonal(
                onPressed: onDetails,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'Ver detalhes',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerImage() {
    final assetPath = partner.assetImage;

    // assetImage vazio => fallback ícone
    if (assetPath.isEmpty) {
      return Center(
        child: Icon(
          _partnerCategoryIcon(partner.categoryLabel),
          color: AppColors.primary,
          size: 30,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              _partnerCategoryIcon(partner.categoryLabel),
              color: AppColors.primary,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}

class _PartnerCategory {
  final String id;
  final String tag;
  final String categoryLabel;
  final String title;
  final String location;

  /// Apenas assets locais (ex: assets/hospital Geral.jpg).
  /// Se vier vazio, o card exibe ícone.
  final String assetImage;

  const _PartnerCategory({
    required this.id,
    required this.tag,
    required this.categoryLabel,
    required this.title,
    required this.location,
    required this.assetImage,
  });
}

