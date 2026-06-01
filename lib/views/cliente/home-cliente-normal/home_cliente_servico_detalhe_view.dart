import 'package:flutter/material.dart';

import '../../../model/home_cliente_servicos_model.dart';
import '../../../theme/app_colors.dart';

import '../components/app_footer.dart';

class HomeClienteServicoDetalheView extends StatelessWidget {
  final ServiceItem service;

  const HomeClienteServicoDetalheView({
    super.key,
    required this.service,
  });

  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = _isMobile(context);

    final List<String> beneficios = [
      'Atendimento humanizado e acompanhamento contínuo',
      'Orientação para cuidados no domicílio',
      'Avaliação inicial e plano de acompanhamento',
      'Registro e comunicação com a família (quando aplicável)',
      'Atenção às necessidades específicas do paciente',
      'Rotina estruturada e acompanhamento de evolução',
      'Suporte educativo para cuidadores e familiares',
      'Reavaliação periódica e ajustes no plano quando necessário',
    ];

    final Widget esquerda = _DetalheEsquerda(
      service: service,
      beneficios: beneficios,
    );

    final Widget direita = _DetalheDireita(
      isMobile: isMobile,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Detalhe do Serviço'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isMobile)
                const SizedBox(height: 4)
              else
                const SizedBox(height: 0),
              isMobile
                  ? Column(
                      children: [
                        esquerda,
                        const SizedBox(height: 14),
                        direita,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: esquerda,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 36),
                            child: direita,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 28),
              _RelacionadosSection(
                isMobile: isMobile,
              ),
              const SizedBox(height: 36),
              AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetalheEsquerda extends StatelessWidget {
  final ServiceItem service;
  final List<String> beneficios;

  const _DetalheEsquerda({
    required this.service,
    required this.beneficios,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          service.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                fontSize: isMobileLike(context) ? 20 : 22,
              ),
        ),
        const SizedBox(height: 12),
        _CardBrancoComSombra(
          child: SizedBox(
            height: 160,
            child: Center(
              child: Icon(
                service.icon,
                size: 56,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _CardBrancoComSombra(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sobre o serviço',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  service.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _CardBrancoComSombra(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Benefícios do atendimento',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isWeb = constraints.maxWidth >= 700;
                    if (!isWeb) {
                      return Column(
                        children: beneficios.map(
                          (b) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF2ECC71),
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    b,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                          height: 1.35,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                      );
                    }

                    // Web/desktop: 2 colunas dentro do mesmo card
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: beneficios.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                       // mainAxisSpacing: 4,
                        crossAxisSpacing: 1,
                        childAspectRatio: 10.2,
                      ),
                      itemBuilder: (context, index) {
                        final b = beneficios[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF2ECC71),
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                b,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.textSecondary,
                                      height: 1.35,
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool isMobileLike(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;
}

class _DetalheDireita extends StatelessWidget {
  final bool isMobile;

  const _DetalheDireita({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return _CardBrancoComSombra(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            _InvestmentCardGrey(),
            const SizedBox(height: 12),
            _InfoCard(
              title: 'Frequência',
              body:
                  'Frequência é ou não flexível (diária, semanal, ou sob demanda).',
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: 'Profissional verificada',
              body: 'Equipe com profissionais avaliados e verificados.',
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Solicitação (em breve)'),
                    ),
                  );
                },
                child: const Text(
                  'Solicitar serviço',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _PreAvaliacaoAlert(),
            const SizedBox(height: 10),
            Text(
              'Se não houver compromisso imediato, a nossa equipe entra em contacto para triagem apenas sem compromisso.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


// ignore: unused_element
class _InfoRow extends StatelessWidget {
  final String title;
  final String body;

  const _InfoRow({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
        ),
      ],
    );
  }
}

class _InvestmentCardGrey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.22),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Investimento',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'A partir de 10.000 KZ',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Valores podem variar conforme o serviço e frequência.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}


class _InfoCard extends StatelessWidget {
  final String title;
  final String body;

  const _InfoCard({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return _CardBrancoComSombra(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreAvaliacaoAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.red.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aviso importante',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Alguns dos serviços podem exigir avaliação médica antes de iniciar. Se você já tiver essa avaliação, ajude-nos levando a informação para nossa equipe.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.35,
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

class _CardBrancoComSombra extends StatelessWidget {
  final Widget child;

  const _CardBrancoComSombra({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.16),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _RelacionadosSection extends StatelessWidget {
  final bool isMobile;

  const _RelacionadosSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final List<ServiceItem> services = HomeClienteServicosModel.services;

    final int count = isMobile ? 2 : 5;
    final related = services.take(count).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Serviços relacionados',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: related.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : 6,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 105,
          ),
          itemBuilder: (context, index) {
            final s = related[index];
            return _RelatedServiceTile(service: s);
          },
        ),
      ],
    );
  }
}

class _RelatedServiceTile extends StatelessWidget {
  final ServiceItem service;

  const _RelatedServiceTile({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return _CardBrancoComSombra(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  HomeClienteServicoDetalheView(service: service),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Center(
                child: Icon(
                  service.icon,
                  size: 24,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                service.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                      fontSize: 11,
                    ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Ver detalhes',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                        fontSize: 10,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
