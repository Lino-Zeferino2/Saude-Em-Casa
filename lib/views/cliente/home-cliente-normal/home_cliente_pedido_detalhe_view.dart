import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

enum PedidoNaturezaDetalhe { cursos, consulta, receitas, outros }
enum PedidoStatusDetalhe {
  recebido,
  em_analise,
  profissional_em_selecao,
  profissional_atribuido,
  agendamento_confirmado,
  profissional_em_deslocamento,
  atendimento_em_curso,
  atendimento_concluido,

  // medicamentos / receitas
  receita_validada,
  farmacia_selecionada,
  medicamentos_separados,
  preparacao_entrega,
  entregador_deslocamento,
  entregue,
  pedido_concluido,

  // cursos/formacao
  inscricao_realizada,
  pagamento_confirmado,
  curso_disponivel,
  curso_em_andamento,
  avaliacao_concluida,
  certificado_emitido,
  curso_concluido,

  // alternativos (cancel)
  reagendamento_solicitado,
  cancelado_cliente,
  cancelado_empresa,

  // consulta médica
  analise_clinica,
  medico_atribuido,
  consulta_agendada,
  medico_em_deslocamento,
  consulta_em_andamento,
  relatorio_emitido,
  consulta_concluida,

  // medicamentos alternativos
  receita_rejeitada,
  medicamento_indisponivel,
  aguardando_substituicao,

  // cursos alternativos
  pagamento_pendente,
  inscricao_cancelada,

  // parceiros/agendamento
  parceiro_contactado,
  horario_negociacao,
  lembrete_enviado,
  atendimento_realizado,
  processo_concluido,
  parceiro_indisponivel,

  // avaliação inicial
  equipa_analisando,
  visita_agendada,
  avaliacao_realizada,
  plano_cuidados_elaborado,
  plano_apresentado,
  processo_concluido_inicial,

  // apoio familiar
  solicitacao_recebida,
  especialista_atribuido,
  sessao_agendada,
  sessao_realizada,
  plano_acompanhamento_criado,
  acompanhamento_ativo,
}

class HomeClientePedidoDetalheView extends StatelessWidget {
  const HomeClientePedidoDetalheView({
    super.key,
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.natureza,
    required this.status,
  });

  final String id;
  final String titulo;
  final String descricao;

  final PedidoNaturezaDetalhe natureza;
  final PedidoStatusDetalhe status;

