import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import 'home_cliente_normal_view.dart';


/// Home-Cliente modo Fácil (idosos / baixa familiaridade com apps)
class HomeClienteFacilView extends StatelessWidget {
  const HomeClienteFacilView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 36,
              height: 36,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.local_hospital_rounded),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Saúde em Casa',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                ),
                Text(
                  'Modo Fácil',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // Navegação para modo normal (mantém app atual como destino).
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const HomeClienteNormalView(),
                ),
              );
            },
            icon: const Icon(Icons.speed_rounded),
            label: const Text(
              'Modo Normal',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          IconButton(
            tooltip: 'Ver perfil',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Perfil (em breve)')),
              );
            },
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top: ações grandes e legíveis
                  isMobile
                      ? Column(
                          children: [
                            _BigRowActions(
                              actions: [
                                _BigAction(
                                  icon: Icons.chat_bubble_rounded,
                                  title: 'Falar com app',
                                  subtitle: 'Tire dúvidas (demo)',
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Falar com app (em breve)')),
                                    );
                                  },
                                ),
                                _BigAction(
                                  icon: Icons.volume_up_rounded,
                                  title: 'Ouvir a página',
                                  subtitle: 'Leitura em voz alta (demo)',
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Ouvir a página (em breve)')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _BigRowActions(
                                actions: [
                                  _BigAction(
                                    icon: Icons.chat_bubble_rounded,
                                    title: 'Falar com app',
                                    subtitle: 'Tire dúvidas (demo)',
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Falar com app (em breve)')),
                                      );
                                    },
                                  ),
                                  _BigAction(
                                    icon: Icons.volume_up_rounded,
                                    title: 'Ouvir a página',
                                    subtitle: 'Leitura em voz alta (demo)',
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Ouvir a página (em breve)')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                  const SizedBox(height: 16),

                  // Lista principal: botões grandes
                  _BigMenuList(
                    items: [
                      _BigMenuItem(
                        icon: Icons.local_hospital_rounded,
                        title: 'Solicitar Serviços',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Solicitar Serviços (em breve)')),
                          );
                        },
                      ),
                      _BigMenuItem(
                        icon: Icons.receipt_long_rounded,
                        title: 'Ver meus pedidos',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ver meus pedidos (em breve)')),
                          );
                        },
                      ),
                      _BigMenuItem(
                        icon: Icons.help_outline_rounded,
                        title: 'Pedir ajuda',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pedir ajuda (em breve)')),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Bloco final: instruções (melhor UX)
                  _SupportTips(
                    tips: [
                      'Se tiver dificuldade, use “Ouvir a página”.',
                      'Use “Falar com app” para tirar dúvidas.',
                      'Botões grandes para facilitar a leitura.',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class _BigRowActions extends StatelessWidget {
  final List<_BigAction> actions;
  const _BigRowActions({required this.actions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: actions
          .map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _BigActionCard(action: a),
            ),
          )
          .toList(),
    );
  }
}

class _BigAction {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BigAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class _BigActionCard extends StatelessWidget {
  final _BigAction action;
  const _BigActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98,
      child: Card(
        color: Colors.white.withOpacity(0.92),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: AppColors.primary.withOpacity(0.18)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: action.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withOpacity(0.18)),
                  ),
                  child: Icon(action.icon, size: 26, color: AppColors.primary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        action.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        action.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.25,
                            ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BigMenuList extends StatelessWidget {
  final List<_BigMenuItem> items;
  const _BigMenuList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (it) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _BigMenuButton(item: it),
            ),
          )
          .toList(),
    );
  }
}

class _BigMenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _BigMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class _BigMenuButton extends StatelessWidget {
  final _BigMenuItem item;
  const _BigMenuButton({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: Card(
        color: Colors.white.withOpacity(0.92),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: AppColors.primary.withOpacity(0.18)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withOpacity(0.18)),
                  ),
                  child: Icon(item.icon, size: 26, color: AppColors.primary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SupportTips extends StatelessWidget {
  final List<String> tips;
  const _SupportTips({required this.tips});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.92),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: AppColors.primary.withOpacity(0.18)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Dicas rápidas',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 10),
            ...tips.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    t,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.35,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

