import 'package:flutter/material.dart';

class HomeClienteNormalPublicacoesController {
  const HomeClienteNormalPublicacoesController();

  void onSeeAllPosts(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ver todas as publicações (em breve)'),
      ),
    );
  }

  void onSeeAllTips(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ver todas as dicas (em breve)'),
      ),
    );
  }

  void onLike(BuildContext context, {required String label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(label),
      ),
    );
  }

  void onComment(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comentários em breve'),
      ),
    );
  }

  void onReadPost(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abrir publicação (em breve)'),
      ),
    );
  }

  void onReadTip(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abrir dica (em breve)'),
      ),
    );
  }
}