  @override
  Widget build(BuildContext context) {
    final steps = _stepsFor(natureza, status);
    final currentIndex = _currentIndex(steps, status);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 6,
        title: const Text('Detalhe do pedido'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWeb = constraints.maxWidth >= 900;
            final horizontalPad = isWeb ? 28.0 : 16.0;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: isWeb ? 18 : 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PedidoHeaderCard(
                    id: id,
                    titulo: titulo,
                    statusLabel: _statusText(status),
                    statusColor: _statusColor(status),
                  ),
                  const SizedBox(height: 16),

                  if (isWeb)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  _ProgressCard(
                                    steps: steps,
                                    currentIndex: currentIndex,
                                  ),
                                  const SizedBox(height: 16),
                                  _SaudeEmCasaCard(
                                    ratingCount: 128,
                                    ratingValue: 4.8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _LocationCard(
                                    title: 'Localização do serviço',
                                    subtitle: 'Profissional • Centro clínico (exemplo)',
                                  ),
                                  const SizedBox(height: 16),
                                  _ResumoPedidoCard(
                                    naturezaText: _naturezaText(natureza),
                                    descricao: descricao,
                                    valorTotal: 'Kz 12.500,00',
                                    valorTaxa: 'Kz 1.200,00',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _ProgressCard(
                              steps: steps,
                              currentIndex: currentIndex,
                            ),
                            const SizedBox(height: 16),
                            _SaudeEmCasaCard(
                              ratingCount: 128,
                              ratingValue: 4.8,
                            ),
                            const SizedBox(height: 16),
                            _LocationCard(
                              title: 'Localização do serviço',
                              subtitle: 'Profissional • Centro clínico (exemplo)',
                            ),
                            const SizedBox(height: 16),
                            _ResumoPedidoCard(
                              naturezaText: _naturezaText(natureza),
                              descricao: descricao,
                              valorTotal: 'Kz 12.500,00',
                              valorTaxa: 'Kz 1.200,00',
                            ),
                            const SizedBox(height: 22),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> _stepsFor(PedidoNaturezaDetalhe n, PedidoStatusDetalhe current) {
    // Regras simples e “modulares”:
    // - Cada natureza define um conjunto base de steps
    // - O passo atual tenta existir no array; senão, usa uma lista genérica
    switch (n) {
      case PedidoNaturezaDetalhe.consulta:
        return [
          'Pedido recebido',
          'Em análise clínica',
          'Médico atribuído',
          'Consulta agendada',
          'Médico em deslocamento',
          'Consulta em andamento',
          'Relatório emitido',
          'Consulta concluída',
        ];
      case PedidoNaturezaDetalhe.receitas:
        return [
          'Pedido recebido',
          'Receita validada',
          'Farmácia selecionada',
          'Medicamentos separados',
          'Em preparação para entrega',
          'Entregador em deslocamento',
          'Entregue',
          'Pedido concluído',
        ];
      case PedidoNaturezaDetalhe.cursos:
        return [
          'Inscrição realizada',
          'Pagamento confirmado',
          'Curso disponível',
          'Em andamento',
          'Avaliação concluída',
          'Certificado emitido',
          'Curso concluído',
        ];
      case PedidoNaturezaDetalhe.outros:
      default:
        return [
          'Pedido recebido',
          'Equipa a analisar o caso',
          'Profissional atribuído',
          'Visita agendada',
          'Avaliação realizada',
          'Plano de cuidados elaborado',
          'Plano apresentado ao cliente',
          'Processo concluído',
        ];
    }
  }

  int _currentIndex(List<String> steps, PedidoStatusDetalhe status) {
    final label = _statusText(status);
    final idx = steps.indexWhere((s) => s == label);
    return idx >= 0 ? idx : 0;
  }

  String _naturezaText(PedidoNaturezaDetalhe n) {
    switch (n) {
      case PedidoNaturezaDetalhe.cursos:
        return 'Cursos e Formação';
      case PedidoNaturezaDetalhe.consulta:
        return 'Consulta Médica Domiciliar';
      case PedidoNaturezaDetalhe.receitas:
        return 'Pedido de Medicamentos';
      case PedidoNaturezaDetalhe.outros:
        return 'Apoio/Outros';
    }
  }

  String _statusText(PedidoStatusDetalhe s) {
    switch (s) {
      case PedidoStatusDetalhe.recebido:
        return 'Pedido recebido';
      case PedidoStatusDetalhe.em_analise:
        return 'Em análise';
      case PedidoStatusDetalhe.profissional_em_selecao:
        return 'Profissional em seleção';
      case PedidoStatusDetalhe.profissional_atribuido:
        return 'Profissional atribuído';
      case PedidoStatusDetalhe.agendamento_confirmado:
        return 'Agendamento confirmado';
      case PedidoStatusDetalhe.profissional_em_deslocamento:
        return 'Profissional em deslocamento';
      case PedidoStatusDetalhe.atendimento_em_curso:
        return 'Atendimento em curso';
      case PedidoStatusDetalhe.atendimento_concluido:
        return 'Atendimento concluído';

      case PedidoStatusDetalhe.receita_validada:
        return 'Receita validada';
      case PedidoStatusDetalhe.farmacia_selecionada:
        return 'Farmácia selecionada';
      case PedidoStatusDetalhe.medicamentos_separados:
        return 'Medicamentos separados';
      case PedidoStatusDetalhe.preparacao_entrega:
        return 'Em preparação para entrega';
      case PedidoStatusDetalhe.entregador_deslocamento:
        return 'Entregador em deslocamento';
      case PedidoStatusDetalhe.entregue:
        return 'Entregue';
      case PedidoStatusDetalhe.pedido_concluido:
        return 'Pedido concluído';

      case PedidoStatusDetalhe.inscricao_realizada:
        return 'Inscrição realizada';
      case PedidoStatusDetalhe.pagamento_confirmado:
        return 'Pagamento confirmado';
      case PedidoStatusDetalhe.curso_disponivel:
        return 'Curso disponível';
      case PedidoStatusDetalhe.curso_em_andamento:
        return 'Em andamento';
      case PedidoStatusDetalhe.avaliacao_concluida:
        return 'Avaliação concluída';
      case PedidoStatusDetalhe.certificado_emitido:
        return 'Certificado emitido';
      case PedidoStatusDetalhe.curso_concluido:
        return 'Curso concluído';

      case PedidoStatusDetalhe.analise_clinica:
        return 'Em análise clínica';
      case PedidoStatusDetalhe.medico_atribuido:
        return 'Médico atribuído';
      case PedidoStatusDetalhe.consulta_agendada:
        return 'Consulta agendada';
      case PedidoStatusDetalhe.medico_em_deslocamento:
        return 'Médico em deslocamento';
      case PedidoStatusDetalhe.consulta_em_andamento:
        return 'Consulta em andamento';
      case PedidoStatusDetalhe.relatorio_emitido:
        return 'Relatório emitido';
      case PedidoStatusDetalhe.consulta_concluida:
        return 'Consulta concluída';

      case PedidoStatusDetalhe.cancelado_cliente:
        return 'Cancelado pelo cliente';
      case PedidoStatusDetalhe.cancelado_empresa:
        return 'Cancelado pela empresa';

      // fallback
      default:
        return 'Em análise';
    }
  }

  Color _statusColor(PedidoStatusDetalhe s) {
    switch (s) {
      case PedidoStatusDetalhe.recebido:
      case PedidoStatusDetalhe.em_analise:
      case PedidoStatusDetalhe.receita_rejeitada:
        return AppColors.primary.withOpacity(0.65);
      case PedidoStatusDetalhe.profissional_atribuido:
      case PedidoStatusDetalhe.atendimento_concluido:
      case PedidoStatusDetalhe.consulta_concluida:
      case PedidoStatusDetalhe.pedido_concluido:
      case PedidoStatusDetalhe.curso_concluido:
        return const Color(0xFF2E7D32);
      case PedidoStatusDetalhe.cancelado_cliente:
      case PedidoStatusDetalhe.cancelado_empresa:
      default:
        return const Color(0xFFE53935);
    }
  }
}

class _PedidoHeaderCard extends StatelessWidget {
  const _PedidoHeaderCard({
    required this.id,
    required this.titulo,
    required this.statusLabel,
    required this.statusColor,
  });

  final String id;
  final String titulo;
  final String statusLabel;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.92),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withOpacity(0.20)),
              ),
              child: const Icon(Icons.receipt_long_rounded, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código do pedido: $id',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  _StatusPill(text: statusLabel, color: statusColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: color,
            ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.steps,
    required this.currentIndex,
  });

