import 'package:flutter/material.dart';
import 'package:saudeemcasa/views/cliente/home-cliente-normal/home_cliente_meus_pedidos_view.dart';
import 'package:saudeemcasa/views/cliente/home-cliente-normal/home_cliente_normal_view.dart';
import 'package:saudeemcasa/views/cliente/home-cliente-normal/home_cliente_parceiros_view.dart';
import 'package:saudeemcasa/views/cliente/home-cliente-normal/home_cliente_servicos_view.dart';
import '../../../theme/app_colors.dart';
import '../components/app_footer.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

    // Apenas para demonstrar navegação; Formação abre esta tela
    if (normalized == 'formacao') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomeClienteFormacaoView(),
        ),
      );
      return;
    }
else if (item == 'Inicio') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeClienteNormalView()),
      );
      return;
    } 
    else if (item == 'Formação') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeClienteFormacaoView()),
      );
      return;
    } 
    else if (item == 'Serviços') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeClienteServicosView()),
      );
      return;
    }
    else if (item == 'Parceiros') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeClienteParceirosView()),
      );
      return;
    } else if (item == 'Meus Pedidos') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeClienteMeusPedidosView()),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Em breve: $item')),
    );
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
                      'Meus Pedidos',
                      'Sobre nos',
                    ].map(
                      (item) {
                        final selected = _normalizeMenu(item) ==
                            _normalizeMenu(activeMenu);
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
                'Meus Pedidos'
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

                  final int desktopGridCount = width > 1200
                      ? 3
                      : width > 900
                          ? 2
                          : 1;

                  final int mobileGridCount = width < 420
                      ? 2
                      : width < 520
                          ? 3
                          : 4;

                  final int effectiveGridCount =
                      isMobile ? mobileGridCount : desktopGridCount;

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
                              builder: (_) => HomeClienteFormacaoDetalheView(
                                course: c,
                              ),
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
              AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeClienteFormacaoDetalheView extends StatelessWidget {
  final _Course course;

  const HomeClienteFormacaoDetalheView({super.key, required this.course});

  bool _hasCertification() {
    final haystack = '${course.level} ${course.description}'.toLowerCase();
    return haystack.contains('cert');
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final hasCert = _hasCertification();

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Section(
          title: 'O que você vai aprender',
          child: _TwoColList(
            items: course.highlights,
            itemBuilder: (h) => _BulletRow(text: h),
          ),
        ),
        const SizedBox(height: 14),
        _Section(
          title: 'Conteúdo do curso (Módulos)',
          child: _ModulesList(
            modules: course.syllabus,
          ),
        ),
      ],
    );

    final right = _CourseSummaryCard(
      duration: course.duration,
      hasCertification: hasCert,
      materials: course.syllabus,
      onEnroll: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomeClienteInscricaoCursoView(course: course),
          ),
        );
      },
    );

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
              if (isMobile)
                Column(
                  children: [
                    left,
                    const SizedBox(height: 14),
                    right,
                  ],
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: left),
                        const SizedBox(width: 14),
                        Expanded(flex: 3, child: right),
                      ],
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

class _TwoColList extends StatelessWidget {
  final List<String> items;
  final Widget Function(String item) itemBuilder;

  const _TwoColList({
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 46,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) {
        final item = items[i];
        return itemBuilder(item);
      },
    );
  }
}

class _ModulesList extends StatelessWidget {
  final List<String> modules;

  const _ModulesList({required this.modules});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < modules.length; i++) ...[
          _ModuleTile(
            index: i + 1,
            text: modules[i],
          ),
          if (i != modules.length - 1)
            Divider(
              color: Colors.grey.withOpacity(0.25),
              height: 22,
            ),
        ],
      ],
    );
  }
}

class _ModuleTile extends StatelessWidget {
  final int index;
  final String text;

