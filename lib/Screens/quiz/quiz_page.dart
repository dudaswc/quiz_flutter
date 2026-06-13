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

  // =========================
  // FIRST PAGE
  // =========================
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

  // =========================
  // SCROLL
  // =========================
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_isLoadingNextPage) return;

    final position = _scrollController.position;

    const threshold = 250.0;

    if (position.pixels >= position.maxScrollExtent - threshold) {
      _loadNextPage();
    }
  }

  // =========================
  // NEXT PAGE
  // =========================
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

  // =========================
  // SCORE UPDATE
  // =========================
  void _addScore(int score) {
    setState(() {
      _totalScore += score;
    });
  }

  // =========================
  // NAV RESULT
  // =========================
  void _onShowResult() {
    Navigator.pushNamed(
      context,
      AppRoutes.resultPage,
      arguments: _totalScore,
    );
  }

  // =========================
  // BUILD
  // =========================
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isLastPage = _currentPage == _lastPage;

    final baseCount = _questions.length;
    final showLoadingCell = _isLoadingNextPage;
    final showResultButton = isLastPage;

    final totalItems = baseCount +
        (showLoadingCell ? 1 : 0) +
        (showResultButton ? 1 : 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Page $_currentPage / $_lastPage'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: totalItems,
        itemBuilder: (context, index) {
          // LOADING CELL
          if (showLoadingCell && index == baseCount) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          // RESULT BUTTON
          final resultIndex = baseCount + (showLoadingCell ? 1 : 0);

          if (showResultButton && index == resultIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: ElevatedButton(
                  onPressed: _onShowResult,
                  child: const Text('Resultado'),
                ),
              ),
            );
          }

          // QUESTION
          final question = _questions[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: QuestionWidget(
              question: question,
              onChanged: (answer) {
                _addScore(answer.score);
              },
            ),
          );
        },
      ),
    );
  }
}