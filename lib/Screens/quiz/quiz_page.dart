/*
Nome: QuizPage
Descrição: classe responsavel por modelar um widget para aprsentar na tela com diversas questões
Autor: Silvano Malfatti
Data: 13/06/2026
 */


import 'package:flutter/material.dart';

import '../../Models/question.dart';
import '../../common/app_routes.dart';
import 'question_widget.dart';
import 'quiz_server.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizServer _server = QuizServer();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = true;
  bool _isLoadingNextPage = false;

  int _currentPage = 1;
  int _lastPage = 1;

  int _totalScore = 0;

  final List<Question> _questions = [];

  @override
  void initState() {
    super.initState();

    _loadFirstPage();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadFirstPage() async {
    final result = await _server.fetchQuestions(1);

    if (!mounted) return;

    setState(() {
      _currentPage = result.page;
      _lastPage = result.lastPage;

      _questions
        ..clear()
        ..addAll(result.questions);

      _isLoading = false;
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_isLoadingNextPage) return;

    final position = _scrollController.position;
    const threshold = 250.0;

    if (position.pixels >= position.maxScrollExtent - threshold) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingNextPage) return;
    if (_currentPage >= _lastPage) return;

    setState(() {
      _isLoadingNextPage = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final result = await _server.fetchQuestions(nextPage);

      if (!mounted) return;

      setState(() {
        _currentPage = result.page;
        _lastPage = result.lastPage;
        _questions.addAll(result.questions);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingNextPage = false;
        });
      }
    }
  }

  void _updateScore(int delta) {
    setState(() {
      _totalScore += delta;
    });
  }

  void _onShowResult() {
    Navigator.pushNamed(
      context,
      AppRoutes.resultPage,
      arguments: _totalScore,
    );
  }

  int get _answeredQuestions {
    return _questions.where((question) => question.selectedAnswer != null).length;
  }

  double get _progress {
    if (_questions.isEmpty) return 0;
    return _answeredQuestions / _questions.length;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFF7FB),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF7B2D8B),
          ),
        ),
      );
    }

    final bool isLastPage = _currentPage == _lastPage;

    final int baseCount = _questions.length;
    final bool showLoadingCell = _isLoadingNextPage;
    final bool showResultButton = isLastPage;

    final int totalItems = baseCount +
        (showLoadingCell ? 1 : 0) +
        (showResultButton ? 1 : 0);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FB),
      appBar: AppBar(
        title: const Text('Avaliação de Risco'),
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: totalItems,
              itemBuilder: (context, index) {
                if (showLoadingCell && index == baseCount) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF7B2D8B),
                      ),
                    ),
                  );
                }

                final int resultIndex = baseCount + (showLoadingCell ? 1 : 0);

                if (showResultButton && index == resultIndex) {
                  return _buildResultButton();
                }

                final question = _questions[index];

                return QuestionWidget(
                  question: question,
                  onScoreDelta: _updateScore,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7B2D8B),
            Color(0xFFD81B60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD81B60).withOpacity(0.20),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sua segurança importa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Responda com calma para receber uma orientação inicial sobre o nível de risco.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_answeredQuestions de ${_questions.length} perguntas respondidas',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultButton() {
    final bool canShowResult = _answeredQuestions == _questions.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          if (!canShowResult)
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Responda todas as perguntas para visualizar o resultado.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B5A70),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: canShowResult ? _onShowResult : null,
              icon: const Icon(Icons.insights_rounded),
              label: const Text('Ver resultado'),
            ),
          ),
        ],
      ),
    );
  }
}
