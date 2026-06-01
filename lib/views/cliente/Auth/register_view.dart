import 'package:flutter/material.dart';

import 'register_view_v2.dart';

/// Wrapper legada mantida para compatibilidade com imports existentes.
/// O layout e validações reais estão em [RegisterViewV2].
class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterViewV2();
  }
}