  const _ModuleTile({required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Módulo $index',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _CourseSummaryCard extends StatelessWidget {
  final String duration;
  final bool hasCertification;
  final List<String> materials;
  final VoidCallback onEnroll;

  const _CourseSummaryCard({
    required this.duration,
    required this.hasCertification,
    required this.materials,
    required this.onEnroll,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedCertText = hasCertification
        ? 'Certificação: disponível'
        : 'Certificação: não incluída';

    final materialsShort = materials.take(4).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Resumo do curso',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            icon: Icons.schedule_rounded,
            label: 'Duração',
            value: duration,
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            icon: Icons.monetization_on_rounded,
            label: 'Valor do curso',
            value: '€ 120',
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            icon: Icons.verified_rounded,
            label: 'Certificação',
            value: hasCertification ? 'Disponível' : 'Não incluída',
          ),
          const SizedBox(height: 10),
          _SummaryList(
            title: 'Materiais necessários',
            items: materialsShort,
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: onEnroll,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Se inscrever',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.14),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_rounded,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hasCertification
                        ? 'Você recebe orientação e suporte durante todo o processo.'
                        : 'Você recebe orientação prática para começar com segurança.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.14),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryList extends StatelessWidget {
  final String title;
  final List<String> items;

  const _SummaryList({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_rounded,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    e,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.25,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Tela de inscrição no curso (layout responsivo).
class HomeClienteInscricaoCursoView extends StatefulWidget {
  final _Course course;

  const HomeClienteInscricaoCursoView({super.key, required this.course});

  @override
  State<HomeClienteInscricaoCursoView> createState() => _HomeClienteInscricaoCursoViewState();
}

class _HomeClienteInscricaoCursoViewState extends State<HomeClienteInscricaoCursoView> {
  bool _editandoDados = false;

  final _nomeController = TextEditingController(text: 'Nome Sobrenome');
  final _emailController = TextEditingController(text: 'email@exemplo.com');
  final _telefoneController = TextEditingController(text: '912345678');

  int _modoAcessoSelecionado = 0; // 0 imediato, 1 agendar
  DateTime? _dataSelecionada;

  bool _aceitouTermos = false;

  final double _valorCurso = 120;
  final double _descontoEspecial = 20;
  double get _valorFinal => _valorCurso - _descontoEspecial;

  List<DateTime> get _datasDisponiveis {
    final now = DateTime.now();
    final list = <DateTime>[];
    DateTime d = DateTime(now.year, now.month, now.day);
    while (list.length < 8) {
      d = d.add(const Duration(days: 1));
      final wd = d.weekday;
      if (wd == DateTime.monday || wd == DateTime.tuesday) {
        list.add(d);
      }
    }
    return list;
  }

  void _confirmarInscricao() {
    if (!_aceitouTermos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você precisa aceitar os termos.')),
      );
      return;
    }
    if (_modoAcessoSelecionado == 1 && _dataSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione uma data para agendar início.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Inscrição confirmada! (em breve)')),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  String _fmt(DateTime d) {
    const months = {
      1: 'Jan', 2: 'Fev', 3: 'Mar', 4: 'Abr', 5: 'Mai', 6: 'Jun',
      7: 'Jul', 8: 'Ago', 9: 'Set', 10: 'Out', 11: 'Nov', 12: 'Dez',
    };
    return '${d.day} ${months[d.month]}';
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final course = widget.course;

    final descriptionSimple = course.description.length > 110
        ? '${course.description.substring(0, 110)}...'
        : course.description;

    final left = _InscricaoLeftCard(
      course: course,
      editandoDados: _editandoDados,
      modoAcessoSelecionado: _modoAcessoSelecionado,
      dataSelecionada: _dataSelecionada,
      datasDisponiveis: _datasDisponiveis,
      aceitouTermos: _aceitouTermos,
      nomeController: _nomeController,
      emailController: _emailController,
      telefoneController: _telefoneController,
      onToggleEdit: () => setState(() => _editandoDados = !_editandoDados),
      onChangeModoAcesso: (v) {
        setState(() {
          _modoAcessoSelecionado = v;
          if (v == 0) _dataSelecionada = null;
        });
      },
      onSelectData: (d) => setState(() => _dataSelecionada = d),
      onToggleAceitouTermos: (v) => setState(() => _aceitouTermos = v),
      onConfirm: _confirmarInscricao,
    );

    final right = _InscricaoResumoCard(
      course: course,
      descriptionSimple: descriptionSimple,
      valorCurso: _valorCurso,
      descontoEspecial: _descontoEspecial,
      valorFinal: _valorFinal,
      aceitouTermos: _aceitouTermos,
      onConfirm: _confirmarInscricao,
    );

    if (isMobile) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.96),
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text('Inscrição'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              children: [
                left,
                const SizedBox(height: 14),
                right,
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Inscrição'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = constraints.maxWidth;
              final leftW = maxW * 0.70; // 7/3
              final rightW = maxW * 0.30;

              // Usa Expanded em vez de SizedBox com largura fixa para evitar
              // overflow quando a composição do layout (padding/textos) não
              // cabe perfeitamente no "rightW" calculado.
              if (maxW < 1100) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: maxW, child: left),
                    const SizedBox(height: 14),
                    SizedBox(width: maxW, child: right),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: left),
                  const SizedBox(width: 14),
                  Expanded(flex: 3, child: right),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InscricaoLeftCard extends StatelessWidget {
  final _Course course;
  final bool editandoDados;
  final int modoAcessoSelecionado;
  final DateTime? dataSelecionada;
  final List<DateTime> datasDisponiveis;
  final bool aceitouTermos;

  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;

  final VoidCallback onToggleEdit;
  final ValueChanged<int> onChangeModoAcesso;
  final ValueChanged<DateTime> onSelectData;
  final ValueChanged<bool> onToggleAceitouTermos;
  final VoidCallback onConfirm;

  const _InscricaoLeftCard({
    required this.course,
    required this.editandoDados,
    required this.modoAcessoSelecionado,
    required this.dataSelecionada,
    required this.datasDisponiveis,
    required this.aceitouTermos,
    required this.nomeController,
    required this.emailController,
    required this.telefoneController,
    required this.onToggleEdit,
    required this.onChangeModoAcesso,
    required this.onSelectData,
    required this.onToggleAceitouTermos,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Card(
          title: 'Confirmação de dados',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _Field(
                      label: 'Nome completo',
                      controller: nomeController,
                      enabled: editandoDados,
                      keyboardType: TextInputType.name,
                      icon: Icons.person_outline_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Field(
                      label: 'Email',
                      controller: emailController,
                      enabled: editandoDados,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.mail_outline_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Field(
                      label: 'Número de telemóvel',
                      controller: telefoneController,
                      enabled: editandoDados,
                      keyboardType: TextInputType.phone,
                      icon: Icons.phone_android_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onToggleEdit,
                  icon: Icon(
                    editandoDados ? Icons.check_rounded : Icons.edit_outlined,
                    color: AppColors.primary,
                  ),
                  label: Text(
                    editandoDados ? 'Concluir' : 'Editar',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _Card(
          title: 'Forma de acesso',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AccessOption(
                selected: modoAcessoSelecionado == 0,
                title: 'Acesso imediato',
                description:
                    'Receba os materiais e comece sua formação no mesmo dia (em breve).',
                onTap: () => onChangeModoAcesso(0),
                icon: Icons.play_circle_outline_rounded,
              ),
              const SizedBox(height: 12),
              _AccessOption(
                selected: modoAcessoSelecionado == 1,
                title: 'Agendar início',
                description: 'Escolha uma data disponível para iniciar sua formação.',
                onTap: () => onChangeModoAcesso(1),
                icon: Icons.calendar_month_outlined,
              ),
              if (modoAcessoSelecionado == 1) ...[
                const SizedBox(height: 12),
                _DatePickerChipRow(
                  selected: dataSelecionada,
                  dates: datasDisponiveis,
                  onSelected: onSelectData,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),
        _Card(
          title: 'Termos de Compromisso',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.14),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    _TermLine(text: '1) Eu entendo que este é um processo de inscrição (em breve).'),
                    _TermLine(text: '2) Eu concordo em receber comunicação relacionada à minha formação.'),
                    _TermLine(text: '3) Eu confirmo que os dados fornecidos são corretos.'),
                    _TermLine(text: '4) Eu entendo que a confirmação final pode depender de validação.'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: aceitouTermos,
                onChanged: (v) => onToggleAceitouTermos(v ?? false),
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  'Li e aceito os termos de compromisso.',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InscricaoResumoCard extends StatelessWidget {
  final _Course course;
  final String descriptionSimple;
  final double valorCurso;
  final double descontoEspecial;
  final double valorFinal;
  final bool aceitouTermos;
  final VoidCallback onConfirm;

  const _InscricaoResumoCard({
    required this.course,
    required this.descriptionSimple,
    required this.valorCurso,
    required this.descontoEspecial,
    required this.valorFinal,
    required this.aceitouTermos,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cabeçalho sem Row
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 6,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.22),
                    width: 1,
                  ),
                ),
                child: const Icon(Icons.school_rounded,
                    color: AppColors.primary, size: 22),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: Text(
                  course.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            descriptionSimple,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
          ),

          const SizedBox(height: 10),
          Text(
            'Carga horária: ${course.duration}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),

          const SizedBox(height: 14),
          Divider(color: AppColors.primary.withOpacity(0.22)),
          const SizedBox(height: 12),

          _MoneyRow(
            label: 'Valor do curso',
            value: '€ ${valorCurso.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 8),

          _MoneyRow(
            label: 'Desconto especial',
            value: '-€ ${descontoEspecial.toStringAsFixed(0)}',
            valueColor: AppColors.primary,
          ),
          const SizedBox(height: 8),

          _MoneyRow(
            label: 'Valor final',
            value: '€ ${valorFinal.toStringAsFixed(0)}',
            valueStrong: true,
          ),

          const SizedBox(height: 12),
          Divider(color: AppColors.primary.withOpacity(0.22)),
          const SizedBox(height: 12),

          // Botão centralizado sem Row
          SizedBox(
            height: 52,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onConfirm,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Confirmar inscrição',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          Text(
            'Vamos entrar em ctt para dar o seguimento da sua formação.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),

          if (!aceitouTermos)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Aceite os termos para confirmar.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

class _MoneyRow extends StatelessWidget {
  final String label;
  final String value;
  final bool valueStrong;
  final Color? valueColor;

  const _MoneyRow({
    required this.label,
    required this.value,
    this.valueStrong = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight:
                      valueStrong ? FontWeight.w900 : FontWeight.w800,
                  color: valueColor ?? AppColors.textPrimary,
                ),
          ),
        ),
      ],
    );
  }
}

class _TermLine extends StatelessWidget {
  final String text;

  const _TermLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final Widget child;

  const _Card({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 10),
          ),
        ],
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

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final IconData icon;

  const _Field({
    required this.label,
    required this.controller,
    required this.enabled,
    required this.keyboardType,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: AppColors.primary),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.primary.withOpacity(0.22),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.primary.withOpacity(0.16),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.primary.withOpacity(0.22),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AccessOption extends StatelessWidget {
  final bool selected;
  final String title;
  final String description;
  final VoidCallback onTap;
  final IconData icon;

  const _AccessOption({
    required this.selected,
    required this.title,
    required this.description,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.10) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppColors.primary.withOpacity(0.34)
                : AppColors.primary.withOpacity(0.14),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: selected ? AppColors.primary : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? AppColors.primary : AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _DatePickerChipRow extends StatelessWidget {
  final DateTime? selected;
  final List<DateTime> dates;
  final ValueChanged<DateTime> onSelected;

  const _DatePickerChipRow({
    required this.selected,
    required this.dates,
    required this.onSelected,
  });

  String _fmt(DateTime d) {
    const months = {
      1: 'Jan', 2: 'Fev', 3: 'Mar', 4: 'Abr', 5: 'Mai', 6: 'Jun',
      7: 'Jul', 8: 'Ago', 9: 'Set', 10: 'Out', 11: 'Nov', 12: 'Dez',
    };
    return '${d.day} ${months[d.month]}';
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final d in dates)
          ChoiceChip(
            label: Text(_fmt(d)),
            selected: selected != null && _isSameDay(selected!, d),
            selectedColor: AppColors.primary.withOpacity(0.16),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: selected != null && _isSameDay(selected!, d)
                    ? AppColors.primary.withOpacity(0.55)
                    : AppColors.primary.withOpacity(0.18),
              ),
            ),
            onSelected: (_) => onSelected(d),
          )
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
                  child: const Icon(Icons.school_rounded,
                      color: AppColors.primary),
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
