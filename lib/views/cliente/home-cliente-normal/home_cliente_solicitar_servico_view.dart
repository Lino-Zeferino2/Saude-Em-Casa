import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../components/app_footer.dart';

class HomeClienteSolicitarServicoView extends StatefulWidget {
  const HomeClienteSolicitarServicoView({super.key});

  @override
  State<HomeClienteSolicitarServicoView> createState() =>
      _HomeClienteSolicitarServicoViewState();
}

class _HomeClienteSolicitarServicoViewState
    extends State<HomeClienteSolicitarServicoView> {
  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;

  // Passo atual: 1 Informações, 2 Tipo de atendimento, 3 Confirmação
  int currentStep = 1;

  // Passo 2: seleção do tipo de atendimento
  // 0 = nenhum, 1 = Atendimento único, 2 = Atendimento recorrente
  int atendimentoSelecionado = 0;

  // Dados placeholders
  String atendimentoTipo = 'Para mim';
  String? familiarSelecionado;

  final List<String> familiares = ['Ana (mãe)', 'João (irmão)', 'Maria (filha)'];

  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _localidadeController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  final TextEditingController _adicionaisController = TextEditingController();

  @override
  void dispose() {
    _enderecoController.dispose();
    _localidadeController.dispose();
    _numeroController.dispose();
    _dataController.dispose();
    _horaController.dispose();
    _adicionaisController.dispose();
    super.dispose();
  }

  bool get _lockedStep1 => currentStep > 1;
  bool get _lockedStep2 => currentStep > 2;

  void _goNext() {
    setState(() {
      if (currentStep == 2) {
        if (atendimentoSelecionado == 0) return;
        currentStep = 3;
        return;
      }

      if (currentStep < 3) {
        currentStep++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Confirmação (em breve)')),
        );
      }
    });
  }

  void _goBack() {
    setState(() {
      if (currentStep > 1) currentStep--;
    });
  }

  String get _stepTitle {
    if (currentStep == 1) return 'Informações';
    if (currentStep == 2) return 'Tipo de atendimento';
    return 'Confirmação';
  }

  @override
  Widget build(BuildContext context) {
    final mobile = _isMobile(context);

    final bool isStep1 = currentStep == 1;
    final bool isStep2 = currentStep == 2;
    final bool isStep3 = currentStep == 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Solicitar serviço'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PageIntro(
                title: 'Solicitar Atendimento',
                description:
                    'Preencher um formulário simples com informações essenciais ajuda a concluir o seu pedido mais rápido.',
              ),
              const SizedBox(height: 14),

              _StepsMissingCard(
                currentStep: currentStep,
                steps: const [
                  'Passo 1 - Informações',
                  'Passo 2 - Tipo de atendimento',
                  'Passo 3 - Confirmação',
                ],
              ),

              const SizedBox(height: 18),

              if (isStep1)
                (mobile
                    ? Column(
                        children: [
                          _PatientDataCard(
                            locked: _lockedStep1,
                            atendimentoTipo: atendimentoTipo,
                            familiares: familiares,
                            familiarSelecionado: familiarSelecionado,
                            onTipoChanged: (v) => setState(() => atendimentoTipo = v),
                            onFamiliarChanged: (v) =>
                                setState(() => familiarSelecionado = v),
                            onNovoCliente: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Novo cliente (em breve)'),
                                ),
                              );
                            },
                            novoEnabled: true,
                          ),
                          const SizedBox(height: 14),
                          _SchedulingCard(
                            locked: _lockedStep1,
                            enderecosController: _enderecoController,
                            localidadeController: _localidadeController,
                            numeroController: _numeroController,
                            dataController: _dataController,
                            horaController: _horaController,
                          ),
                          const SizedBox(height: 14),
                          _AdditionalInfoCard(
                            locked: _lockedStep2,
                            controller: _adicionaisController,
                          ),
                          const SizedBox(height: 14),
                          _SupportCard(),
                          const SizedBox(height: 14),
                          _RightAlignedNextButton(onPressed: _goNext),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _PatientDataCard(
                                  locked: _lockedStep1,
                                  atendimentoTipo: atendimentoTipo,
                                  familiares: familiares,
                                  familiarSelecionado: familiarSelecionado,
                                  onTipoChanged: (v) => setState(() => atendimentoTipo = v),
                                  onFamiliarChanged: (v) =>
                                      setState(() => familiarSelecionado = v),
                                  onNovoCliente: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Novo cliente (em breve)'),
                                      ),
                                    );
                                  },
                                  novoEnabled: false,
                                ),
                                const SizedBox(height: 14),
                                _SchedulingCard(
                                  locked: _lockedStep1,
                                  enderecosController: _enderecoController,
                                  localidadeController: _localidadeController,
                                  numeroController: _numeroController,
                                  dataController: _dataController,
                                  horaController: _horaController,
                                ),
                                const SizedBox(height: 14),
                                _AdditionalInfoCard(
                                  locked: _lockedStep2,
                                  controller: _adicionaisController,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                _SupportCard(),
                                const SizedBox(height: 14),
                                _RightAlignedNextButton(onPressed: _goNext),
                              ],
                            ),
                          ),
                        ],
                      ))

              else if (isStep2)
                _Step2TipoAtendimento(
                  mobile: mobile,
                  selected: atendimentoSelecionado,
                  onSelect: (v) => setState(() => atendimentoSelecionado = v),
                  onBack: _goBack,
                  onNext: _goNext,
                )

              else if (isStep3)
                Column(
                  children: [
                    _SectionCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirmação',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pedido pronto para revisão (em breve).',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _SupportCard(),
                  ],
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

class _PageIntro extends StatelessWidget {
  final String title;
  final String description;

  const _PageIntro({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
        ),
      ],
    );
  }
}

