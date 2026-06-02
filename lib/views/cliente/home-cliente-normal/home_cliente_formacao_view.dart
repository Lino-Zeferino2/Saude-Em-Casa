import 'package:flutter/material.dart';
import 'package:saudeemcasa/views/cliente/home-cliente-normal/home_cliente_servicos_view.dart';

import '../../../theme/app_colors.dart';
import '../components/app_menu.dart';

class HomeClienteFormacaoView extends StatefulWidget {
  const HomeClienteFormacaoView({super.key});

  @override
  State<HomeClienteFormacaoView> createState() => _HomeClienteFormacaoViewState();
}

class _HomeClienteFormacaoViewState extends State<HomeClienteFormacaoView> {
  static const List<_Course> courses = [
    _Course(
      id: 'cuidadores-1',
      title: 'Formação para Cuidadores',
      level: 'Iniciante • 6 módulos',
      duration: '2 meses',
      description:
          'Aprenda técnicas essenciais e linguagem simples para cuidar com segurança, humanização e consistência.',
      highlights: [
        'Rotina de cuidados',
        'Prevenção em casa',
        'Sinais de alerta',
        'Comunicação com a família',
      ],
      syllabus: [
        'Fundamentos de cuidado',
        'Higiene e segurança',
        'Mobilidade e conforto',
        'Alimentação e hidratação',
        'Prevenção de quedas',
        'Acompanhamento humanizado',
      ],
    ),
    _Course(
      id: 'idoso-1',
      title: 'Cuidado ao Idoso em Casa',
      level: 'Intermediário • 4 módulos',
      duration: '1.5 meses',
      description:
          'Estruture acompanhamento diário e aprenda a reagir com calma e método a situações comuns.',
      highlights: [
        'Mobilidade segura',
        'Organização da medicação',
        'Cuidados cognitivos',
        'Prevenção de complicações',
      ],
      syllabus: [
        'Rotina e ambiente seguro',
        'Medicação e sinais',
        'Mobilidade e exercícios leves',
        'Planeamento de consultas',
      ],
    ),
    _Course(
      id: 'primeiros-socorros-1',
      title: 'Primeiros Socorros Básicos',
      level: 'Iniciante • 3 módulos',
      duration: '6 semanas',
      description:
          'Conhecimentos práticos para agir nos primeiros minutos e reduzir riscos até o atendimento profissional.',
      highlights: [
        'Sangramentos e choque',
        'Engasgo e respiração',
        'Queimaduras leves',
        'Abordagem de emergência',
      ],
      syllabus: [
        'Avaliação inicial',
        'Respiração e engasgo',
        'Sangramentos e choque',
      ],
    ),
    _Course(
      id: 'bem-estar-1',
      title: 'Bem Estar no Dia a Dia',
      level: 'Todos • 5 módulos',
      duration: '7 semanas',
      description:
          'Estratégias de bem estar, atenção ao emocional e rotinas que ajudam família e cuidador.',
      highlights: [
        'Autocuidado do cuidador',
        'Rotina com leveza',
        'Comunicação saudável',
        'Apoio emocional',
      ],
      syllabus: [
        'Autocuidado e energia',
        'Rotina e consistência',
        'Comunicação',
        'Gestão de stress',
        'Acompanhamento',
      ],
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  String activeMenu = 'Formação';

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

  void _handleMenuSelection(String item) {
    final normalized = _normalizeMenu(item);

    setState(() => activeMenu = item);

    // Somente "Formação" abre a tela; demais: em breve
    if (normalized == 'formacao') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HomeClienteFormacaoView(),
        ),
      );
      return;
    } else if (normalized == 'serviços') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HomeClienteServicosView(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Em breve: $item')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Course> _filteredCourses() {
    if (_searchQuery.trim().isEmpty) return courses;
    final q = _searchQuery.trim().toLowerCase();

    return courses.where((c) {
      return c.title.toLowerCase().contains(q) ||
          c.level.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q) ||
          c.highlights.join(' ').toLowerCase().contains(q) ||
          c.syllabus.join(' ').toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCourses();

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
                        final selected = _normalizeMenu(item) ==
                            _normalizeMenu(activeMenu);
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
                            Navigator.of(context).pop();
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
        title: const Text('Formação'),
        automaticallyImplyLeading: false,
        leading: isMobile
            ? Builder(
                builder: (context) {
                  return IconButton(
                    tooltip: 'Menu',
                    icon: const Icon(Icons.menu_rounded,
                        color: AppColors.textPrimary),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
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
              activeItem: activeMenu,
              onMenuSelected: (item) => _handleMenuSelection(item),
              onLoginPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login (em breve)')),
                );
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              isMobile?
                Text(
                
                'Formação e Capacitação',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      fontSize: isMobile ? 20 : 22,
                    ),
              ):
              Text(
                
                'Aprenda com profissionais e cuide com mais segurança.',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      fontSize: isMobile ? 20 : 22,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Cursos práticos e conteúdo organizado para você evoluir passo a passo.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 16),

              // Barra de pesquisa
              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Pesquisar curso...',
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

              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final gridCount = width > 1200
                      ? 3
                      : width > 900
                          ? 2
                          : 1;

                  // Ajuste responsivo para mobile: cards menores e mais colunas.
                  // - <420px: 2 colunas
                  // - <520px: 3 colunas
                  // - >=520px (mobile): 4 colunas (se couber)
                  final int mobileGridCount = width < 420
                      ? 2
                      : width < 520
                          ? 3
                          : 4;

                  final int effectiveGridCount = isMobile ? mobileGridCount : gridCount;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: effectiveGridCount,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: isMobile ? 185 : 210,
                    ),
                    itemBuilder: (context, i) {
                      final c = filtered[i];
                      return _CourseCard(
                        course: c,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  HomeClienteFormacaoDetalheView(course: c),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),

              if (filtered.isEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Nenhum curso encontrado para “$_searchQuery”.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 24),
              
            ],
          ),
        ),
      ),
    );
  }
}

class HomeClienteFormacaoDetalheView extends StatelessWidget {
  final _Course course;

  const HomeClienteFormacaoDetalheView({required this.course});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Detalhes do Curso'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroCourseHeader(course: course),
              const SizedBox(height: 14),
              _Section(
                title: 'O que você vai aprender',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...course.highlights.map(
                      (h) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _BulletRow(text: h),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _Section(
                title: 'Programa (visão geral)',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...course.syllabus.map(
                      (s) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _BulletRow(text: s),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _PrimaryCtaRow(
                isMobile: isMobile,
                onEnroll: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Inscrição (em breve)'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryCtaRow extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onEnroll;

  const _PrimaryCtaRow({
    required this.isMobile,
    required this.onEnroll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: onEnroll,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18),
              ),
              child: const Text(
                'Quero me inscrever',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCourseHeader extends StatelessWidget {
  final _Course course;

  const _HeroCourseHeader({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6BB6FF).withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.20),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            course.level,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            course.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.schedule_rounded, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Duração: ${course.duration}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final _Course course;
  final VoidCallback onTap;

  const _CourseCard({
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.16),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.22),
                      width: 1,
                    ),
                  ),
                  child:
                      const Icon(Icons.school_rounded, color: AppColors.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              course.level,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.schedule_rounded, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  course.duration,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Ver detalhes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.16),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;

  const _BulletRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_rounded, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}

class _Course {
  final String id;
  final String title;
  final String level;
  final String duration;
  final String description;
  final List<String> highlights;
  final List<String> syllabus;

  const _Course({
    required this.id,
    required this.title,
    required this.level,
    required this.duration,
    required this.description,
    required this.highlights,
    required this.syllabus,
  });
}