  final List<String> steps;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.92),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.trending_up_rounded, color: AppColors.primary),
                const SizedBox(width: 10),
                Text(
                  'Progresso do pedido',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                for (int i = 0; i < steps.length; i++)
                  _StepRow(
                    title: steps[i],
                    isDone: i < currentIndex,
                    isCurrent: i == currentIndex,
                    isLast: i == steps.length - 1,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.title,
    required this.isDone,
    required this.isCurrent,
    required this.isLast,
  });

  final String title;
  final bool isDone;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    const doneColor = Color(0xFF2E7D32);
    final baseBlue = AppColors.primary;

    final circleFill = isCurrent ? baseBlue : (isDone ? doneColor : baseBlue);
    final circleBorder = isCurrent ? baseBlue.withOpacity(0.45) : (isDone ? doneColor.withOpacity(0.45) : baseBlue.withOpacity(0.45));

    // Para “barras ligadas”: desenhar uma haste maior (abaixo do círculo)
    // exceto no último passo.
    final connectorColor = (isDone || isCurrent) ? doneColor : baseBlue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circleFill,
                    border: Border.all(
                      color: circleBorder,
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    // haste contínua (ligação) até o próximo passo
                    height: 30,
                    width: 2,
                    margin: const EdgeInsets.only(top: 6),
                    color: connectorColor.withOpacity(isDone || isCurrent ? 0.70 : 0.25),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w800,
                    color: isDone ? const Color(0xFF1B1B1B) : AppColors.textPrimary,
                    height: 1.3,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SaudeEmCasaCard extends StatelessWidget {
  const _SaudeEmCasaCard({
    required this.ratingCount,
    required this.ratingValue,
  });

  final int ratingCount;
  final double ratingValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.92),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.primary.withOpacity(0.20)),
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(Icons.health_and_safety_outlined, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saúde em Casa',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Color(0xFFFFA000), size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '${ratingValue.toStringAsFixed(1)} • ${ratingCount} avaliações',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.chat_rounded,
                    title: 'WhatsApp',
                    accent: const Color(0xFF1CD760),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Abrir WhatsApp (exemplo)')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.call_rounded,
                    title: 'Ligar',
                    accent: AppColors.primary,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ligar (exemplo)')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.title,
    required this.accent,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: accent.withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Icon(icon, color: accent),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.92),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_rounded, color: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Mapa (imagem em assets/map) com fallback para o desenho fake
            Container(
              height: 550,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.blueGrey.withOpacity(0.12),
                border: Border.all(color: AppColors.primary.withOpacity(0.18)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'map.png',
                      fit: BoxFit.cover,
                      
                      errorBuilder: (_, __, ___) => CustomPaint(
                        painter: _FakeMapPainter(),
                      ),
                      
                    ),
                  ),
                  /*
                  Positioned(
                    left: 26,
                    top: 70,
                    child: _MapPin(color: AppColors.primary),
                  ),
                  Positioned(
                    right: 30,
                    top: 40,
                    child: _MapPin(color: const Color(0xFFFFA000)),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: _FakeRouteOverlay(),
                    ),
                  ),
                  */
                ],
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.directions_rounded, color: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Trajeto estimado (exemplo) • ~ 18 min • 7.3 km',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white.withOpacity(0.9), width: 3),
      ),
    );
  }
}

