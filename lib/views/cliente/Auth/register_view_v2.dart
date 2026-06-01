import 'package:flutter/material.dart';

import '../../../controller/auth/register_controller.dart';
import '../../../model/auth/register_model.dart';
import '../../../theme/app_colors.dart';

class RegisterViewV2 extends StatefulWidget {
  const RegisterViewV2({super.key});

  @override
  State<RegisterViewV2> createState() => _RegisterViewV2State();
}

class _RegisterViewV2State extends State<RegisterViewV2> {
  final _controller = RegisterController();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _locationController;
  late final TextEditingController _genderController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _fullNameController =
        TextEditingController(text: _controller.state.fullName);
    _phoneController = TextEditingController(text: _controller.state.phone);
    _emailController = TextEditingController(text: _controller.state.email);
    _birthDateController =
        TextEditingController(text: _controller.state.birthDate);
    _locationController =
        TextEditingController(text: _controller.state.location);
    _genderController = TextEditingController(text: _controller.state.gender);
    _passwordController =
        TextEditingController(text: _controller.state.password);

    _fullNameController.addListener(() {
      _controller.setFullName(_fullNameController.text);
    });
    _phoneController.addListener(() {
      _controller.setPhone(_phoneController.text);
    });
    _emailController.addListener(() {
      _controller.setEmail(_emailController.text);
    });
    _birthDateController.addListener(() {
      _controller.setBirthDate(_birthDateController.text);
    });
    _locationController.addListener(() {
      _controller.setLocation(_locationController.text);
    });
    _genderController.addListener(() {
      _controller.setGender(_genderController.text);
    });
    _passwordController.addListener(() {
      _controller.setPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _locationController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get isMobile => MediaQuery.of(context).size.width < 700;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final RegisterModel state = _controller.state;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: _RegisterAppBar(controller: _controller),
          body: SafeArea(
            child: isMobile
                ? SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: _RegisterBody(
                      state: state,
                      formKey: _formKey,
                      fullNameController: _fullNameController,
                      phoneController: _phoneController,
                      emailController: _emailController,
                      birthDateController: _birthDateController,
                      locationController: _locationController,
                      genderController: _genderController,
                      passwordController: _passwordController,
                      onLoginTap: () => _controller.onLoginPressed(context),
                      onRegisterTap: () => _controller.onRegisterPressed(context),
                    ),
                  )
                : Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: const _LeftImagePanel(),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              flex: 2,
                              child: _RegisterBody(
                                state: state,
                                formKey: _formKey,
                                fullNameController: _fullNameController,
                                phoneController: _phoneController,
                                emailController: _emailController,
                                birthDateController: _birthDateController,
                                locationController: _locationController,
                                genderController: _genderController,
                                passwordController: _passwordController,
                                onLoginTap: () => _controller.onLoginPressed(context),
                                onRegisterTap: () => _controller.onRegisterPressed(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class _RegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  final RegisterController controller;

  const _RegisterAppBar({required this.controller});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final bool isMobileLocal = MediaQuery.of(context).size.width < 700;

    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.96),
      elevation: 0,
      foregroundColor: AppColors.textPrimary,
      automaticallyImplyLeading: false,
      titleSpacing: 6,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12, right: 8),
        child: Image.asset(
          'logo.png',
          height: 38,
          width: 38,
          errorBuilder: (context, error, stackTrace) {
            return const CircleAvatar(radius: 19);
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              if (!isMobileLocal)
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => controller.onHelpPressed(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text(
                      'Ajuda',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => controller.onLoginPressed(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeftImagePanel extends StatelessWidget {
  const _LeftImagePanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'health_care.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.25),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.10),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    'Cuidado que chega até você',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          height: 1.05,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Crie sua conta e comece a cuidar da sua saúde com apoio e acompanhamento humano.',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.95),
                          height: 1.35,
                        ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RegisterModel state;

  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController birthDateController;
  final TextEditingController locationController;
  final TextEditingController genderController;
  final TextEditingController passwordController;

  final VoidCallback onRegisterTap;
  final VoidCallback onLoginTap;

  const _RegisterBody({
    required this.formKey,
    required this.state,
    required this.fullNameController,
    required this.phoneController,
    required this.emailController,
    required this.birthDateController,
    required this.locationController,
    required this.genderController,
    required this.passwordController,
    required this.onRegisterTap,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 8),
              color: AppColors.shadow,
            )
          ],
          border: Border.all(
            color: Colors.black.withOpacity(0.03),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 6),
            Text(
              'Criar conta',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Preencha seus dados para começar.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
            ),
            const SizedBox(height: 16),

            _InputField(
              controller: fullNameController,
              label: 'Nome completo',
              hint: 'Ex: Maria João',
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.badge_outlined),
              validator: (_) => state.fullNameError(),
            ),
            const SizedBox(height: 12),

            LayoutBuilder(
              builder: (context, constraints) {
                final tight = constraints.maxWidth < 420;
                return Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        controller: phoneController,
                        label: 'Telemóvel',
                        hint: '9 dígitos',
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone_rounded),
                        validator: (_) => state.phoneError(),
                      ),
                    ),
                    if (!tight) const SizedBox(width: 12),
                    if (tight) const SizedBox(height: 12),
                    Expanded(
                      child: _InputField(
                        controller: birthDateController,
                        label: 'Data de nascimento',
                        hint: 'yyyy-mm-dd',
                        keyboardType: TextInputType.datetime,
                        prefixIcon:
                            const Icon(Icons.calendar_today_rounded),
                        validator: (_) => state.birthDateError(),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),

            _InputField(
              controller: emailController,
              label: 'Email',
              hint: 'nome@dominio.com',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.mail_outline_rounded),
              validator: (_) => state.emailError(),
            ),
            const SizedBox(height: 12),

            _InputField(
              controller: locationController,
              label: 'Localização',
              hint: 'Cidade / Bairro',
              keyboardType: TextInputType.streetAddress,
              prefixIcon: const Icon(Icons.location_on_outlined),
              validator: (_) => state.locationError(),
            ),
            const SizedBox(height: 12),

            _GenderSelector(
              controller: genderController,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: passwordController,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                labelText: 'Senha',
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                errorStyle: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
              validator: (_) => state.passwordError(),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: onRegisterTap,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            Center(
              child: Text(
                'Já possui uma conta?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: OutlinedButton(
                onPressed: onLoginTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(
                    color: Color(0xFFD6E2F0),
                    width: 1,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Faça login',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final String? Function(String?) validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.keyboardType,
    this.prefixIcon,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 12,
          height: 1.2,
        ),
      ),
      validator: validator,
    );
  }
}

class _GenderSelector extends StatefulWidget {
  final TextEditingController controller;

  const _GenderSelector({
    required this.controller,
  });

  @override
  State<_GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<_GenderSelector> {
  static const items = ['Feminino', 'Masculino', 'Outro'];
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.controller.text;
  }

  void _set(String v) {
    setState(() {
      selected = v;
      widget.controller.text = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showError = widget.controller.text.trim().isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sexo',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items.map((v) {
            final isSelected = selected == v;
            return ChoiceChip(
              label: Text(v),
              selected: isSelected,
              onSelected: (_) => _set(v),
              selectedColor: AppColors.primary.withOpacity(0.18),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              labelStyle: TextStyle(
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w800,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            );
          }).toList(),
        ),
        if (showError)
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 2),
            child: Text(
              'Sexo é obrigatório',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                height: 1.2,
              ),
            ),
          ),
      ],
    );
  }
}
