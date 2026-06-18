
/*
Nome: QuizResult
Descrição: classe responsável pela tela de resultados
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'package:flutter/material.dart';
import '../../common/app_routes.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final double vulnerability = args['vulnerability'] as double;
    final double threat = args['threat'] as double;
    final double risk = args['risk'] as double;
    final String classification = args['classification'] as String;
    final List answers = args['answers'] as List;
    final bool identified = args['identified'] as bool? ?? false;
    final Map<String, dynamic>? userData =
        args['userData'] as Map<String, dynamic>?;

    final Color classColor = _classificationColor(classification);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FB),
      appBar: AppBar(title: const Text('Relatório AR PAX')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildResultTable(
              vulnerability,
              threat,
              risk,
              classification,
              classColor,
            ),
            const SizedBox(height: 16),
            _buildIdentificationCard(identified, userData),
            const SizedBox(height: 24),
            _buildExplanation(),
            const SizedBox(height: 24),
            _buildQuestionnaire(answers),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.quizPage,
                    (route) => false,
                  );
                },
                child: const Text('Refazer avaliação'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _classificationColor(String value) {
    switch (value) {
      case 'Muito Baixo':
        return const Color(0xFF2E7D32);
      case 'Baixo':
        return const Color(0xFF43A047);
      case 'Moderado':
        return const Color(0xFFFFB300);
      case 'Alto':
        return const Color(0xFFE53935);
      case 'Extremo':
        return const Color(0xFFB71C1C);
      default:
        return const Color(0xFF7B2D8B);
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF8E2F60),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        children: [
          Text(
            'desperte mulher',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Relatório de Análise de Risco – AR PAX',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Formulário Nacional de Avaliação de Riscos — Violência Doméstica e Familiar Contra a Mulher',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultTable(
    double vulnerability,
    double threat,
    double risk,
    String classification,
    Color classColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEADDEA)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resultado da Avaliação',
            style: TextStyle(
              color: Color(0xFF8E2F60),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          _ResultRow(
            label: 'Nível de Vulnerabilidade:',
            value: '${vulnerability.toStringAsFixed(2)} %',
          ),
          _ResultRow(
            label: 'Nível de Ameaça:',
            value: '${threat.toStringAsFixed(2)} %',
          ),
          _ResultRow(
            label: 'Grau de Risco:',
            value: '${risk.toStringAsFixed(2)} %',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Classificação de Risco:',
                  style: TextStyle(
                    color: Color(0xFF5F4C66),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: classColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  classification,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIdentificationCard(
    bool identified,
    Map<String, dynamic>? userData,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEADDEA)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Identificação',
            style: TextStyle(
              color: Color(0xFF8E2F60),
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          if (!identified)
            const Text(
              'Relatório gerado de forma anônima.',
              style: TextStyle(
                color: Color(0xFF5F4C66),
                fontWeight: FontWeight.w600,
              ),
            )
          else ...[
            _ResultRow(
              label: 'Nome:',
              value: userData?['name'] ?? 'Não informado',
            ),
            _ResultRow(
              label: 'Documento:',
              value: userData?['document'] ?? 'Não informado',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExplanation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'O presente relatório possui caráter técnico, informativo e não vinculante, destinando-se a subsidiar profissionais da rede de proteção às vítimas de violência doméstica, da Segurança Pública e do Sistema de Justiça na análise de fatores de risco e no apoio à tomada de decisões.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF332033),
            fontWeight: FontWeight.w800,
            height: 1.45,
          ),
        ),
        SizedBox(height: 22),
        Text(
          'A Análise de Risco Pax (AR Pax) é uma metodologia utilizada para qualificar tecnicamente o processo decisório sobre medidas protetivas de urgência. O modelo parte do Formulário Nacional de Avaliação de Risco e transforma as respostas em uma estimativa baseada em dois pilares: vulnerabilidade da vítima e ameaça do agressor.',
          style: TextStyle(
            color: Color(0xFF332033),
            height: 1.45,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Muito Baixo: correlação mínima entre vulnerabilidade e ameaça. Baixo: sem correlação significativa. Moderado: presença de potencial razoável de evento adverso. Alto: potencial significativo para ocorrência ou agravamento. Extremo: ameaça e vulnerabilidade muito altas, com necessidade de ação imediata.',
          style: TextStyle(
            color: Color(0xFF332033),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionnaire(List answers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFC54E82),
          child: const Text(
            'Questionário',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(answers.length, (index) {
          final item = answers[index] as Map<String, dynamic>;
          final selected = (item['answers'] as List).join(', ');

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFEADDEA)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ${item['question']}',
                  style: const TextStyle(
                    color: Color(0xFF332033),
                    fontWeight: FontWeight.w900,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selected,
                  style: const TextStyle(
                    color: Color(0xFF5F4C66),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;

  const _ResultRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEADDEA)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF5F4C66),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF332033),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