class _Step2TipoAtendimento extends StatelessWidget {
  final bool mobile;
  final int selected; // 0,1,2
  final ValueChanged<int> onSelect;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const _Step2TipoAtendimento({
    required this.mobile,
    required this.selected,
    required this.onSelect,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final bool canNext = selected != 0;

    Widget optionCard({
      required int value,
      required IconData icon,
      required String title,
      required String description,
    }) {
      final bool isSelected = selected == value;

      return InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => onSelect(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.10)
                : Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.45)
                  : AppColors.primary.withOpacity(0.18),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(isSelected ? 0.14 : 0.10),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(isSelected ? 0.35 : 0.18),
                      ),
                    ),
                    child: Icon(icon, color: AppColors.primary),
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
              const SizedBox(height: 10),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    Widget cardsLayout() {
      if (mobile) {
        return Column(
          children: [
            optionCard(
              value: 1,
              icon: Icons.medical_services_rounded,
              title: 'Atendimento único',
              description:
                  'Uma visita para resolver o seu pedido com cuidado e acompanhamento direto.',
            ),
            const SizedBox(height: 12),
            optionCard(
              value: 2,
              icon: Icons.autorenew_rounded,
              title: 'Atendimento recorrente',
              description:
                  'Visitas regulares para manter o cuidado contínuo e evolução no tratamento.',
            ),
          ],
        );
      }

      return Row(
        children: [
          Expanded(
            child: optionCard(
              value: 1,
              icon: Icons.medical_services_rounded,
              title: 'Atendimento único',
              description:
                  'Uma visita para resolver o seu pedido com cuidado e acompanhamento direto.',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: optionCard(
              value: 2,
              icon: Icons.autorenew_rounded,
              title: 'Atendimento recorrente',
              description:
                  'Visitas regulares para manter o cuidado contínuo e evolução no tratamento.',
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        _SectionCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tipo de Atendimento',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Escolha como o profissional vai realizar as visitas de cuidado:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 16),
                cardsLayout(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 1,
          width: double.infinity,
          color: AppColors.primary.withOpacity(0.15),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: BorderSide(
                    color: AppColors.primary.withOpacity(0.35),
                  ),
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: canNext ? onNext : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  disabledBackgroundColor:
                      AppColors.primary.withOpacity(0.35),
                ),
                child: const Text(
                  'Próximo',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StepsMissingCard extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const _StepsMissingCard({
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    // Espera steps com: [Informações, Tipo de atendimento, Confirmação]
    const stepNums = [1, 2, 3];

    Color lineColor(int stepNum) =>
        stepNum < currentStep ? AppColors.primary : AppColors.textSecondary.withOpacity(0.25);

    Color dotColor(int stepNum) {
      if (stepNum < currentStep) return AppColors.primary;
      if (stepNum == currentStep) return AppColors.primary;
      return AppColors.textSecondary;
    }

    IconData dotIcon(int stepNum) {
      if (stepNum < currentStep) return Icons.check_circle_rounded;
      if (stepNum == currentStep) return Icons.radio_button_checked_rounded;
      return Icons.radio_button_unchecked_rounded;
    }

    TextStyle labelStyle(bool isActive) {
      return Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
            height: 1.1,
          );
    }

    Widget stepItem(int index) {
      final stepNum = stepNums[index];
      final label = steps[index];

      final isActive = stepNum == currentStep;
      final isDone = stepNum < currentStep;

      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              dotIcon(stepNum),
              color: dotColor(stepNum),
              size: 20,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: labelStyle(isActive),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (isDone) const SizedBox(height: 0),
          ],
        ),
      );
    }

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Etapas da solicitação',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // 1
              stepItem(0),
              // linha entre 1 e 2
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: currentStep >= 2
                            ? AppColors.primary
                            : AppColors.textSecondary.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // 2
              stepItem(1),
              // linha entre 2 e 3
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: currentStep >= 3
                            ? AppColors.primary
                            : AppColors.textSecondary.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // 3
              stepItem(2),
            ],
          ),
        ],
      ),
    );
  }
}

class _PatientDataCard extends StatelessWidget {
  final bool locked;
  final String atendimentoTipo;
  final List<String> familiares;
  final String? familiarSelecionado;

  final ValueChanged<String> onTipoChanged;
  final ValueChanged<String?> onFamiliarChanged;

  final VoidCallback onNovoCliente;

  // Novo inativo a princípio
  final bool novoEnabled;

