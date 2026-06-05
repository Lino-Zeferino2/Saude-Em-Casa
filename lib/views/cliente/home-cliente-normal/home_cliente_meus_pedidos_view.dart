import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../components/app_footer.dart';

class HomeClienteMeusPedidosView extends StatefulWidget {
  const HomeClienteMeusPedidosView({super.key});

  @override
  State<HomeClienteMeusPedidosView> createState() => _HomeClienteMeusPedidosViewState();
}

enum PedidoNatureza { cursos, consulta, receitas, outros }

enum PedidoStatus { pendente, confirmado, em_andamento, finalizado, cancelado }

class _Pedido {
  final String id;
  final PedidoNatureza natureza;
  final PedidoStatus status;
  final String titulo;
  final String descricao;
  final DateTime criadoEm;

  _Pedido({
    required this.id,
    required this.natureza,
    required this.status,
    required this.titulo,
    required this.descricao,
    required this.criadoEm,
  });
}

class _HomeClienteMeusPedidosViewState extends State<HomeClienteMeusPedidosView> {
  PedidoNatureza? _naturezaFiltro;
  PedidoStatus? _statusFiltro;
  String _searchQuery = '';

  late final List<_Pedido> _allPedidos;

  @override
  void initState() {
    super.initState();

    _allPedidos = [
      _Pedido(
        id: 'PED-1024',
        natureza: PedidoNatureza.cursos,
        status: PedidoStatus.confirmado,
        titulo: 'Curso: Cuidados ao Idoso (Módulo 1)',
        descricao: 'Acesso liberado para sua conta. Próxima aula em 3 dias.',
        criadoEm: DateTime.now().subtract(const Duration(days: 4)),
      ),
      _Pedido(
        id: 'PED-1091',
        natureza: PedidoNatureza.consulta,
        status: PedidoStatus.em_andamento,
        titulo: 'Consulta: Enfermagem domiciliar',
        descricao: 'Profissional confirmado. Visita agendada para amanhã.',
        criadoEm: DateTime.now().subtract(const Duration(days: 2)),
      ),
      _Pedido(
        id: 'PED-1207',
        natureza: PedidoNatureza.receitas,
        status: PedidoStatus.pendente,
        titulo: 'Receita: Terapia da Fala (orientações)',
        descricao: 'Aguardando validação do profissional.',
        criadoEm: DateTime.now().subtract(const Duration(days: 1)),
      ),
      _Pedido(
        id: 'PED-1216',
        natureza: PedidoNatureza.outros,
        status: PedidoStatus.finalizado,
        titulo: 'Apoio: Primeiros Socorros (checklist)',
        descricao: 'Conteúdo entregue. Você pode revisar quando quiser.',
        criadoEm: DateTime.now().subtract(const Duration(days: 9)),
      ),
      _Pedido(
        id: 'PED-1290',
        natureza: PedidoNatureza.cursos,
        status: PedidoStatus.cancelado,
        titulo: 'Curso: Fisioterapia (Trilha Básica)',
        descricao: 'Solicitação cancelada pelo usuário. Caso queira, reenvie.',
        criadoEm: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
  }

  bool _matches(_Pedido p) {
    if (_naturezaFiltro != null && p.natureza != _naturezaFiltro) return false;
    if (_statusFiltro != null && p.status != _statusFiltro) return false;

    final q = _searchQuery.trim().toLowerCase();
    if (q.isNotEmpty) {
      final haystack = '${p.id} ${p.titulo} ${p.descricao}'.toLowerCase();
      if (!haystack.contains(q)) return false;
    }

    return true;
  }

  String _naturezaLabel(PedidoNatureza n) {
    switch (n) {
      case PedidoNatureza.cursos:
        return 'Cursos';
      case PedidoNatureza.consulta:
        return 'Consultas';
      case PedidoNatureza.receitas:
        return 'Receitas';
      case PedidoNatureza.outros:
        return 'Outros';
    }
  }

  String _statusLabel(PedidoStatus s) {
    switch (s) {
      case PedidoStatus.pendente:
        return 'Pendente';
      case PedidoStatus.confirmado:
        return 'Confirmado';
      case PedidoStatus.em_andamento:
        return 'Em andamento';
      case PedidoStatus.finalizado:
        return 'Finalizado';
      case PedidoStatus.cancelado:
        return 'Cancelado';
    }
  }

  Color _statusColor(PedidoStatus s, BuildContext context) {
    final primary = AppColors.primary;
    switch (s) {
      case PedidoStatus.pendente:
        return primary.withOpacity(0.65);
      case PedidoStatus.confirmado:
        return const Color(0xFF1C9B5A); // green-ish
      case PedidoStatus.em_andamento:
        return const Color(0xFFFFA000); // amber
      case PedidoStatus.finalizado:
        return const Color(0xFF2E7D32); // dark green
      case PedidoStatus.cancelado:
        return const Color(0xFFE53935); // red
    }
  }

  IconData _naturezaIcon(PedidoNatureza n) {
    switch (n) {
      case PedidoNatureza.cursos:
        return Icons.school_rounded;
      case PedidoNatureza.consulta:
        return Icons.medical_services_rounded;
      case PedidoNatureza.receitas:
        return Icons.receipt_long_rounded;
      case PedidoNatureza.outros:
        return Icons.assignment_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pedidosFiltrados = _allPedidos.where(_matches).toList();

    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Text(
          'Meus Pedidos',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Limpar filtros',
            icon: const Icon(Icons.filter_alt_off_rounded),
            onPressed: () {
              setState(() {
                _naturezaFiltro = null;
                _statusFiltro = null;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = isMobile ? 16.0 : 24.0;

            // Barra de pesquisa

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 14.0 : 18.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    onChanged: (value) =>
                        setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Pesquisar por ID, título ou descrição',
                      prefixIcon: const Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.92),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.primary.withOpacity(0.18),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.primary.withOpacity(0.18),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.primary.withOpacity(0.35),
                          width: 1.5,
                        ),
                      ),
                      suffixIcon: _searchQuery.trim().isNotEmpty
                          ? IconButton(
                              tooltip: 'Limpar pesquisa',
                              onPressed: () =>
                                  setState(() => _searchQuery = ''),
                              icon: const Icon(Icons.close_rounded),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _FiltroChips(
                    isMobile: isMobile,
                    naturezas: PedidoNatureza.values,
                    selecionado: _naturezaFiltro,
                    labelBuilder: (n) => _naturezaLabel(n),
                    iconBuilder: (n) => _naturezaIcon(n),
                    onChanged: (n) => setState(() => _naturezaFiltro = n),
                  ),
                  const SizedBox(height: 10),
                  _FiltroChips(
                    isMobile: isMobile,
                    naturezas: PedidoStatus.values,
                    selecionado: _statusFiltro,
                    labelBuilder: (s) => _statusLabel(s),
                    iconBuilder: (_) => Icons.circle_rounded,
                    onChanged: (s) => setState(() => _statusFiltro = s),
                    colorize: (status) =>
                        _statusColor(status, context),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: pedidosFiltrados.isEmpty
                        ? _EmptyState(
                            title: 'Nenhum pedido encontrado',
                            subtitle:
                                'Tente ajustar os filtros ou a pesquisa.',
                          )
                        : _PedidoList(
                            pedidos: pedidosFiltrados,
                            statusColor: (s) => _statusColor(s, context),
                            naturezaIcon: _naturezaIcon,
                            naturezaLabel: _naturezaLabel,
                            statusLabel: _statusLabel,
                          ),
                  ),
                  
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FiltroChips<T> extends StatelessWidget {
  final bool isMobile;
  final List<T> naturezas;
  final T? selecionado;
  final String Function(T) labelBuilder;
  final IconData Function(T) iconBuilder;
  final void Function(T?) onChanged;
  final Color Function(T)? colorize;

  const _FiltroChips({
    required this.isMobile,
    required this.naturezas,
    required this.selecionado,
    required this.labelBuilder,
    required this.iconBuilder,
    required this.onChanged,
    this.colorize,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width;
    final wrapSpacing = isMobile ? 10.0 : 12.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 0),
          for (final item in naturezas) ...[
            Padding(
              padding: EdgeInsets.only(right: wrapSpacing),
              child: ChoiceChip(
                avatar: Icon(
                  iconBuilder(item),
                  size: 18,
                  color: (colorize == null || selecionado != item)
                      ? null
                      : (selecionado == item ? colorize!(item) : null),
                ),
                label: Text(labelBuilder(item)),
                selected: selecionado == item,
                selectedColor: colorize == null
                    ? Colors.white.withOpacity(0.22)
                    : (colorize!(item)).withOpacity(0.16),
                backgroundColor: Colors.white.withOpacity(0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                  side: BorderSide(
                    color: selecionado == item
                        ? (colorize == null ? AppColors.primary : colorize!(item))
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                onSelected: (_) => onChanged(item),
              ),
            ),
          ],
          // chip "todos"
          ChoiceChip(
            avatar: const Icon(Icons.grid_view_rounded, size: 18),
            label: const Text('Todos'),
            selected: selecionado == null,
            onSelected: (_) => onChanged(null),
            selectedColor: Colors.white.withOpacity(0.22),
            backgroundColor: Colors.white.withOpacity(0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
              side: BorderSide(
                color: selecionado == null ? AppColors.primary : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          if (maxWidth < 600) const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _PedidoList extends StatelessWidget {
  final List<_Pedido> pedidos;
  final Color Function(PedidoStatus) statusColor;
  final IconData Function(PedidoNatureza) naturezaIcon;
  final String Function(PedidoNatureza) naturezaLabel;
  final String Function(PedidoStatus) statusLabel;

  const _PedidoList({
    required this.pedidos,
    required this.statusColor,
    required this.naturezaIcon,
    required this.naturezaLabel,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: pedidos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final p = pedidos[index];

        final pillColor = statusColor(p.status).withOpacity(0.16);
        final pillTextColor = statusColor(p.status);

        return Card(
          color: Colors.white.withOpacity(0.92),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.primary.withOpacity(0.20)),
                  ),
                  child: Icon(
                    naturezaIcon(p.natureza),
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              p.titulo,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p.descricao,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: pillColor,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: statusColor(p.status).withOpacity(0.35),
                              ),
                            ),
                            child: Text(
                              statusLabel(p.status),
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: pillTextColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.60),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.20),
                              ),
                            ),
                            child: Text(
                              naturezaLabel(p.natureza),
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ),
                          Text(
                            '• ${_formatDate(p.criadoEm)}',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Detalhes (em breve)',
                  icon: const Icon(Icons.chevron_right_rounded),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Detalhes em breve: ${p.id}')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day/$month';
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_rounded,
              size: 54,
              color: AppColors.primary.withOpacity(0.75),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
