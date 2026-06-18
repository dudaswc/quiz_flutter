
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
    final int score = ModalRoute.of(context)!.settings.arguments as int;
    final RiskResult result = RiskResult.fromScore(score);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FB),
      appBar: AppBar(
        title: const Text('Resultado'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ResultHero(result: result, score: score),
            const SizedBox(height: 16),
            _SectionCard(
              icon: Icons.psychology_alt_rounded,
              title: 'O que isso significa?',
              child: Text(
                result.description,
                style: const TextStyle(
                  fontSize: 15.5,
                  height: 1.45,
                  color: Color(0xFF5F4C66),
                ),
              ),
            ),
            const SizedBox(height: 14),
            _SectionCard(
              icon: Icons.checklist_rounded,
              title: 'O que fazer agora',
              child: Column(
                children: result.actions
                    .map((action) => _ActionItem(text: action))
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),
            const _EmergencyCard(),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.quizPage,
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Refazer avaliação'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RiskResult {
  final String label;
  final String subtitle;
  final String description;
  final Color color;
  final IconData icon;
  final List<String> actions;

  const RiskResult({
    required this.label,
    required this.subtitle,
    required this.description,
    required this.color,
    required this.icon,
    required this.actions,
  });

  factory RiskResult.fromScore(int score) {
    if (score == 0) {
      return const RiskResult(
        label: 'Sem risco identificado',
        subtitle: 'Nenhum fator crítico foi marcado',
        color: Color(0xFF2E7D32),
        icon: Icons.check_circle_rounded,
        description:
            'Suas respostas não indicaram fatores relevantes de risco neste momento. Ainda assim, é importante observar mudanças de comportamento, ameaças, controle, isolamento ou medo.',
        actions: [
          'Continue observando sinais de controle, ciúme excessivo ou ameaça.',
          'Mantenha contato com pessoas de confiança.',
          'Procure orientação caso a situação mude.',
        ],
      );
    }

    if (score <= 25) {
      return const RiskResult(
        label: 'Risco baixo',
        subtitle: 'Há sinais iniciais que merecem atenção',
        color: Color(0xFF43A047),
        icon: Icons.eco_rounded,
        description:
            'O resultado indica presença de alguns sinais de alerta, mas sem concentração de fatores críticos. A recomendação é observar a evolução da situação e fortalecer sua rede de apoio.',
        actions: [
          'Converse com alguém de confiança sobre o que está acontecendo.',
          'Registre situações que causaram medo, ameaça ou desconforto.',
          'Busque informação sobre seus direitos e canais de apoio.',
        ],
      );
    }

    if (score <= 70) {
      return const RiskResult(
        label: 'Risco moderado',
        subtitle: 'Existem fatores que exigem cuidado',
        color: Color(0xFFF9A825),
        icon: Icons.warning_amber_rounded,
        description:
            'Suas respostas indicam um conjunto de sinais que podem representar agravamento da violência. É importante não lidar com isso sozinha e buscar orientação especializada.',
        actions: [
          'Procure uma rede de apoio segura.',
          'Considere buscar atendimento em serviço especializado ou Delegacia da Mulher.',
          'Evite confrontos diretos em situações de tensão.',
          'Tenha documentos e contatos importantes acessíveis.',
        ],
      );
    }

    if (score <= 140) {
      return const RiskResult(
        label: 'Risco alto',
        subtitle: 'Há sinais importantes de agravamento',
        color: Color(0xFFE53935),
        icon: Icons.report_problem_rounded,
        description:
            'O resultado indica presença de fatores relevantes de risco, como ameaça, agressão, controle ou recorrência. A situação merece atenção imediata e planejamento de segurança.',
        actions: [
          'Busque apoio de pessoas próximas e confiáveis.',
          'Procure atendimento especializado o quanto antes.',
          'Ligue 180 para orientação sobre violência contra a mulher.',
          'Em caso de perigo imediato, ligue 190.',
        ],
      );
    }

    return const RiskResult(
      label: 'Risco extremo',
      subtitle: 'A situação exige proteção imediata',
      color: Color(0xFFB71C1C),
      icon: Icons.emergency_rounded,
      description:
          'As respostas indicam combinação de fatores graves, como agressão intensa, ameaça, escalada de violência ou acesso a armas. A prioridade deve ser sua segurança imediata.',
      actions: [
        'Se estiver em perigo agora, ligue 190 imediatamente.',
        'Procure um local seguro e evite ficar sozinha.',
        'Acione sua rede de apoio de confiança.',
        'Busque atendimento em delegacia, serviço de saúde ou assistência social.',
      ],
    );
  }
}

class _ResultHero extends StatelessWidget {
  final RiskResult result;
  final int score;

  const _ResultHero({
    required this.result,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            result.color,
            const Color(0xFFD81B60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: result.color.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(result.icon, size: 48, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            result.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              height: 1.05,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            result.subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Pontuação: $score pontos',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionCard({
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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEADDEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4ECF7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: const Color(0xFF7B2D8B)),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF2D1235),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
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

class _ActionItem extends StatelessWidget {
  final String text;

  const _ActionItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: 20,
            color: Color(0xFFD81B60),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF5F4C66),
                height: 1.35,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  const _EmergencyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBF2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3C4D9)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Canais de apoio',
            style: TextStyle(
              color: Color(0xFF2D1235),
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
              color: Color(0xFFD81B60),
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
                color: Color(0xFF5F4C66),
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
