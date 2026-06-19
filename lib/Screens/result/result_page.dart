
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

  static const Color lavenderDark = Color(0xFF7E6BC4);
  static const Color lavender = Color(0xFFA78BFA);
  static const Color babyPink = Color(0xFFF4C2D7);
  static const Color babyPinkLight = Color(0xFFFBE4EE);
  static const Color background = Color(0xFFFCFAFF);
  static const Color border = Color(0xFFE9DDF7);
  static const Color textPrimary = Color(0xFF2F2638);
  static const Color textSecondary = Color(0xFF6C6480);

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
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Relatório de Risco'),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [lavenderDark, lavender, babyPink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(classification, risk, classColor),
            const SizedBox(height: 16),
            _buildIdentificationCard(identified, userData),
            const SizedBox(height: 16),
            _buildRiskIndicators(vulnerability, threat, risk),
            const SizedBox(height: 16),
            _buildInterpretation(classification),
            const SizedBox(height: 16),
            _buildRecommendations(classification),
            const SizedBox(height: 16),
            _buildEmergencyCard(),
            const SizedBox(height: 24),
            _buildQuestionnaire(answers),
            const SizedBox(height: 24),
            _GradientButton(
              text: 'Refazer avaliação',
              icon: Icons.refresh_rounded,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.quizPage,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _classificationColor(String value) {
    switch (value) {
      case 'Muito Baixo':
        return const Color(0xFF81C784);
      case 'Baixo':
        return const Color(0xFF66BB6A);
      case 'Moderado':
        return const Color(0xFFFFCA28);
      case 'Alto':
        return const Color(0xFFFF8A80);
      case 'Extremo':
        return const Color(0xFFE57373);
      default:
        return lavenderDark;
    }
  }

  IconData _classificationIcon(String value) {
    switch (value) {
      case 'Muito Baixo':
      case 'Baixo':
        return Icons.check_circle_rounded;
      case 'Moderado':
        return Icons.warning_amber_rounded;
      case 'Alto':
        return Icons.report_problem_rounded;
      case 'Extremo':
        return Icons.emergency_rounded;
      default:
        return Icons.shield_rounded;
    }
  }

  Widget _buildHero(String classification, double risk, Color classColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [lavenderDark, lavender, babyPink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x337E6BC4),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'desperte mulher',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Relatório de Análise de Risco',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Baseado no Formulário Nacional de Avaliação de Riscos e estruturado a partir da lógica AR PAX.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: classColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _classificationIcon(classification),
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Classificação de risco',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        classification,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Grau calculado: ${risk.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentificationCard(
    bool identified,
    Map<String, dynamic>? userData,
  ) {
    return _Card(
      icon: Icons.lock_outline_rounded,
      title: 'Identificação',
      child: identified
          ? Column(
              children: [
                _InfoRow(label: 'Nome', value: userData?['name'] ?? 'Não informado'),
                _InfoRow(label: 'Documento', value: userData?['document'] ?? 'Não informado'),
              ],
            )
          : const Text(
              'Relatório gerado de forma anônima. Nenhum dado pessoal foi informado antes da emissão do relatório.',
              style: TextStyle(
                color: textSecondary,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  Widget _buildRiskIndicators(
    double vulnerability,
    double threat,
    double risk,
  ) {
    return _Card(
      icon: Icons.insights_rounded,
      title: 'Indicadores de risco',
      child: Column(
        children: [
          _ProgressMetric(
            label: 'Vulnerabilidade da vítima',
            value: vulnerability,
            color: lavender,
          ),
          const SizedBox(height: 14),
          _ProgressMetric(
            label: 'Ameaça do agressor',
            value: threat,
            color: babyPink,
          ),
          const SizedBox(height: 14),
          _ProgressMetric(
            label: 'Grau geral de risco',
            value: risk,
            color: lavenderDark,
          ),
        ],
      ),
    );
  }

  Widget _buildInterpretation(String classification) {
    return _Card(
      icon: Icons.psychology_alt_rounded,
      title: 'Leitura interpretativa',
      child: Text(
        _interpretationText(classification),
        style: const TextStyle(
          color: textSecondary,
          height: 1.5,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _interpretationText(String classification) {
    switch (classification) {
      case 'Muito Baixo':
        return 'As respostas indicam baixa presença de fatores associados à ameaça e à vulnerabilidade. Ainda assim, o relatório recomenda atenção a mudanças de comportamento, controle, isolamento ou ameaças futuras.';
      case 'Baixo':
        return 'Foram identificados sinais iniciais de risco, mas sem concentração elevada de fatores críticos. A situação deve ser acompanhada e a rede de apoio deve ser fortalecida.';
      case 'Moderado':
        return 'O resultado demonstra presença relevante de fatores de risco. A combinação entre vulnerabilidade e ameaça exige atenção, orientação especializada e planejamento preventivo.';
      case 'Alto':
        return 'As respostas indicam fatores importantes de agravamento, como ameaça, controle, agressões ou intensificação da violência. Recomenda-se busca imediata por apoio e orientação da rede de proteção.';
      case 'Extremo':
        return 'O resultado aponta combinação intensa de ameaça e vulnerabilidade. Nessa classificação, a prioridade é a proteção imediata, acionamento da rede de apoio e, em caso de perigo atual, contato com serviços de emergência.';
      default:
        return 'O relatório apresenta uma leitura técnica e informativa dos fatores declarados durante o preenchimento da avaliação.';
    }
  }

  Widget _buildRecommendations(String classification) {
    final recommendations = _recommendationsByRisk(classification);

    return _Card(
      icon: Icons.checklist_rounded,
      title: 'Recomendações iniciais',
      child: Column(
        children: recommendations.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: lavenderDark,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: textSecondary,
                      height: 1.4,
                      fontSize: 14.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  List<String> _recommendationsByRisk(String classification) {
    switch (classification) {
      case 'Muito Baixo':
      case 'Baixo':
        return [
          'Observar possíveis mudanças de comportamento, controle ou ameaça.',
          'Manter contato com pessoas de confiança.',
          'Buscar orientação caso a situação se intensifique.',
        ];
      case 'Moderado':
        return [
          'Fortalecer a rede de apoio familiar, comunitária ou institucional.',
          'Registrar episódios de ameaça, agressão ou controle.',
          'Buscar orientação especializada em serviços de proteção à mulher.',
          'Evitar lidar sozinha com situações de conflito ou tensão.',
        ];
      case 'Alto':
        return [
          'Procurar atendimento especializado o quanto antes.',
          'Considerar solicitação de medida protetiva, quando aplicável.',
          'Ligar 180 para orientação sobre violência contra a mulher.',
          'Em caso de perigo imediato, ligar 190.',
        ];
      case 'Extremo':
        return [
          'Priorizar a saída para um local seguro.',
          'Acionar imediatamente uma pessoa de confiança.',
          'Ligar 190 em caso de risco atual ou iminente.',
          'Buscar suporte em delegacia, serviço de saúde ou assistência social.',
        ];
      default:
        return [
          'Buscar orientação caso exista medo, ameaça ou situação de violência.',
        ];
    }
  }

  Widget _buildEmergencyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [babyPinkLight, Color(0xFFF7EEFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Canais de apoio',
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 12),
          _EmergencyItem(number: '190', label: 'Polícia Militar — emergência'),
          _EmergencyItem(number: '180', label: 'Central de Atendimento à Mulher'),
          _EmergencyItem(number: '192', label: 'SAMU — urgência médica'),
          _EmergencyItem(number: '197', label: 'Polícia Civil'),
        ],
      ),
    );
  }

  Widget _buildQuestionnaire(List answers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [lavenderDark, lavender, babyPink],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'Resumo das respostas',
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
              border: Border.all(color: border),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ${item['question']}',
                  style: const TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.w900,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selected,
                  style: const TextStyle(
                    color: textSecondary,
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

class _Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _Card({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ResultPage.border),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x147E6BC4),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ResultPage.lavender, ResultPage.babyPink],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 21),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: ResultPage.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ResultPage.border),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: const TextStyle(
                color: ResultPage.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: ResultPage.textPrimary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ProgressMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final normalized = (value / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: ResultPage.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              '${value.toStringAsFixed(2)}%',
              style: const TextStyle(
                color: ResultPage.textPrimary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: normalized,
            minHeight: 10,
            backgroundColor: ResultPage.border,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _EmergencyItem extends StatelessWidget {
  final String number;
  final String label;

  const _EmergencyItem({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Container(
            width: 54,
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ResultPage.lavenderDark, ResultPage.babyPink],
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: ResultPage.textSecondary,
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _GradientButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              ResultPage.lavenderDark,
              ResultPage.lavender,
              ResultPage.babyPink,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x337E6BC4),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
       
        
           
        


  
