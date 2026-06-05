import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import 'home_cliente_normal_view.dart';

class HomeClienteFacilView extends StatelessWidget {
  const HomeClienteFacilView({super.key});

  @override
  Widget build(BuildContext context) {
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
           
            Builder(
              builder: (context) {
                final isMobile = MediaQuery.sizeOf(context).width < 600;
                final logoSize = isMobile ? 60.0 : 150.0;

                return Image.asset(
                  'assets/logo.png',
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.local_hospital_rounded),
                );
              },
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (MediaQuery.sizeOf(context).width >= 600)
                  Text(
                    'Saúde em Casa',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                  ),
               if (MediaQuery.sizeOf(context).width >= 600)
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
                  SizedBox(height: 44),
                  // Título
                  Text(
                    'Olá! Como a saúde em Casa pode lhe ajudar hoje?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 32),

                  // Falar / Ouvir
                  // - Web/desktop: mantém duas colunas na mesma linha
                  // - Mobile: empilha em coluna para evitar overflow horizontal
                  Builder(
                    builder: (context) {
                      final width = MediaQuery.sizeOf(context).width;
                      final isMobile = width < 600;

                      final firstCard = _BigRowActionCard(
                        icon: Icons.mic,
                        color: Colors.blue,
                        title: 'Falar com app',
                        subtitle: 'Tire dúvidas',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Falar com app (em breve)')),
                          );
                        },
                      );

                      final secondCard = _BigRowActionCard(
                        icon: Icons.volume_up_rounded,
                        color: Colors.green,
                        title: 'Ouvir a página',
                        subtitle: 'Leitura em voz alta',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ouvir a página (em breve)')),
                          );
                        },
                      );

                      if (isMobile) {
                        return Column(
                          children: [
                            SizedBox(height: 98, child: firstCard),
                            const SizedBox(height: 12),
                            SizedBox(height: 98, child: secondCard),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: firstCard),
                          const SizedBox(width: 12),
                          Expanded(child: secondCard),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Cards principais
                  _BigMenuList(
                    items: [
                      _BigMenuItem(
                        icon: Icons.local_hospital_rounded,
                        title: 'Solicitar Serviços',
                        accentColor: Colors.blue,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Solicitar Serviços (em breve)')),
                          );
                        },
                      ),
                      _BigMenuItem(
                        icon: Icons.receipt_long_rounded,
                        title: 'Ver meus pedidos',
                        accentColor: Colors.blue,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ver meus pedidos (em breve)')),
                          );
                        },
                      ),
                      _BigMenuItem(
                        icon: Icons.help_outline_rounded,
                        title: 'Pedir ajuda',
                        accentColor: Colors.green,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pedir ajuda (em breve)')),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Pequenas dicas (opcional para UX)
                  Card(
                    color: Colors.white.withOpacity(0.92),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: AppColors.primary.withOpacity(0.18)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Dica: use “Ouvir a página” se tiver dificuldade para ler. Use os botões grandes para seguir passo a passo.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.35,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BigRowActionCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BigRowActionCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98,
      child: Card(
        color: Colors.white.withOpacity(0.92),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: color.withOpacity(0.45)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: color.withOpacity(0.25)),
                  ),
                  child: Icon(icon, size: 26, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
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
  final Color accentColor;
  final VoidCallback onTap;

  const _BigMenuItem({
    required this.icon,
    required this.title,
    required this.accentColor,
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
          side: BorderSide(color: item.accentColor.withOpacity(0.35)),
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
                    color: item.accentColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: item.accentColor.withOpacity(0.25)),
                  ),
                  child: Icon(item.icon, size: 26, color: item.accentColor),
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