  const _PatientDataCard({
    required this.locked,
    required this.atendimentoTipo,
    required this.familiares,
    required this.familiarSelecionado,
    required this.onTipoChanged,
    required this.onFamiliarChanged,
    required this.onNovoCliente,
    required this.novoEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final isOther = atendimentoTipo == 'Para outra pessoa';
    final bool mobile = MediaQuery.of(context).size.width < 700;

    return _SectionCard(
      child: IgnorePointer(
        ignoring: locked,
        child: Opacity(
          opacity: locked ? 0.75 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Dados do paciente',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),

              // Seleções lado a lado
              Row(
                children: [
                  Expanded(
                    child: _TypeOption(
                      icon: Icons.person_rounded,
                      label: 'Para mim',
                      selected: atendimentoTipo == 'Para mim',
                      onTap: () => onTipoChanged('Para mim'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _TypeOption(
                      icon: Icons.group_rounded,
                      label: 'Para outra pessoa',
                      selected: atendimentoTipo == 'Para outra pessoa',
                      onTap: () =>
                          onTipoChanged('Para outra pessoa'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Mesma linha: Selecionar familiar (90%) + "Novo" (10%)
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: IgnorePointer(
                      ignoring: !isOther,
                      child: Opacity(
                        opacity: isOther ? 1 : 0.55,
                        child: DropdownButtonFormField<String>(
                          value: isOther ? familiarSelecionado : null,
                          decoration: InputDecoration(
                            labelText: 'Selecionar familiar',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: AppColors.primary.withOpacity(0.25),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                          ),
                          items: familiares.map((f) {
                            return DropdownMenuItem(
                              value: f,
                              child: Text(
                                f,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: isOther ? onFamiliarChanged : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        onPressed: isOther ? onNovoCliente : null,
                        style: OutlinedButton.styleFrom(
                          padding: mobile
                              ? const EdgeInsets.symmetric(vertical: 10)
                              : const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          side: BorderSide(
                            color: isOther
                                ? AppColors.primary.withOpacity(0.4)
                                : AppColors.primary.withOpacity(0.15),
                          ),
                        ),
                        child: mobile
                            ? const Icon(Icons.person_add_rounded)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Icon(Icons.person_add_rounded),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Novo',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TypeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.10) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppColors.primary.withOpacity(0.5)
                : AppColors.primary.withOpacity(0.18),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SchedulingCard extends StatelessWidget {
  final bool locked;

  final TextEditingController enderecosController;
  final TextEditingController localidadeController;
  final TextEditingController numeroController;

  final TextEditingController dataController;
  final TextEditingController horaController;

  const _SchedulingCard({
    required this.locked,
    required this.enderecosController,
    required this.localidadeController,
    required this.numeroController,
    required this.dataController,
    required this.horaController,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: IgnorePointer(
        ignoring: locked,
        child: Opacity(
          opacity: locked ? 0.75 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Localização e horário',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: enderecosController,
                decoration: InputDecoration(
                  labelText: 'Endereço de atendimento',
                  hintText: 'Rua/Avenida, Bairro',
                  prefixIcon: const Icon(Icons.location_on_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: AppColors.primary.withOpacity(0.25)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: localidadeController,
                      decoration: InputDecoration(
                        labelText: 'Localidade',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppColors.primary.withOpacity(0.25),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 140,
                    child: TextFormField(
                      controller: numeroController,
                      decoration: InputDecoration(
                        labelText: 'Nº',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppColors.primary.withOpacity(0.25),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Data/hora opcionais
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: dataController,
                      decoration: InputDecoration(
                        labelText: 'Data (opcional)',
                        hintText: 'DD/MM/AAAA',
                        prefixIcon: const Icon(Icons.calendar_today_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppColors.primary.withOpacity(0.25),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: horaController,
                      decoration: InputDecoration(
                        labelText: 'Hora (opcional)',
                        hintText: 'HH:MM',
                        prefixIcon: const Icon(Icons.access_time_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: AppColors.primary.withOpacity(0.25),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdditionalInfoCard extends StatelessWidget {
  final bool locked;
  final TextEditingController controller;

  const _AdditionalInfoCard({
    required this.locked,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: IgnorePointer(
        ignoring: locked,
        child: Opacity(
          opacity: locked ? 0.75 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Informações adicionais',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText:
                      'Inclua detalhes que ajudam a equipa (condições, preferências, etc.)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: AppColors.primary.withOpacity(0.25)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
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

class _SupportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.withOpacity(0.35),
          width: 1,
          style: BorderStyle.solid,
        ),
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
                  color: Colors.blue.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.26),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Suporte 24h',
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
            'Se precisa de ajuda para preencher o formulário ou tiver um atendimento emergente, fale connosco.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Falar com atendente (em breve)')),
                );
              },
              icon: const Icon(Icons.chat_rounded),
              label: const Text('Falar com atendente'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 39, 29).withOpacity(0.8),
                foregroundColor: const Color.fromARGB(255, 190, 62, 62),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RightAlignedNextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RightAlignedNextButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Text('Próximo Passo'),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: child,
    );
  }
}
