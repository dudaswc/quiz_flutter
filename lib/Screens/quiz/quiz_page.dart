/*
Nome: QuizPage
Descrição: classe responsavel por modelar um widget para aprsentar na tela com diversas questões
Autor: Silvano Malfatti
Data: 13/06/2026
 */


import 'package:flutter/material.dart';
import '../../common/app_routes.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class RiskOption {
  final String title;
  final double threat;
  final double vulnerability;
  final bool exclusive;

  const RiskOption({
    required this.title,
    this.threat = 0,
    this.vulnerability = 0,
    this.exclusive = false,
  });
}

class RiskQuestion {
  final String title;
  final bool multiple;
  final List<RiskOption> options;

  const RiskQuestion({
    required this.title,
    required this.options,
    this.multiple = false,
  });
}

class _QuizPageState extends State<QuizPage> {
  int currentPage = 0;
  bool highContrast = false;

  final Map<int, Set<int>> selectedAnswers = {};

  static const Color lavenderBackground = Color(0xFFFAF7FF);
  static const Color lavenderDark = Color(0xFF6D5D8F);
  static const Color lavenderMain = Color(0xFF8E7AB5);
  static const Color lavenderLight = Color(0xFFEDE7F6);
  static const Color lavenderBorder = Color(0xFFE3D8F1);
  static const Color textDark = Color(0xFF2F2638);
  static const Color textMuted = Color(0xFF675A73);

  Color get pageBackground =>
      highContrast ? Colors.black : lavenderBackground;

  Color get cardBackground =>
      highContrast ? Colors.black : Colors.white;

  Color get primaryText =>
      highContrast ? Colors.white : textDark;

  Color get secondaryText =>
      highContrast ? Colors.white70 : textMuted;

  Color get borderColor =>
      highContrast ? Colors.white : lavenderBorder;

