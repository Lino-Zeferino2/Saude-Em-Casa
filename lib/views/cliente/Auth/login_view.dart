import 'package:flutter/material.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../model/auth/login_model.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _identityController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _identityController =
        TextEditingController(text: _controller.state.phoneOrEmail);
    _passwordController = TextEditingController(text: _controller.state.password);

    _identityController.addListener(() {
      _controller.setPhoneOrEmail(_identityController.text);
    });
    _passwordController.addListener(() {
      _controller.setPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final LoginModel state = _controller.state;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: isMobile
                ? SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      children: [
                        _MobileHeader(),
                        const SizedBox(height: 12),
                        _LoginCard(
                          formKey: _formKey,
                          state: state,
                          identityController: _identityController,
                          passwordController: _passwordController,
                          onCountryChanged: _controller.setCountryCode,
                          onForgot: () => _controller.onForgotPasswordPressed(context),
                          onRegister: () => _controller.onRegisterPressed(context),
                          onLogin: () => _controller.onLoginPressed(context),
                          onTogglePassword: _controller.toggleShowPassword,
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      // Left: imagem + overlay (60%)
                      Expanded(
                        flex: 3,
                        child: _LeftHero(),
                      ),

                      // Right: form (40%)
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                          child: _LoginCard(
                            formKey: _formKey,
                            state: state,
                            identityController: _identityController,
                            passwordController: _passwordController,
                            onCountryChanged: _controller.setCountryCode,
                            onForgot: () => _controller.onForgotPasswordPressed(context),
                            onRegister: () => _controller.onRegisterPressed(context),
                            onLogin: () => _controller.onLoginPressed(context),
                            onTogglePassword: _controller.toggleShowPassword,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _MobileHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo em destaque
          Stack(
            alignment: Alignment.center,
            children: [
              // ponto "grade" visual leve
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.06,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/health_care.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                          color: Colors.black.withOpacity(0.10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Nome
          Text(
            'Saúde em Casa',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Somente descrição (sem título)
          Text(
            'Simples, seguro e com acompanhamento humano.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MobileOverlayTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _MobileOverlayTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.95),
              ),
        ),
      ],
    );
  }
}

class _LeftHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/doctor_1.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.12),
                  Colors.black.withOpacity(0.28),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(26, 26, 26, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(width: 46, height: 46);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Saúde em Casa',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  'Cuidado profissional no conforto do seu lar.',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Acompanhamento humano, agendamento simples e apoio familiar — tudo numa experiência premium.',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.95),
                      ),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      width: 210,
                      child: _StatGlassCard(
                        number: '4.9',
                        label: 'Avaliações',
                      ),
                    ),
                    SizedBox(width: 12),
                    SizedBox(
                      width: 210,
                      child: _StatGlassCard(
                        number: '2.1k',
                        label: 'Clientes',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _StatGlassCard extends StatelessWidget {
  final String number;
  final String label;

  const _StatGlassCard({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.16),
          )
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.95),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LoginModel state;

  final TextEditingController identityController;
  final TextEditingController passwordController;

  final void Function(String value) onCountryChanged;

  final VoidCallback onForgot;
  final VoidCallback onRegister;
  final VoidCallback onLogin;
  final VoidCallback onTogglePassword;

  const _LoginCard({
    required this.formKey,
    required this.state,
    required this.identityController,
    required this.passwordController,
    required this.onCountryChanged,
    required this.onForgot,
    required this.onRegister,
    required this.onLogin,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) ...[
          Text(
            'Bem-vindo de volta',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Acesse sua conta para genciar seus cuidados.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 16),
        ],
        if (isMobile) const SizedBox(height: 6),

        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                // Country dropdown
                _CountryPicker(
                  value: state.countryCode,
                  onChanged: onCountryChanged,
                ),
                const SizedBox(height: 12),

                // Phone or email
                TextFormField(
                  controller: identityController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_rounded),
                    labelText: 'Telemóvel ou email',
                    hintText: 'Ex: 923123123 ou nome@dominio.com',
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (_) => state.isValidPhoneOrEmail ? null : state.isPhoneCandidate ? null : state.isEmailCandidate ? null : 'Informe telemóvel (9 dígitos) ou email válido',
                ),
                const SizedBox(height: 12),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: !state.showPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    labelText: 'Senha',
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      tooltip: state.showPassword ? 'Ocultar senha' : 'Mostrar senha',
                      onPressed: onTogglePassword,
                      icon: Icon(
                        state.showPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                  validator: (_) => state.isValidPassword ? null : 'A senha deve ter pelo menos 6 caracteres',
                ),
                const SizedBox(height: 6),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onForgot,
                    child: const Text('Esqueci a senha?'),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onLogin,
                    child: const Text('Entrar'),
                  ),
                ),

                const SizedBox(height: 10),
                const Divider(height: 1),

                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Não possui uma conta?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: OutlinedButton(
                    onPressed: onRegister,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(
                        color: Color(0xFFD6E2F0),
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Cadastra-se aqui',
                      style: TextStyle(fontWeight: FontWeight.w700),
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

class _CountryPicker extends StatelessWidget {
  final String value;
  final void Function(String) onChanged;

  const _CountryPicker({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Sem assets de bandeiras — usando emoji como ícone (compatível com web).
    final items = const [
      {'code': '+244', 'label': 'Angola', 'flag': '🇦🇴'},
      {'code': '+238', 'label': 'Cabo Verde', 'flag': '🇨🇻'},
      {'code': '+351', 'label': 'Portugal', 'flag': '🇵🇹'},
      {'code': '+55', 'label': 'Brasil', 'flag': '🇧🇷'},
      {'code': '+258', 'label': 'Moçambique', 'flag': '🇲🇿'},
    ];

    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Código do país',
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e['code'] as String,
                  child: Row(
                    children: [
                      Text(e['flag'] as String),
                      const SizedBox(width: 10),
                      Text('${e['label']} (${e['code']})'),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v == null) return;
            onChanged(v);
          },
        ),
      ),
    );
  }
}
