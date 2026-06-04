import 'dart:io';

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

enum FarmaciaEntregaMode {
  levantar,
  entregar,
}

/// Tela de Farmácia (demo):
/// - escolher receita (texto ou foto)
/// - escolher levantamento ou entrega
/// - (se entrega) editar morada
class HomeClienteFarmaciaView extends StatefulWidget {
  final String farmaciaName;
  final String farmaciaAddress;
  final String assetImage;

  /// Dados iniciais do cliente
  final String clienteName;
  final String clientePhone;
  final String clienteEmail;

  final String entregaRua;
  final String entregaCidade;
  final String entregaCodigoPostal;

  const HomeClienteFarmaciaView({
    super.key,
    required this.farmaciaName,
    required this.farmaciaAddress,
    required this.assetImage,
    required this.clienteName,
    required this.clientePhone,
    required this.clienteEmail,
    required this.entregaRua,
    required this.entregaCidade,
    required this.entregaCodigoPostal,
  });

  @override
  State<HomeClienteFarmaciaView> createState() =>
      _HomeClienteFarmaciaViewState();
}

class _HomeClienteFarmaciaViewState extends State<HomeClienteFarmaciaView> {
  bool get isMobile => MediaQuery.of(context).size.width < 700;

  final _formKey = GlobalKey<FormState>();

  // Receita
  bool _writeRecipe = true;
  final _receitaController = TextEditingController();
  File? _recipePhoto;

  // Entrega
  FarmaciaEntregaMode _deliveryMode = FarmaciaEntregaMode.levantar;
  bool _editingAddress = false;

  late final TextEditingController _endRua;
  late final TextEditingController _endCidade;
  late final TextEditingController _endCodigoPostal;

  @override
  void initState() {
    super.initState();
    _endRua = TextEditingController(text: widget.entregaRua);
    _endCidade = TextEditingController(text: widget.entregaCidade);
    _endCodigoPostal = TextEditingController(text: widget.entregaCodigoPostal);
  }

  @override
  void dispose() {
    _receitaController.dispose();
    _endRua.dispose();
    _endCidade.dispose();
    _endCodigoPostal.dispose();
    super.dispose();
  }

  void _onFinalize() {
    final ok = _formKey.currentState?.validate() ?? true;
    if (!ok) return;

    final recipeType = _writeRecipe ? 'escrita' : 'foto';
    final deliveryType =
        _deliveryMode == FarmaciaEntregaMode.levantar ? 'levantamento' : 'entrega';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pedido finalizado (demo) — receita: $recipeType, entrega: $deliveryType.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final farmaciaCard = _FarmaciaCard(
      name: widget.farmaciaName,
      address: widget.farmaciaAddress,
      assetImage: widget.assetImage,
    );

    final clienteCard = _ClienteAndRecipeCard(
      writeRecipe: _writeRecipe,
      recipeTextController: _receitaController,
      recipePhoto: _recipePhoto,
      onToggleWriteRecipe: (v) => setState(() => _writeRecipe = v),
      onPickPhoto: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Seleção de foto (em breve).')),
        );
      },
    );

    final deliveryCard = _DeliveryAddressCard(
      mode: _deliveryMode,
      onModeChanged: (m) => setState(() {
        _deliveryMode = m;
        if (_deliveryMode == FarmaciaEntregaMode.levantar) {
          _editingAddress = false;
        }
      }),
      editingAddress: _editingAddress,
      onToggleEditAddress: () =>
          setState(() => _editingAddress = !_editingAddress),
      ruaController: _endRua,
      cidadeController: _endCidade,
      codigoPostalController: _endCodigoPostal,
      enabled: _deliveryMode == FarmaciaEntregaMode.entregar,
    );

    final content = isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              farmaciaCard,
              const SizedBox(height: 12),
              clienteCard,
              const SizedBox(height: 12),
              deliveryCard,
              const SizedBox(height: 18),
              _FinalizeSection(onFinalize: _onFinalize),
              const SizedBox(height: 12),
              const _InfoFooter(),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: farmaciaCard),
              const SizedBox(width: 14),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    clienteCard,
                    const SizedBox(height: 12),
                    deliveryCard,
                    const SizedBox(height: 18),
                    _FinalizeSection(onFinalize: _onFinalize),
                    const SizedBox(height: 12),
                    const _InfoFooter(),
                  ],
                ),
              ),
            ],
          );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Farmácia'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Form(key: _formKey, child: content),
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.16),
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
      child: child,
    );
  }
}

class _FarmaciaCard extends StatelessWidget {
  final String name;
  final String address;
  final String assetImage;

