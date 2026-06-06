import 'package:flutter/material.dart';

import '../../../model/auth/register_model.dart';
import '../../../theme/app_colors.dart';
import '../../cliente/auth/login_view.dart';
import '../../../utils/local_storage_service.dart';

class HomeClientePerfilView extends StatefulWidget {
  const HomeClientePerfilView({super.key});

  @override
  State<HomeClientePerfilView> createState() => _HomeClientePerfilViewState();
}

class _HomeClientePerfilViewState extends State<HomeClientePerfilView> {
  bool _loading = true;

  // Dados base vindos da sessão (localStorage)
  String fullName = '—';
  String email = '—';
  String phone = '—';
  String memberSince = '—';

  bool verified = false;

  // Placeholders (quando seu backend/modelo existir, substituímos)
  bool hasPlan = false;
  bool planActive = false;
  String planName = 'Plano Básico';
  String planNextBilling = '—';

  DateTime? nextVisitAt;

  bool modoFacilEnabled = true;
  bool notificationsEnabled = true;

  // Contatos de emergência placeholder
  final List<_EmergencyContact> emergencyContacts = [
    _EmergencyContact(
      name: 'Marta Silva',
      relation: 'Mãe',
      phone: '900000000',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadFromSession();
  }

  Future<void> _loadFromSession() async {
    final session = await LocalStorageService.getSession();

    final n = (session?['fullName'] ?? '').toString();
    final e = (session?['userEmail'] ?? '').toString();
    final p = (session?['userPhone'] ?? '').toString();

    // Placeholder: “membro desde” idealmente viria do usuário real.
    // Mantive fixo/derivado para não quebrar UI.
    final now = DateTime.now();
    final derivedMemberSince = DateTime(now.year, now.month, 1);

    setState(() {
      fullName = n.isNotEmpty ? n : '—';
      email = e.isNotEmpty ? e : '—';
      phone = p.isNotEmpty ? p : '—';
      memberSince = '${derivedMemberSince.day.toString().padLeft(2, '0')}/'
          '${derivedMemberSince.month.toString().padLeft(2, '0')}/'
          '${derivedMemberSince.year}';

      verified = e.isNotEmpty; // placeholder: se tiver email, marca verificado
      _loading = false;
      nextVisitAt = DateTime.now().add(const Duration(days: 10));
      hasPlan = true; // placeholder para mostrar card de plano
      planActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        title: const Text('O meu Perfil'),
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, constraints) {
                  // Layout principal: 2/8 (drawer à esquerda) e conteúdo à direita
                  if (isNarrow) {
                    // Em telas menores, empilha
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _LeftMenuMobile(
                            fullName: fullName,
                            phone: phone,
                            modoFacilEnabled: modoFacilEnabled,
                            onLogout: _deleteAccountPlaceholder,
                            onExit: _exitPlaceholder,
                          ),
                          const SizedBox(height: 16),
                          _PerfilContent(
                            fullName: fullName,
                            email: email,
                            phone: phone,
                            memberSince: memberSince,
                            verified: verified,
                            modoFacilEnabled: modoFacilEnabled,
                            notificationsEnabled: notificationsEnabled,
                            hasPlan: hasPlan,
                            planActive: planActive,
                            planName: planName,
                            planNextBilling: planNextBilling,
                            nextVisitAt: nextVisitAt,
                            emergencyContacts: emergencyContacts,
                            onEditProfile: _editProfilePlaceholder,
                            onToggleModoFacil: _toggleModoFacil,
                            onToggleNotifications: _toggleNotifications,
                            onChangePassword: _changePasswordPlaceholder,
                            onSeguroPlaceholder: _seguroPlaceholder,
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.25,
                          child: _LeftMenuDesktop(
                            fullName: fullName,
                            phone: phone,
                            modoFacilEnabled: modoFacilEnabled,
                            onLogout: _deleteAccountPlaceholder,
                            onExit: _exitPlaceholder,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: _PerfilContent(
                            fullName: fullName,
                            email: email,
                            phone: phone,
                            memberSince: memberSince,
                            verified: verified,
                            modoFacilEnabled: modoFacilEnabled,
                            notificationsEnabled: notificationsEnabled,
                            hasPlan: hasPlan,
                            planActive: planActive,
                            planName: planName,
                            planNextBilling: planNextBilling,
                            nextVisitAt: nextVisitAt,
                            emergencyContacts: emergencyContacts,
                            onEditProfile: _editProfilePlaceholder,
                            onToggleModoFacil: _toggleModoFacil,
                            onToggleNotifications: _toggleNotifications,
                            onChangePassword: _changePasswordPlaceholder,
                            onSeguroPlaceholder: _seguroPlaceholder,
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


  void _toggleModoFacil(bool v) {
    setState(() => modoFacilEnabled = v);
  }

  void _toggleNotifications(bool v) {
    setState(() => notificationsEnabled = v);
  }

  void _editProfilePlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Editar perfil (em breve)')),
    );
  }

  Future<void> _deleteAccountPlaceholder() async {
    // remove a sessão + (placeholder) a lista de usuários ficará como demo
    await LocalStorageService.clearSession();
    if (!mounted) return;

    // limpa navegação e vai para o Login
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginView()),
      (_) => false,
    );
  }

  void _exitPlaceholder() {
    // placeholder: aqui você pode navegar para splash/login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sair (em breve)')),
    );
  }

  void _changePasswordPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alterar senha (em breve)')),
    );
  }

  void _seguroPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Seguro (em breve)')),
    );
  }
}

