import 'package:flutter/foundation.dart';

class HomeClienteNormalPublicacoesModel {
  const HomeClienteNormalPublicacoesModel();

  static const List<Map<String, String>> posts = [
    {
      'author': 'Saúde em Casa',
      'authorRole': 'Cuidados & Bem-estar',
      'content':
          'Pequenas rotinas fazem uma grande diferença. Dica rápida para manter consistência no cuidado diário.',
      'mediaType': 'image',
      'mediaAsset': 'assets/doctor_1.png',
      'likes': '128',
      'comments': '22',
    },
    {
      'author': 'Equipa Profissional',
      'authorRole': 'Educação em saúde',
      'content':
          'Como identificar sinais cedo e agir com tranquilidade em casa. (Conteúdo para sua família.)',
      'mediaType': 'video',
      'mediaAsset': 'assets/doctor_3.png',
      'likes': '206',
      'comments': '31',
    },
    {
      'author': 'Famílias que confiam',
      'authorRole': 'Histórias reais',
      'content':
          'Sem complicações: acompanhamento humano, linguagem simples e apoio contínuo.',
      'mediaType': 'none',
      'mediaAsset': '',
      'likes': '94',
      'comments': '12',
    },
    // Só texto (nenhuma imagem / nenhum vídeo)
    {
      'author': 'Saúde em Casa',
      'authorRole': 'Cuidados & Bem-estar',
      'content':
          'Se tiver dúvidas, peça ajuda. Cuidar é um processo — e você não está sozinho(a).',
      'mediaType': 'none',
      'mediaAsset': '',
      'likes': '61',
      'comments': '7',
    },
  ];

  static const List<Map<String, String>> dicas = [
    {
      'title': 'Higiene com carinho',
      'description': 'Como manter o cuidado diário de forma simples e segura.',
      'mediaType': 'image',
      'mediaAsset': 'assets/doctor_3.png',
      'likes': '73',
      'comments': '9',
    },
    {
      'title': 'Alimentação & energia',
      'description': 'Rotina alimentar com foco em bem-estar no conforto do lar.',
      'mediaType': 'none',
      'mediaAsset': '',
      'likes': '44',
      'comments': '4',
    },
    {
      'title': 'Prevenção em casa',
      'description': 'Sinais a observar e atitudes que evitam complicações.',
      'mediaType': 'video',
      'mediaAsset': 'assets/doctor_3.png',
      'likes': '52',
      'comments': '5',
    },
    {
      'title': 'Conforto e tranquilidade',
      'description': 'Apoio emocional e orientações claras para a família.',
      'mediaType': 'none',
      'mediaAsset': '',
      'likes': '39',
      'comments': '3',
    },
  ];
}