  const _FarmaciaCard({
    required this.name,
    required this.address,
    required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeaderImage(
            assetImage: assetImage,
            fallbackIcon: Icons.local_pharmacy_rounded,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            address,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoPill(
                icon: Icons.local_shipping_rounded,
                label: 'Entrega disponível',
              ),
              _InfoPill(
                icon: Icons.medical_services_rounded,
                label: 'Análise de receita',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ClienteAndRecipeCard extends StatelessWidget {
  final bool writeRecipe;
  final TextEditingController recipeTextController;
  final File? recipePhoto;
  final ValueChanged<bool> onToggleWriteRecipe;
  final VoidCallback onPickPhoto;

  const _ClienteAndRecipeCard({
    required this.writeRecipe,
    required this.recipeTextController,
    required this.recipePhoto,
    required this.onToggleWriteRecipe,
    required this.onPickPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Dados pessoais e receita',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('Escrever receita'),
                  selected: writeRecipe,
                  onSelected: (_) => onToggleWriteRecipe(true),
                  selectedColor: AppColors.primary.withOpacity(0.16),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: const Text('Enviar por foto'),
                  selected: !writeRecipe,
                  onSelected: (_) => onToggleWriteRecipe(false),
                  selectedColor: AppColors.primary.withOpacity(0.16),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const _PersonalDataPlaceholder(),
          const SizedBox(height: 14),

          if (writeRecipe) ...[
            _SectionTitle(title: 'Escreva a receita'),
            const SizedBox(height: 8),
            TextFormField(
              controller: recipeTextController,
              maxLines: 5,
              enabled: true,
              validator: (v) {
                if ((v ?? '').trim().isEmpty) {
                  return 'Informe a receita (demo).';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Ex.: nome do medicamento, posologia, duração...',
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
          ] else ...[
            _SectionTitle(title: 'Envie a receita por foto'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.18),
                ),
                color: AppColors.primary.withOpacity(0.05),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (recipePhoto == null)
                    Column(
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.primary,
                          size: 34,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Foto da receita (em breve — UI pronta).',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        FilledButton.tonal(
                          onPressed: onPickPhoto,
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text('Selecionar foto'),
                        ),
                      ],
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(
                        recipePhoto!,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PersonalDataPlaceholder extends StatelessWidget {
  const _PersonalDataPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        _MiniRow(icon: Icons.person_rounded, label: 'Nome: (demo)'),
        SizedBox(height: 8),
        _MiniRow(icon: Icons.phone_rounded, label: 'Telefone: (demo)'),
        SizedBox(height: 8),
        _MiniRow(icon: Icons.email_rounded, label: 'Email: (demo)'),
      ],
    );
  }
}

class _MiniRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MiniRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.16),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

class _DeliveryAddressCard extends StatelessWidget {
  final FarmaciaEntregaMode mode;
  final ValueChanged<FarmaciaEntregaMode> onModeChanged;

  final bool editingAddress;
  final VoidCallback onToggleEditAddress;

  final TextEditingController ruaController;
  final TextEditingController cidadeController;
  final TextEditingController codigoPostalController;

  final bool enabled;

  const _DeliveryAddressCard({
    required this.mode,
    required this.onModeChanged,
    required this.editingAddress,
    required this.onToggleEditAddress,
    required this.ruaController,
    required this.cidadeController,
    required this.codigoPostalController,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final deliverySelected = mode == FarmaciaEntregaMode.entregar;
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Morada de entrega',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('Levantar na farmácia'),
                  selected: mode == FarmaciaEntregaMode.levantar,
                  onSelected: (_) => onModeChanged(
                    FarmaciaEntregaMode.levantar,
                  ),
                  selectedColor: AppColors.primary.withOpacity(0.16),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: const Text('Entregar'),
                  selected: deliverySelected,
                  onSelected: (_) => onModeChanged(
                    FarmaciaEntregaMode.entregar,
                  ),
                  selectedColor: AppColors.primary.withOpacity(0.16),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (deliverySelected) ...[
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onToggleEditAddress,
                icon: Icon(
                  editingAddress ? Icons.close_rounded : Icons.edit_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
                label: Text(
                  editingAddress ? 'Fechar edição' : 'Editar endereço',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),

            Column(
              children: [
                _Field(
                  controller: ruaController,
                  label: 'Rua e número',
                  enabled: enabled && editingAddress,
                ),
                const SizedBox(height: 10),
                _Field(
                  controller: cidadeController,
                  label: 'Cidade',
                  enabled: enabled && editingAddress,
                ),
                const SizedBox(height: 10),
                _Field(
                  controller: codigoPostalController,
                  label: 'Código Postal',
                  enabled: enabled && editingAddress,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.14)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.info_rounded, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Quando você confirmar, o endereço será usado para entrega.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            )
          ] else ...[
            const _InfoBox(
              text: 'Você levantará sua medicação na farmácia selecionada.',
            ),
          ],
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool enabled;
  final TextInputType keyboardType;

  const _Field({
    required this.controller,
    required this.label,
    required this.enabled,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
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
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String text;
  const _InfoBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.14)),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _FinalizeSection extends StatelessWidget {
  final VoidCallback onFinalize;
  const _FinalizeSection({required this.onFinalize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FilledButton.tonal(
        onPressed: onFinalize,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Finalizar pedido',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _InfoFooter extends StatelessWidget {
  const _InfoFooter();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Ao clicar em finalizar, a farmácia analisará sua receita e enviará o orçamento em instantes.',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            height: 1.4,
            fontWeight: FontWeight.w800,
          ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppColors.primary.withOpacity(0.09),
        border: Border.all(color: AppColors.primary.withOpacity(0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
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
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primary.withOpacity(0.08),
        border: Border.all(color: AppColors.primary.withOpacity(0.16)),
      ),
      child: assetImage.isEmpty
          ? Center(
              child: Icon(
                fallbackIcon,
                color: AppColors.primary,
                size: 42,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                assetImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      fallbackIcon,
                      color: AppColors.primary,
                      size: 42,
                    ),
                  );
                },
              ),
            ),
    );
  }
}