  final List<RiskQuestion> questions = const [
    RiskQuestion(
      title: 'O(A) agressor(a) já ameaçou você ou algum familiar com a finalidade de atingi-la?',
      options: [
        RiskOption(title: 'Sim, utilizando arma de fogo', threat: 18),
        RiskOption(title: 'Sim, utilizando faca', threat: 15),
        RiskOption(title: 'Sim, de outra forma', threat: 10),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) já praticou alguma(s) dessas agressões físicas contra você?',
      multiple: true,
      options: [
        RiskOption(title: 'Afogamento', threat: 18),
        RiskOption(title: 'Chute', threat: 10),
        RiskOption(title: 'Empurrão', threat: 6),
        RiskOption(title: 'Enforcamento', threat: 20),
        RiskOption(title: 'Estrangulamento', threat: 22),
        RiskOption(title: 'Facada', threat: 25),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Outra', threat: 6),
        RiskOption(title: 'Paulada', threat: 14),
        RiskOption(title: 'Puxão de Cabelo', threat: 5),
        RiskOption(title: 'Queimadura', threat: 18),
        RiskOption(title: 'Soco', threat: 10),
        RiskOption(title: 'Sufocamento', threat: 20),
        RiskOption(title: 'Tapa', threat: 4),
        RiskOption(title: 'Tiro', threat: 30),
      ],
    ),
    RiskQuestion(
      title: 'Você necessitou de atendimento médico e/ou internação após algumas dessas agressões?',
      options: [
        RiskOption(title: 'Sim, Atendimento Médico', threat: 12, vulnerability: 4),
        RiskOption(title: 'Sim, Internação', threat: 18, vulnerability: 6),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) já obrigou você a ter relações sexuais ou praticar atos sexuais contra a sua vontade?',
      options: [
        RiskOption(title: 'Sim', threat: 20, vulnerability: 8),
        RiskOption(title: 'Não sei', threat: 8, vulnerability: 4),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) persegue você, demonstra ciúme excessivo, tenta controlar sua vida e as coisas que você faz?',
      options: [
        RiskOption(title: 'Sim', threat: 12, vulnerability: 6),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Não sei', threat: 4, vulnerability: 2),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) já teve algum destes comportamentos?',
      multiple: true,
      options: [
        RiskOption(title: 'Disse algo parecido com a frase “Se não for minha não será de mais ninguém”', threat: 18),
        RiskOption(title: 'Perturbou, perseguiu ou vigiou você nos locais que frequenta', threat: 14),
        RiskOption(title: 'Proibiu você de visitar familiares ou amigos', threat: 8, vulnerability: 6),
        RiskOption(title: 'Proibiu você de trabalhar ou estudar', threat: 8, vulnerability: 8),
        RiskOption(title: 'Fez telefonemas, enviou mensagens pelo celular ou e-mails de forma insistente', threat: 6),
        RiskOption(title: 'Impediu você de ter acesso a dinheiro, conta bancária ou outros bens como documentos', threat: 8, vulnerability: 10),
        RiskOption(title: 'Teve outros comportamentos de ciúme excessivo e de controle sobre você', threat: 6, vulnerability: 4),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Você já registrou ocorrência policial ou formulou pedido de medida protetiva de urgência envolvendo esse(a) mesmo(a) agressor(a)?',
      options: [
        RiskOption(title: 'Sim', threat: 10),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) já descumpriu medida protetiva anteriormente?',
      options: [
        RiskOption(title: 'Sim', threat: 18),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Não sei', threat: 4),
      ],
    ),
    RiskQuestion(
      title: 'As agressões ou ameaças do(a) agressor(a) contra você se tornaram mais frequentes ou mais graves nos últimos meses?',
      options: [
        RiskOption(title: 'Sim', threat: 18),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Não sei', threat: 4),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) está com dificuldades financeiras, está desempregado ou tem dificuldade de se manter no emprego?',
      options: [
        RiskOption(title: 'Sim', vulnerability: 8),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Não sei', vulnerability: 2),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) já usou, ameaçou usar arma de fogo contra você ou tem fácil acesso a uma arma?',
      options: [
        RiskOption(title: 'Sim, usou', threat: 30),
        RiskOption(title: 'Sim, ameaçou usar', threat: 24),
        RiskOption(title: 'Tem fácil acesso', threat: 18),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Não sei', threat: 6),
      ],
    ),
    RiskQuestion(
      title: 'O(A) agressor(a) já ameaçou ou agrediu seus filhos, outros familiares, amigos, colegas de trabalho, pessoas desconhecidas ou animais?',
      multiple: true,
      options: [
        RiskOption(title: 'Sim, filhos', threat: 16, vulnerability: 8),
        RiskOption(title: 'Sim, outros familiares', threat: 12),
        RiskOption(title: 'Sim, amigos', threat: 10),
        RiskOption(title: 'Sim, colegas de trabalho', threat: 10),
        RiskOption(title: 'Sim, outras pessoas', threat: 8),
        RiskOption(title: 'Sim, animais', threat: 8),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Não sei', threat: 3),
      ],
    ),
    RiskQuestion(
      title: 'Você se separou recentemente do(a) agressor(a), tentou ou manifestou intenção de se separar?',
      options: [
        RiskOption(title: 'Sim', threat: 12, vulnerability: 6),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Você tem filhos?',
      options: [
        RiskOption(title: 'Sim, com o(a) agressor(a)', vulnerability: 8),
        RiskOption(title: 'Sim, de outro relacionamento', vulnerability: 5),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Qual a faixa etária de seus filhos?',
      options: [
        RiskOption(title: '0 a 11 anos', vulnerability: 8),
        RiskOption(title: 'A partir de 18', vulnerability: 2),
        RiskOption(title: '12 a 17 anos', vulnerability: 5),
      ],
    ),
    RiskQuestion(
      title: 'Algum de seus filhos é pessoa com deficiência?',
      options: [
        RiskOption(title: 'Sim', vulnerability: 8),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Estão vivendo algum conflito com relação à guarda dos filhos, visitas ou pagamento de pensão pelo agressor?',
      options: [
        RiskOption(title: 'Sim', threat: 6, vulnerability: 6),
        RiskOption(title: 'Não', exclusive: true),
        RiskOption(title: 'Não sei', vulnerability: 2),
      ],
    ),
    RiskQuestion(
      title: 'Seu(s) filho(s) já presenciaram ato(s) de violência do(a) agressor(a) contra você?',
      options: [
        RiskOption(title: 'Sim', threat: 6, vulnerability: 10),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Você sofreu algum tipo de violência durante a gravidez ou nos três meses posteriores ao parto?',
      options: [
        RiskOption(title: 'Sim', threat: 12, vulnerability: 10),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Você está grávida ou teve bebê nos últimos 18 meses?',
      options: [
        RiskOption(title: 'Sim', vulnerability: 10),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Se você está em um novo relacionamento, as ameaças ou as agressões físicas aumentaram em razão disso?',
      options: [
        RiskOption(title: 'Sim', threat: 14),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Você possui alguma deficiência ou doença degenerativa que acarretam condição limitante ou de vulnerabilidade física ou mental?',
      options: [
        RiskOption(title: 'Sim', vulnerability: 12),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Com qual cor/raça você se identifica?',
      options: [
        RiskOption(title: 'Amarela', vulnerability: 1),
        RiskOption(title: 'Branca'),
        RiskOption(title: 'Cigana', vulnerability: 3),
        RiskOption(title: 'Indígena', vulnerability: 4),
        RiskOption(title: 'Judaica', vulnerability: 2),
        RiskOption(title: 'Parda', vulnerability: 2),
        RiskOption(title: 'Preta', vulnerability: 3),
        RiskOption(title: 'Quilombola', vulnerability: 4),
      ],
    ),
    RiskQuestion(
      title: 'Você considera que mora em bairro, comunidade, área rural ou local de risco de violência?',
      options: [
        RiskOption(title: 'Sim', vulnerability: 8),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
    RiskQuestion(
      title: 'Qual sua situação de moradia?',
      options: [
        RiskOption(title: 'Alugada', vulnerability: 4),
        RiskOption(title: 'Cedida ou de favor', vulnerability: 8),
        RiskOption(title: 'Própria'),
      ],
    ),
    RiskQuestion(
      title: 'Você se considera dependente financeiramente do(a) agressor(a)?',
      options: [
        RiskOption(title: 'Sim', vulnerability: 10),
        RiskOption(title: 'Não', exclusive: true),
      ],
    ),
  ];

  int get totalPages => (questions.length / 5).ceil();

  bool get isLastPage => currentPage == totalPages - 1;

  List<RiskQuestion> get visibleQuestions {
    final start = currentPage * 5;
    final end = (start + 5) > questions.length ? questions.length : start + 5;
    return questions.sublist(start, end);
  }

  bool get canGoNext {
    final start = currentPage * 5;
    final end = (start + 5) > questions.length ? questions.length : start + 5;

    for (int i = start; i < end; i++) {
      if (!selectedAnswers.containsKey(i) || selectedAnswers[i]!.isEmpty) {
        return false;
      }
    }

    return true;
  }

  double get threatPercent {
    double score = 0;
    double max = 0;

    for (int i = 0; i < questions.length; i++) {
      max += questions[i].options.fold<double>(
        0,
        (value, option) => option.threat > value ? option.threat : value,
      );

      final selected = selectedAnswers[i] ?? {};
      for (final optionIndex in selected) {
        score += questions[i].options[optionIndex].threat;
      }
    }

    if (max == 0) return 0;
    return (score / max * 100).clamp(0, 100);
  }

  double get vulnerabilityPercent {
    double score = 0;
    double max = 0;

    for (int i = 0; i < questions.length; i++) {
      max += questions[i].options.fold<double>(
        0,
        (value, option) =>
            option.vulnerability > value ? option.vulnerability : value,
      );

      final selected = selectedAnswers[i] ?? {};
      for (final optionIndex in selected) {
        score += questions[i].options[optionIndex].vulnerability;
      }
    }

    if (max == 0) return 0;
    return (score / max * 100).clamp(0, 100);
  }

  double get riskPercent {
    return ((threatPercent * 0.6) + (vulnerabilityPercent * 0.4))
        .clamp(0, 100);
  }

  String get classification {
    final risk = riskPercent;

    if (risk < 20) return 'Muito Baixo';
    if (risk < 40) return 'Baixo';
    if (risk < 60) return 'Moderado';
    if (risk < 80) return 'Alto';
    return 'Extremo';
  }

  void toggleAnswer(int globalQuestionIndex, int optionIndex) {
    final question = questions[globalQuestionIndex];
    final option = question.options[optionIndex];
    final current = Set<int>.from(selectedAnswers[globalQuestionIndex] ?? {});

    setState(() {
      if (!question.multiple) {
        selectedAnswers[globalQuestionIndex] = {optionIndex};
        return;
      }

      if (option.exclusive) {
        selectedAnswers[globalQuestionIndex] = {optionIndex};
        return;
      }

      final exclusiveIndex =
          question.options.indexWhere((item) => item.exclusive);

      if (exclusiveIndex != -1) {
        current.remove(exclusiveIndex);
      }

      if (current.contains(optionIndex)) {
        current.remove(optionIndex);
      } else {
        current.add(optionIndex);
      }

      selectedAnswers[globalQuestionIndex] = current;
    });
  }

  void nextPage() {
    if (!canGoNext) return;

    if (isLastPage) {
      final answered = <Map<String, dynamic>>[];

      for (int i = 0; i < questions.length; i++) {
        final selected = selectedAnswers[i] ?? {};
        answered.add({
          'question': questions[i].title,
          'answers': selected
              .map((index) => questions[i].options[index].title)
              .toList(),
        });
      }

      final resultArguments = {
        'threat': threatPercent,
        'vulnerability': vulnerabilityPercent,
        'risk': riskPercent,
        'classification': classification,
        'answers': answered,
        'identified': false,
        'userData': null,
      };

      _showIdentificationDialog(resultArguments);
      return;
    }

    setState(() {
      currentPage++;
    });
  }

  void previousPage() {
    if (currentPage == 0) return;

    setState(() {
      currentPage--;
    });
  }

  void toggleContrast() {
    setState(() {
      highContrast = !highContrast;
    });
  }

  void _quickExit() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Saída rápida'),
          content: const Text(
            'Deseja sair imediatamente da avaliação?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.loginPage,
                  (route) => false,
                );
              },
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  void _showIdentificationDialog(Map<String, dynamic> resultArguments) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          decoration: BoxDecoration(
            color: highContrast ? Colors.black : lavenderBackground,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: highContrast ? Colors.white : lavenderBorder,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                Icons.lock_outline_rounded,
                color: highContrast ? Colors.white : lavenderMain,
                size: 42,
              ),
              const SizedBox(height: 14),
              Text(
                'Você deseja se identificar?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryText,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Você pode continuar de forma anônima ou informar seus dados para que apareçam no relatório final.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      AppRoutes.resultPage,
                      arguments: resultArguments,
                    );
                  },
                  icon: const Icon(Icons.visibility_off_rounded),
                  label: const Text('Continuar anônima'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _showUserDataDialog(resultArguments);
                  },
                  icon: const Icon(Icons.person_outline_rounded),
                  label: const Text('Quero me identificar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        highContrast ? Colors.white : lavenderMain,
                    side: BorderSide(
                      color: highContrast ? Colors.white : lavenderMain,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUserDataDialog(Map<String, dynamic> resultArguments) {
    final nameController = TextEditingController();
    final documentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            decoration: BoxDecoration(
              color: highContrast ? Colors.black : lavenderBackground,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dados para identificação',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Essas informações serão exibidas apenas no relatório gerado neste protótipo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryText,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: nameController,
                  style: TextStyle(color: primaryText),
                  decoration: InputDecoration(
                    labelText: 'Nome completo',
                    filled: true,
                    fillColor: highContrast ? Colors.black : Colors.white,
                    labelStyle: TextStyle(color: secondaryText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: documentController,
                  style: TextStyle(color: primaryText),
                  decoration: InputDecoration(
                    labelText: 'CPF ou documento',
                    filled: true,
                    fillColor: highContrast ? Colors.black : Colors.white,
                    labelStyle: TextStyle(color: secondaryText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final updatedArguments = {
                        ...resultArguments,
                        'identified': true,
                        'userData': {
                          'name': nameController.text.trim().isEmpty
                              ? 'Não informado'
                              : nameController.text.trim(),
                          'document': documentController.text.trim().isEmpty
                              ? 'Não informado'
                              : documentController.text.trim(),
                        },
                      };

                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.resultPage,
                        arguments: updatedArguments,
                      );
                    },
                    icon: const Icon(Icons.description_rounded),
                    label: const Text('Gerar relatório identificado'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      AppRoutes.resultPage,
                      arguments: resultArguments,
                    );
                  },
                  child: const Text('Continuar sem identificação'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final start = currentPage * 5;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Avaliação de Risco'),
        backgroundColor: highContrast ? Colors.black : lavenderDark,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Alto contraste',
            icon: Icon(
              highContrast ? Icons.contrast : Icons.contrast_outlined,
            ),
            onPressed: toggleContrast,
          ),
          IconButton(
            tooltip: 'Saída rápida',
            icon: const Icon(Icons.logout_rounded),
            onPressed: _quickExit,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: visibleQuestions.length,
              itemBuilder: (context, index) {
                final globalIndex = start + index;
                return _buildQuestionCard(globalIndex, questions[globalIndex]);
              },
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final progress = (currentPage + 1) / totalPages;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: highContrast
            ? null
            : const LinearGradient(
                colors: [lavenderDark, lavenderMain],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        color: highContrast ? Colors.black : null,
        border: Border.all(
          color: highContrast ? Colors.white : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Formulário Nacional de Avaliação de Riscos',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Violência Doméstica e Familiar Contra a Mulher',
            style: TextStyle(
              color: Colors.white,
              height: 1.3,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: highContrast
                  ? Border.all(color: Colors.white)
                  : null,
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Suas respostas são confidenciais. Você poderá gerar o relatório de forma anônima.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Etapa ${currentPage + 1} de $totalPages',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(int globalIndex, RiskQuestion question) {
    final selected = selectedAnswers[globalIndex] ?? {};

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBackground,
        border: Border(
          left: BorderSide(
            color: highContrast ? Colors.white : lavenderMain,
            width: 5,
          ),
          top: BorderSide(color: borderColor),
          right: BorderSide(color: borderColor),
          bottom: BorderSide(color: borderColor),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: highContrast ? Colors.white : lavenderLight,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Pergunta ${globalIndex + 1} de ${questions.length}',
              style: TextStyle(
                color: highContrast ? Colors.black : lavenderDark,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            '${globalIndex + 1}. ${question.title}',
            style: TextStyle(
              color: primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          ...List.generate(question.options.length, (optionIndex) {
            final option = question.options[optionIndex];
            final isSelected = selected.contains(optionIndex);

            return InkWell(
              onTap: () => toggleAnswer(globalIndex, optionIndex),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      question.multiple
                          ? isSelected
                              ? Icons.check_box_rounded
                              : Icons.check_box_outline_blank_rounded
                          : isSelected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                      color: highContrast
                          ? Colors.white
                          : isSelected
                              ? lavenderMain
                              : const Color(0xFFCBD0D6),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        option.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: primaryText,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      color: pageBackground,
      child: Row(
        children: [
          if (currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: previousPage,
                style: OutlinedButton.styleFrom(
                  foregroundColor: highContrast ? Colors.white : lavenderDark,
                  side: BorderSide(
                    color: highContrast ? Colors.white : lavenderMain,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: const Text('← Voltar'),
              ),
            ),
          if (currentPage > 0) const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: canGoNext ? nextPage : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: highContrast ? Colors.white : lavenderMain,
                foregroundColor: highContrast ? Colors.black : Colors.white,
                disabledBackgroundColor:
                    highContrast ? Colors.grey : lavenderBorder,
                disabledForegroundColor:
                    highContrast ? Colors.black : textMuted,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(isLastPage ? 'Gerar relatório' : 'Próximo →'),
            ),
          ),
        ],
      ),
    );
  }
}
