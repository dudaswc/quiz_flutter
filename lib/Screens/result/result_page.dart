
/*
Nome: QuizResult
Descrição: classe responsável pela tela de resultados
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int score =
    ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
      ),
      body: Center(
        child: Text(
          'Resultado final: $score pontos',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}