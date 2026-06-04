import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class HomeClienteAgendamentoHospitalClinicaView extends StatefulWidget {
  final String partnerName;
  final String partnerAddress;
  final String assetImage;
  final String partnerCategoryLabel;

  const HomeClienteAgendamentoHospitalClinicaView({
    super.key,
    required this.partnerName,
    required this.partnerAddress,
    required this.assetImage,
    required this.partnerCategoryLabel,
  });

  @override
  State<HomeClienteAgendamentoHospitalClinicaView> createState() =>
      _HomeClienteAgendamentoHospitalClinicaViewState();
}

class _HomeClienteAgendamentoHospitalClinicaViewState
    extends State<HomeClienteAgendamentoHospitalClinicaView> {
  bool get _isMobile => MediaQuery.of(context).size.width < 700;

  // Simples placeholders (sem backend).
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();

  bool _editing = false;

  String? _selectedSpecialty;
  final List<String> _specialties = [
    'Cardiologia',
    'Ortopedia',
    'Pediatria',
    'Ginecologia',
    'Dermatologia',
    'Neurologia',
  ];

  final _dateController = TextEditingController();
  final _observationsController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _dateController.dispose();
    _observationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final left = _PartnerInfoCard(
      partnerName: widget.partnerName,
      partnerAddress: widget.partnerAddress,
      assetImage: widget.assetImage,
      partnerCategoryLabel: widget.partnerCategoryLabel,
      specialties: _specialties,
      selectedSpecialty: _selectedSpecialty,
      onSelectSpecialty: (v) => setState(() => _selectedSpecialty = v),
    );

    final right = _SolicitarHorarioCard(
      formKey: _formKey,
      editing: _editing,
      onToggleEdit: () => setState(() => _editing = !_editing),
      nomeController: _nomeController,
      emailController: _emailController,
      telefoneController: _telefoneController,
      selectedSpecialty: _selectedSpecialty,
      specialities: _specialties,
      dateController: _dateController,
      observationsController: _observationsController,
      onConfirm: () {
        // Valida campos básicos.
        final ok = _formKey.currentState?.validate() ?? false;
        if (!ok) return;

        final snackText = 'Confirmação enviada (termos aceites).';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(snackText)),
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
        title: const Text('Agendamento hospitalar/clinica'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),
              _isMobile
                  ? Column(
                      children: [
                        left,
                        const SizedBox(height: 14),
                        right,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4, child: left),
                        const SizedBox(width: 14),
                        Expanded(flex: 6, child: right),
                      ],
                    ),
              const SizedBox(height: 18),
              // Footer simples (sem depender de outro arquivo)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Ao confirmar, você aceita a partilha dos seus dados com instituições terceiros.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
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

class _PartnerInfoCard extends StatelessWidget {
  final String partnerName;
  final String partnerAddress;
  final String partnerCategoryLabel;
  final String assetImage;

  final List<String> specialties;
  final String? selectedSpecialty;
  final ValueChanged<String> onSelectSpecialty;

  const _PartnerInfoCard({
    required this.partnerName,
    required this.partnerAddress,
    required this.assetImage,
    required this.partnerCategoryLabel,
    required this.specialties,
    required this.selectedSpecialty,
    required this.onSelectSpecialty,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeaderImage(
            assetImage: assetImage,
            fallbackIcon: Icons.local_hospital_rounded,
          ),
          const SizedBox(height: 12),
          Text(
            partnerCategoryLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            partnerName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            partnerAddress,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            'Especialidades disponíveis',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 78,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: specialties.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final sp = specialties[index];
                final selected = sp == selectedSpecialty;
                return _SpecialtyChip(
                  text: sp,
                  selected: selected,
                  onTap: () => onSelectSpecialty(sp),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  final String assetImage;
  final IconData fallbackIcon;

  const _HeaderImage({
    required this.assetImage,
    required this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.primary.withOpacity(0.08),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.18),
        ),
      ),
      child: assetImage.isEmpty
          ? Center(
              child: Icon(
                fallbackIcon,
                color: AppColors.primary,
                size: 34,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                assetImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      fallbackIcon,
                      color: AppColors.primary,
                      size: 34,
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class _SpecialtyChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SpecialtyChip({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppColors.primary.withOpacity(0.45)
                : AppColors.primary.withOpacity(0.18),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                  height: 1.1,
                ),
          ),
        ),
      ),
    );
  }
}

class _SolicitarHorarioCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final bool editing;
  final VoidCallback onToggleEdit;

  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;

  final String? selectedSpecialty;
  final List<String> specialities;

  final TextEditingController dateController;
  final TextEditingController observationsController;

  final VoidCallback onConfirm;

  const _SolicitarHorarioCard({
    required this.formKey,
    required this.editing,
    required this.onToggleEdit,
    required this.nomeController,
    required this.emailController,
    required this.telefoneController,
    required this.selectedSpecialty,
    required this.specialities,
    required this.dateController,
    required this.observationsController,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Solicitar um horário',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onToggleEdit,
                  icon: Icon(
                    editing ? Icons.close_rounded : Icons.edit_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  label: Text(
                    editing ? 'Fechar' : 'Editar',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 10),
            Text(
              'Confirme os dados pessoais para concluir o pedido.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
            ),

            const SizedBox(height: 14),

            _FormTextField(
              enabled: editing,
              controller: nomeController,
              label: 'Nome completo',
              hint: 'Ex: Maria João',
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Informe o nome.';
                }
                return null;
              },
              prefixIcon: Icons.person_rounded,
            ),
            const SizedBox(height: 12),
            _FormTextField(
              enabled: editing,
              controller: emailController,
              label: 'Email',
              hint: 'Ex: maria@email.com',
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return 'Informe o email.';
                if (!value.contains('@')) return 'Email inválido.';
                return null;
              },
              prefixIcon: Icons.email_rounded,
            ),
            const SizedBox(height: 12),
            _FormTextField(
              enabled: editing,
              controller: telefoneController,
              label: 'Telefone',
              hint: 'Ex: +351 9xx xxx xxx',
              keyboardType: TextInputType.phone,
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return 'Informe o telefone.';
                return null;
              },
              prefixIcon: Icons.phone_rounded,
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: selectedSpecialty,
              decoration: InputDecoration(
                labelText: 'Especialidade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: AppColors.primary.withOpacity(0.25)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
              ),
              items: specialities
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
              onChanged: null, // controlado pela lista horizontal à esquerda
              validator: (v) {
                if (v == null) return 'Selecione uma especialidade.';
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: dateController,
              readOnly: false,
              decoration: InputDecoration(
                labelText: 'Data',
                hintText: 'DD/MM/AAAA',
                prefixIcon: const Icon(Icons.calendar_today_rounded),
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
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return 'Informe a data.';
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: observationsController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Observações',
                hintText:
                    'Escreva detalhes relevantes para a especialidade (opcional).',
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

            const SizedBox(height: 14),

            Text(
              'Ao confirmar, concorda com a partilha de dados pessoais para processamento com instituições terceiros.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 48,
              child: FilledButton.tonal(
                onPressed: onConfirm,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Confirmar solicitação',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData prefixIcon;

  const _FormTextField({
    required this.enabled,
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    this.keyboardType = TextInputType.text,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.25)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      validator: validator,
    );
  }
}

