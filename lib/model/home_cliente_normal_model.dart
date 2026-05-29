class HomeClienteNormalModel {
  const HomeClienteNormalModel();

  static const List<String> menuItems = [
    'Inicio',
    'Serviços',
    'Formação',
    'Parceiros',
    'Sobre nós',
  ];

  static const List<String> services = [
    'Enfermagem',
    'Cuidados ao Idoso',
    'Fisioterapia',
    'Terapia da Fala',
    'Massagem Terapêutica',
    'Primeiros Socorros',
    'Apoio à Maternidade',
  ];

  static const String referenceTitle = 'Referência em cuidados em casa';
  static const String themeTitle = 'Cuidado e Apoio para sua Saude em casa';
  static const String description =
      'Cuidado humano, acompanhamento e tranquilidade no conforto do seu lar.';

  static const String educationSectionTitle = 'Educação para o Bem Estar';
  static const String educationSectionDescription =
      'Aprenda com profissionais para cuidar melhor da sua saúde em casa.';

  static const String teamImpactTitle = 'Uma equipa que orienta, cuida e inspira';
  static const String teamImpactSubtitle = 'Bem-estar diário começa com informação certa.';

  static const List<Map<String, String>> educationCards = [
    {
      'title': 'Rotina de cuidados',
      'description': 'Dicas práticas para manter consistência com segurança.',
      'icon': 'icons.health_and_safety'
    },
    {
      'title': 'Prevenção em casa',
      'description': 'Como reduzir riscos e identificar sinais cedo.',
      'icon': 'icons.security'
    },
    {
      'title': 'Atendimento humanizado',
      'description': 'Acompanhamento com empatia, respeito e clareza.',
      'icon': 'icons.favorite'
    },
  ];

  static const String trustSectionTitle = 'Vozes de quem Confia';
  static const String trustSectionDescription =
      'Histórias reais de cuidado, apoio e tranquilidade.';

  // mediaType: 'image' | 'video'
  static const List<Map<String, String>> testimonials = [
    {
      'title': 'Cuidado com carinho',
      'description': 'Recebi acompanhamento completo no conforto do meu lar.',
      'mediaType': 'image',
      'mediaAsset': 'assets/doctor_2.png',
      'likes': '128',
      'comments': '22',
    },
    {
      'title': 'Recuperação com confiança',
      'description': 'A equipa orientou cada passo com atenção e segurança.',
      'mediaType': 'video',
      'mediaAsset': 'assets/doctor_3.png',
      'likes': '206',
      'comments': '31',
    },
    {
      'title': 'Apoio familiar que ajuda',
      'description': 'Os conteúdos e visitas deixaram tudo mais claro e tranquilo.',
      'mediaType': 'image',
      'mediaAsset': 'assets/doctor_1.png',
      'likes': '94',
      'comments': '12',
    },
  ];
}
