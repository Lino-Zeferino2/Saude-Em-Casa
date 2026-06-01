import 'package:flutter/material.dart';

class HomeClienteServicosModel {
  const HomeClienteServicosModel._();

  static const String title = 'Nossos Serviços';
  static const String description =
      'Cuidados domiciliares com apoio humano e confiança — do agendamento à assistência contínua.';

  static const List<ServiceItem> services = [
  ServiceItem(
    icon: Icons.local_hospital_rounded,
    title: 'Enfermagem',
    description:
        'Curativos, injeções, monitorização e cuidados de enfermagem ao domicílio.',
  ),

  ServiceItem(
    icon: Icons.accessibility_new_rounded,
    title: 'Fisioterapia',
    description:
        'Reabilitação física, recuperação funcional e acompanhamento personalizado.',
  ),

  ServiceItem(
    icon: Icons.record_voice_over_rounded,
    title: 'Terapia da Fala',
    description:
        'Avaliação e acompanhamento para crianças e adultos com dificuldades de comunicação.',
  ),

  ServiceItem(
    icon: Icons.elderly_rounded,
    title: 'Cuidados ao Idoso',
    description:
        'Acompanhamento diário, higiene, alimentação e apoio especializado.',
  ),

  ServiceItem(
    icon: Icons.bed_rounded,
    title: 'Cuidados ao Acamado',
    description:
        'Assistência completa para pacientes com mobilidade reduzida.',
  ),

  ServiceItem(
    icon: Icons.healing_rounded,
    title: 'Curativos e Ferimentos',
    description:
        'Tratamento, limpeza e acompanhamento da evolução de feridas.',
  ),

  ServiceItem(
    icon: Icons.medication_rounded,
    title: 'Gestão de Medicação',
    description:
        'Organização, controlo e acompanhamento do tratamento prescrito.',
  ),

  ServiceItem(
    icon: Icons.medical_services_rounded,
    title: 'Primeiros Socorros',
    description:
        'Atendimento inicial e orientação para situações que exigem cuidados imediatos.',
  ),

  ServiceItem(
    icon: Icons.local_pharmacy_rounded,
    title: 'Medicamentos',
    description:
        'Solicitação e entrega de medicamentos através de farmácias parceiras.',
  ),

  ServiceItem(
    icon: Icons.family_restroom_rounded,
    title: 'Acompanhamento Familiar',
    description:
        'Monitorização e comunicação entre familiares e profissionais.',
  ),

  ServiceItem(
    icon: Icons.school_rounded,
    title: 'Formação para Cuidadores',
    description:
        'Capacitação prática para familiares, cuidadores e babás.',
  ),

  ServiceItem(
    icon: Icons.child_care_rounded,
    title: 'Crianças Especiais',
    description:
        'Orientação e apoio especializado para famílias com necessidades específicas.',
  ),

  ServiceItem(
    icon: Icons.video_library_rounded,
    title: 'Vídeos Educativos',
    description:
        'Conteúdos sobre saúde, mobilização, prevenção e cuidados em casa.',
  ),

  ServiceItem(
    icon: Icons.groups_rounded,
    title: 'Comunidade',
    description:
        'Partilha de experiências, testemunhos e apoio entre famílias.',
  ),

  ServiceItem(
    icon: Icons.business_center_rounded,
    title: 'Parceiros de Saúde',
    description:
        'Hospitais, clínicas e laboratórios integrados à rede Saúde em Casa.',
  ),
];
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
