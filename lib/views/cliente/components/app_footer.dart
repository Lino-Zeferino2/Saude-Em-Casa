import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 700;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopRow(isNarrow: isNarrow),
              const SizedBox(height: 16),
              if (!isNarrow) const Divider(height: 1, thickness: 1),
              if (!isNarrow) const SizedBox(height: 16),
              _LinksGrid(isNarrow: isNarrow),
              const SizedBox(height: 18),
              _BottomBar(),
            ],
          );
        },
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow({required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isNarrow ? 92 : 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'logo.png',
                  width: isNarrow ? 72 : 84,
                  height: isNarrow ? 72 : 84,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Container(
                    width: isNarrow ? 72 : 84,
                    height: isNarrow ? 72 : 84,
                    color: AppColors.primary.withOpacity(0.12),
                    alignment: Alignment.center,
                    child: const Icon(Icons.health_and_safety_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saúde em Casa',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Cuidados domiciliares com apoio familiar — simples, humano e confiável.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.75),
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: isNarrow ? 3 : 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              _SocialRow(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const [
        _SocialIcon(
          icon: Icons.facebook_rounded,
          label: 'Facebook',
        ),
        _SocialIcon(
          icon: Icons.telegram_rounded,
          label: 'Telegram',
        ),
        _SocialIcon(
          icon: Icons.chat_rounded,
          label: 'WhatsApp',
        ),
        _SocialIcon(
          icon: Icons.video_call_rounded,
          label: 'YouTube',
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Abrir $label (em breve)')),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

class _LinksGrid extends StatelessWidget {
  const _LinksGrid({required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white.withOpacity(0.78),
          fontWeight: FontWeight.w700,
        );

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FooterColumn(
            title: 'Links úteis',
            children: const [
              _FooterLink(text: 'Como funciona'),
              _FooterLink(text: 'Planos e preços'),
              _FooterLink(text: 'Perguntas frequentes'),
              _FooterLink(text: 'Política de privacidade'),
            ],
            textStyle: textStyle,
          ),
          const SizedBox(height: 14),
          _FooterColumn(
            title: 'Suporte',
            children: const [
              _FooterLink(text: 'Central de Ajuda'),
              _FooterLink(text: 'Fale connosco'),
              _FooterLink(text: 'Termos de serviço'),
            ],
            textStyle: textStyle,
          ),
          const SizedBox(height: 14),
          _FooterColumn(
            title: 'Contactos',
            children: [
              const _FooterContactRow(
                icon: Icons.phone_rounded,
                text: '+244 000 000 000',
              ),
              const _FooterContactRow(
                icon: Icons.mail_rounded,
                text: 'suporte@saudeemcasa.ao',
              ),
              const _FooterContactRow(
                icon: Icons.location_on_rounded,
                text: 'Angola',
              ),
            ],
            textStyle: textStyle,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _FooterColumn(
            title: 'Links úteis',
            children: const [
              _FooterLink(text: 'Como funciona'),
              _FooterLink(text: 'Planos e preços'),
              _FooterLink(text: 'Perguntas frequentes'),
              _FooterLink(text: 'Política de privacidade'),
            ],
            textStyle: textStyle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _FooterColumn(
            title: 'Suporte',
            children: const [
              _FooterLink(text: 'Central de Ajuda'),
              _FooterLink(text: 'Fale connosco'),
              _FooterLink(text: 'Termos de serviço'),
            ],
            textStyle: textStyle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _FooterColumn(
            title: 'Contactos',
            children: const [
              _FooterContactRow(
                icon: Icons.phone_rounded,
                text: '+244 000 000 000',
              ),
              _FooterContactRow(
                icon: Icons.mail_rounded,
                text: 'suporte@saudeemcasa.ao',
              ),
              _FooterContactRow(
                icon: Icons.location_on_rounded,
                text: 'Angola',
              ),
            ],
            textStyle: textStyle,
          ),
        ),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({
    required this.title,
    required this.children,
    required this.textStyle,
  });

  final String title;
  final List<Widget> children;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.w900,
                letterSpacing: -0.1,
              ),
        ),
        const SizedBox(height: 10),
        ...children.map(
          (w) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: w,
          ),
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$text (em breve)')),
        );
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.78),
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _FooterContactRow extends StatelessWidget {
  const _FooterContactRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.78),
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
          ),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '© ${DateTime.now().year} Saúde em Casa. Todos os direitos reservados.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.72),
                  fontWeight: FontWeight.w700,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
