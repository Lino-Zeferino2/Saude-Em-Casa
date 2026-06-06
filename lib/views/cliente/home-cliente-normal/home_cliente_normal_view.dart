import 'package:flutter/material.dart';
import 'package:saudeemcasa/views/cliente/home-cliente-normal/home_cliente_formacao_view.dart';

import '../../../controller/home_cliente_normal_controller.dart';
import '../../../model/home_cliente_normal_model.dart';
import '../../../theme/app_colors.dart';

import '../components/equipe_educacao_bem_estar_section.dart';
import '../components/hero_header.dart';
import '../components/publicacoes_section.dart';
import '../components/services_horizontal_list.dart';
import '../components/testemunhos_section.dart';
import 'home_cliente_servicos_view.dart';
import 'home_cliente_parceiros_view.dart';
import 'home_cliente_meus_pedidos_view.dart';
import 'home_cliente_perfil_view.dart';

import '../../../utils/local_storage_service.dart';
import '../components/app_footer.dart';

class HomeClienteNormalView extends StatefulWidget {
  const HomeClienteNormalView({super.key});

  @override
  State<HomeClienteNormalView> createState() => _HomeClienteNormalViewState();
}

class _HomeClienteNormalViewState extends State<HomeClienteNormalView> {
  final controller = const HomeClienteNormalController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String activeMenu = HomeClienteNormalModel.menuItems.first;

  bool get isMobile => MediaQuery.of(context).size.width < 500;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final session = await LocalStorageService.getSession();
    final email = session?['userEmail'];
    final phone = session?['userPhone'];

    if (!mounted) return;

    setState(() {
      isLoggedIn =
          (email != null && email.toString().isNotEmpty) ||
              (phone != null && phone.toString().isNotEmpty);
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onMenuSelected(String item) {
    setState(() => activeMenu = item);

    if (item == 'Serviços') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const HomeClienteServicosView()),
      );
      return;
    } else if (item == 'Formação') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const HomeClienteFormacaoView()),
      );
      return;
    } else if (item == 'Parceiros') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const HomeClienteParceirosView()),
      );
      return;
    } else if (item == 'Meus Pedidos') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const HomeClienteMeusPedidosView()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Em breve: $item')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double logoSize = isMobile ? 44.0 : 64.0;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'logo.png',
                      height: 44,
                      width: 44,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          child: const SizedBox.shrink(),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Saúde em Casa',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: HomeClienteNormalModel.menuItems.map((e) {
                    final isActive = e == activeMenu;
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      selected: isActive,
                      title: Text(
                        e,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: isActive ? AppColors.primary : null,
                              fontWeight: isActive ? FontWeight.w900 : FontWeight.w800,
                            ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _onMenuSelected(e);
                      },
                    );
                  }).toList(),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: isLoggedIn
                      ? (isMobile
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Placeholder: futuramente abrir perfil
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Perfil',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            )
                          : Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B6CFF),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconButton(
                                tooltip: 'Perfil',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Placeholder: futuramente abrir perfil
                                },
                                icon: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ))
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            controller.onLoginPressed(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 6,
        leading: isMobile
            ? IconButton(
                tooltip: 'Menu',
                icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
                onPressed: _openDrawer,
              )
            : null,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'logo.png',
                height: logoSize,
                width: logoSize,
                errorBuilder: (context, error, stackTrace) {
                  return CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.15),
                    child: const SizedBox.shrink(),
                  );
                },
              ),
            ),
            if (!isMobile)
              Text(
                'Saúde em Casa',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                      color: AppColors.primary,
                    ),
              ),
          ],
        ),
        actions: [
          if (!isMobile)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    alignment: WrapAlignment.end,
                    children: HomeClienteNormalModel.menuItems.map((item) {
                      final isActive = item == activeMenu;
                      return InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => _onMenuSelected(item),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                                  fontWeight: isActive ? FontWeight.w900 : FontWeight.w800,
                                ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 14),
                  if (!isLoggedIn)
                    SizedBox(
                      height: 40,
                      child: FilledButton(
                        onPressed: () => controller.onLoginPressed(context),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    )
                  else
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B6CFF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        tooltip: 'Perfil',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const HomeClientePerfilView(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if (!isMobile) const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeroHeader(
                onSchedule: () => controller.onSchedulePressed(context),
                onPlans: () => controller.onPlansPressed(context),
              ),
              const SizedBox(height: 14),
              ServicesHorizontalList(services: HomeClienteNormalModel.services),
              const SizedBox(height: 18),
              EquipeEducacaoBemEstarSection(
                onReadMore: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Em breve: mais conteúdos de bem-estar')),
                  );
                },
              ),
              const SizedBox(height: 34),
              const TestemunhosSection(),
              const SizedBox(height: 18),
              PublicacoesSection(),
              const SizedBox(height: 26),
              const AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