class _FakeRouteOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _FakeRoutePainter(),
    );
  }
}

class _FakeRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.15, size.height * 0.55);
    path.cubicTo(
      size.width * 0.35,
      size.height * 0.35,
      size.width * 0.60,
      size.height * 0.75,
      size.width * 0.80,
      size.height * 0.32,
    );
    canvas.drawPath(path, paint);

    final dashed = Paint()
      ..color = AppColors.primary.withOpacity(0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    for (int i = 0; i < 12; i++) {
      final t = i / 11;
      final x = _lerp(size.width * 0.15, size.width * 0.80, t);
      final y = _lerp(size.height * 0.55, size.height * 0.32, t);
      canvas.drawCircle(Offset(x, y), 2.2, dashed);
    }
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FakeMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..strokeWidth = 1;

    for (int i = 0; i < 10; i++) {
      final x = size.width * (i / 9);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (int i = 0; i < 6; i++) {
      final y = size.height * (i / 5);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    final dotPaint = Paint()..color = Colors.black.withOpacity(0.06);
    for (int i = 0; i < 60; i++) {
      final x = (size.width * (i % 10)) / 10 + (i % 3) * 2;
      final y = (size.height * (i ~/ 10)) / 6 + (i % 4) * 2;
      canvas.drawCircle(Offset(x, y), 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ResumoPedidoCard extends StatelessWidget {
  const _ResumoPedidoCard({
    required this.naturezaText,
    required this.descricao,
    required this.valorTotal,
    required this.valorTaxa,
  });

  final String naturezaText;
  final String descricao;
  final String valorTotal;
  final String valorTaxa;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.92),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.description_rounded, color: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Resumo do serviço',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _KeyValue(
              icon: Icons.category_rounded,
              label: 'Tipo',
              value: naturezaText,
            ),
            const SizedBox(height: 10),
            Text(
              descricao,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                    fontWeight: FontWeight.w700,
                  ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Divider(color: AppColors.primary.withOpacity(0.18), thickness: 1),
            const SizedBox(height: 12),
            _KeyValue(
              icon: Icons.monetization_on_rounded,
              label: 'Valor total',
              value: valorTotal,
              valueColor: AppColors.primary,
            ),
            const SizedBox(height: 8),
            _KeyValue(
              icon: Icons.local_offer_rounded,
              label: 'Taxa/serviço',
              value: valorTaxa,
              valueColor: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary.withOpacity(0.20)),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: valueColor ?? AppColors.textPrimary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