class _PerfilContent extends StatelessWidget {
  final String fullName;
  final String email;
  final String phone;
  final String memberSince;
  final bool verified;

  final bool modoFacilEnabled;
  final bool notificationsEnabled;

  final bool hasPlan;
  final bool planActive;
  final String planName;
  final String planNextBilling;

  final DateTime? nextVisitAt;
  final List<_EmergencyContact> emergencyContacts;

  final VoidCallback onEditProfile;
  final ValueChanged<bool> onToggleModoFacil;
  final ValueChanged<bool> onToggleNotifications;
  final VoidCallback onChangePassword;
  final VoidCallback onSeguroPlaceholder;

  const _PerfilContent({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.memberSince,
    required this.verified,
    required this.modoFacilEnabled,
    required this.notificationsEnabled,
    required this.hasPlan,
    required this.planActive,
    required this.planName,
    required this.planNextBilling,
    required this.nextVisitAt,
    required this.emergencyContacts,
    required this.onEditProfile,
    required this.onToggleModoFacil,
    required this.onToggleNotifications,
    required this.onChangePassword,
    required this.onSeguroPlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 1100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'O meu Perfil',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),

        // CARD PRINCIPAL
        _ProfileHeroCard(
          fullName: fullName,
          email: email,
          memberSince: memberSince,
          verified: verified,
          onEditProfile: onEditProfile,
        ),

        const SizedBox(height: 16),

        // Grid 7/3 (ou empilha)
        isNarrow
            ? Column(
                children: [
                  _DadosECardsLeft(
                    fullName: fullName,
                    email: email,
                    phone: phone,
                    nextVisitAt: nextVisitAt,
                    hasPlan: hasPlan,
                    planActive: planActive,
                    planName: planName,
                    planNextBilling: planNextBilling,
                  ),
                  const SizedBox(height: 16),
                  _SettingsRightColumn(
                    modoFacilEnabled: modoFacilEnabled,
                    notificationsEnabled: notificationsEnabled,
                    emergencyContacts: emergencyContacts,
                    onToggleModoFacil: onToggleModoFacil,
                    onToggleNotifications: onToggleNotifications,
                    onChangePassword: onChangePassword,
                    onSeguroPlaceholder: onSeguroPlaceholder,
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: _DadosECardsLeft(
                      fullName: fullName,
                      email: email,
                      phone: phone,
                      nextVisitAt: nextVisitAt,
                      hasPlan: hasPlan,
                      planActive: planActive,
                      planName: planName,
                      planNextBilling: planNextBilling,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: _SettingsRightColumn(
                      modoFacilEnabled: modoFacilEnabled,
                      notificationsEnabled: notificationsEnabled,
                      emergencyContacts: emergencyContacts,
                      onToggleModoFacil: onToggleModoFacil,
                      onToggleNotifications: onToggleNotifications,
                      onChangePassword: onChangePassword,
                      onSeguroPlaceholder: onSeguroPlaceholder,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class _ProfileHeroCard extends StatelessWidget {
  final String fullName;
  final String email;
  final String memberSince;
  final bool verified;
  final VoidCallback onEditProfile;

  const _ProfileHeroCard({
    required this.fullName,
    required this.email,
    required this.memberSince,
    required this.verified,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    final verifiedColor = verified ? const Color(0xFF16A34A) : const Color(0xFFD1D5DB);
    final verifiedLabel = verified ? 'Verificado' : 'Não verificado';

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black.withOpacity(0.06)),
              ),
              child: const Icon(Icons.person_rounded, size: 44, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Membro desde: $memberSince',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Icon(Icons.verified_rounded, color: verifiedColor, size: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: verified ? const Color(0xFFECFDF5) : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: verifiedColor.withOpacity(0.25)),
                        ),
                        child: Text(
                          verifiedLabel,
                          style: TextStyle(
                            color: verifiedColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined, size: 18, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          email,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Align(
              alignment: Alignment.topRight,
              child: OutlinedButton.icon(
                onPressed: onEditProfile,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary.withOpacity(0.25)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                icon: const Icon(Icons.edit_rounded),
                label: const Text(
                  'Editar perfil',
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

class _DadosECardsLeft extends StatelessWidget {
  final String fullName;
  final String email;
  final String phone;

  final DateTime? nextVisitAt;

  final bool hasPlan;
  final bool planActive;
  final String planName;
  final String planNextBilling;

  const _DadosECardsLeft({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.nextVisitAt,
    required this.hasPlan,
    required this.planActive,
    required this.planName,
    required this.planNextBilling,
  });

  @override
  Widget build(BuildContext context) {
    final visitText = nextVisitAt == null
        ? '—'
        : '${nextVisitAt!.day.toString().padLeft(2, '0')}/${nextVisitAt!.month.toString().padLeft(2, '0')}/${nextVisitAt!.year} • ${nextVisitAt!.hour.toString().padLeft(2, '0')}:${nextVisitAt!.minute.toString().padLeft(2, '0')}';

    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_pin_circle_rounded, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Text(
                      'Dados pessoais',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final twoCol = constraints.maxWidth > 500;
                    return GridView.count(
                      crossAxisCount: twoCol ? 2 : 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 3,
                      children: [
                        _InfoTile(icon: Icons.badge_outlined, label: 'Nome completo', value: fullName),
                        _InfoTile(icon: Icons.email_outlined, label: 'Email', value: email),
                        _InfoTile(icon: Icons.phone_outlined, label: 'Telemóvel', value: phone),
                        _InfoTile(icon: Icons.home_outlined, label: 'Morada', value: '—'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.calendar_month_rounded, color: AppColors.primary),
                          SizedBox(width: 10),
                          Text(
                            'Próxima Visita',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        visitText,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Confirme na agenda do app.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.credit_card_rounded, color: AppColors.primary),
                          SizedBox(width: 10),
                          Text(
                            'Plano',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        !hasPlan
                            ? 'Sem plano'
                            : planActive
                                ? 'Ativo: $planName'
                                : 'Inativo: $planName',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        planActive ? 'Próxima cobrança: $planNextBilling' : 'Ative quando quiser',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

class _SettingsRightColumn extends StatelessWidget {
  final bool modoFacilEnabled;
  final bool notificationsEnabled;
  final List<_EmergencyContact> emergencyContacts;

  final ValueChanged<bool> onToggleModoFacil;
  final ValueChanged<bool> onToggleNotifications;

  final VoidCallback onChangePassword;
  final VoidCallback onSeguroPlaceholder;

  const _SettingsRightColumn({
    required this.modoFacilEnabled,
    required this.notificationsEnabled,
    required this.emergencyContacts,
    required this.onToggleModoFacil,
    required this.onToggleNotifications,
    required this.onChangePassword,
    required this.onSeguroPlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: const Color(0xFFFFF5F5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.emergency_share_rounded, color: Color(0xFFEF4444)),
                    SizedBox(width: 10),
                    Text(
                      'Contacto de Emergência',
                      style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFEF4444)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...emergencyContacts.map(
                  (c) => _EmergencyContactCard(contact: c),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.tune_rounded, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Text(
                      'Configurações',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _SettingToggle(
                  icon: Icons.mode_edit_outlined,
                  title: 'Modo Fácil',
                  description: 'Ativa a interface simplificada e atalhos.',
                  value: modoFacilEnabled,
                  onChanged: onToggleModoFacil,
                ),
                const SizedBox(height: 12),
                _SettingToggle(
                  icon: Icons.notifications_outlined,
                  title: 'Notificações',
                  description: 'Receba alertas e lembretes importantes.',
                  value: notificationsEnabled,
                  onChanged: onToggleNotifications,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: onChangePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: const Icon(Icons.password_rounded),
                  label: const Text(
                    'Alterar Senha',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.shield_moon_rounded, color: AppColors.primary),
                    SizedBox(width: 10),
                    Text(
                      'Seguro',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Verifique se você possui seguro ativo.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: onSeguroPlaceholder,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary.withOpacity(0.25)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
                  icon: const Icon(Icons.search_rounded),
                  label: const Text(
                    'Ver seguro',
                    style: TextStyle(fontWeight: FontWeight.w900),
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

class _SettingToggle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingToggle({
    required this.icon,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _EmergencyContactCard extends StatelessWidget {
  final _EmergencyContact contact;

  const _EmergencyContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFB4B4).withOpacity(0.45)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.20)),
            ),
            child: const Icon(Icons.person_rounded, color: Color(0xFFEF4444)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  '${contact.relation} • ${contact.phone}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Ligar',
            onPressed: () {
              // placeholder
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ação de telefone (em breve)')),
              );
            },
            icon: const Icon(Icons.phone_rounded, color: Color(0xFFEF4444)),
          ),
        ],
      ),
    );
  }
}

class _EmergencyContact {
  final String name;
  final String relation;
  final String phone;

  const _EmergencyContact({
    required this.name,
    required this.relation,
    required this.phone,
  });
}

class _LeftMenuDesktop extends StatelessWidget {
  final String fullName;
  final String phone;
  final bool modoFacilEnabled;

  final VoidCallback onLogout;
  final VoidCallback onExit;

  const _LeftMenuDesktop({
    required this.fullName,
    required this.phone,
    required this.modoFacilEnabled,
    required this.onLogout,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: 150,
                      height: 150,
                      child: Icon(Icons.local_hospital_rounded, size: 56),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              fullName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              phone,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 10),

            _LeftMenuTile(
              icon: Icons.lightbulb_rounded,
              title: 'Modo Fácil',
              trailing: Icon(
                modoFacilEnabled ? Icons.check_rounded : Icons.close_rounded,
                size: 18,
                color: AppColors.primary,
              ),
              onTap: () {},
            ),
            _LeftMenuTile(icon: Icons.shopping_bag_outlined, title: 'Meus pedidos', onTap: () {}),
            _LeftMenuTile(icon: Icons.family_restroom_rounded, title: 'Associar um Familiar', onTap: () {}),
            _LeftMenuTile(icon: Icons.question_answer_outlined, title: 'Perguntas Frequentes', onTap: () {}),
            _LeftMenuTile(icon: Icons.support_agent_outlined, title: 'Ajuda', onTap: () {}),
            const SizedBox(height: 6),
            const Divider(height: 1),
            const SizedBox(height: 24),

            _LeftMenuTile(
              icon: Icons.logout_rounded,
              title: 'Sair',
              textColor: const Color(0xFFEF4444),
              iconColor: const Color(0xFFEF4444),
              onTap: onLogout,
            ),
            /*
            _LeftMenuTile(
              icon: Icons.exit_to_app_rounded,
              title: 'Sair',
              textColor: const Color(0xFFEF4444),
              iconColor: const Color(0xFFEF4444),
              onTap: onExit,
            ),
            */
          ],
        ),
      ),
    );
  }
}

class _LeftMenuMobile extends StatelessWidget {
  final String fullName;
  final String phone;
  final bool modoFacilEnabled;
  final VoidCallback onLogout;
  final VoidCallback onExit;

  const _LeftMenuMobile({
    required this.fullName,
    required this.phone,
    required this.modoFacilEnabled,
    required this.onLogout,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return _LeftMenuDesktop(
      fullName: fullName,
      phone: phone,
      modoFacilEnabled: modoFacilEnabled,
      onLogout: onLogout,
      onExit: onExit,
    );
  }
}

class _LeftMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  final Color? iconColor;
  final Color? textColor;

  const _LeftMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final cIcon = iconColor ?? AppColors.primary;
    final cText = textColor ?? AppColors.textPrimary;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.04)),
        ),
        child: Row(
          children: [
            Icon(icon, color: cIcon),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: cText,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
