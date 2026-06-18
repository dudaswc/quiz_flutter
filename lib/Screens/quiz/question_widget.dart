/*
Nome: QuestionWidget
Descrição: classe responsavel por modelar um widget para aprsentar uma questão com pergunta e respostas
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'package:flutter/material.dart';

import '../../Models/answer.dart';
import '../../Models/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;

  // Em vez de sempre somar a nova resposta, enviamos a diferença:
  // nova pontuação - pontuação anterior.
  final ValueChanged<int>? onScoreDelta;

  const QuestionWidget({
    super.key,
    required this.question,
    this.onScoreDelta,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Answer? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _selectedAnswer = widget.question.selectedAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFEADDEA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionBadge(),
          const SizedBox(height: 12),
          _buildQuestionTitle(),
          const SizedBox(height: 16),
          _buildAnswersList(),
        ],
      ),
    );
  }

  Widget _buildQuestionBadge() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBF2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.favorite_rounded,
            size: 20,
            color: Color(0xFFD81B60),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Avaliação de risco',
            style: TextStyle(
              color: Color(0xFF7B2D8B),
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionTitle() {
    return Text(
      widget.question.title,
      style: const TextStyle(
        fontSize: 19,
        height: 1.25,
        color: Color(0xFF2D1235),
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildAnswersList() {
    return Column(
      children: widget.question.answers
          .map((answer) => _buildAnswerItem(answer))
          .toList(),
    );
  }

  Widget _buildAnswerItem(Answer answer) {
    final bool isSelected = _selectedAnswer == answer;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _selectAnswer(answer),
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFFEBF2)
                : const Color(0xFFFFFBFF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFD81B60)
                  : const Color(0xFFE8DDEB),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: isSelected
                    ? const Color(0xFFD81B60)
                    : const Color(0xFF9C8AA2),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  answer.title,
                  style: const TextStyle(
                    fontSize: 15.5,
                    height: 1.3,
                    color: Color(0xFF2D1235),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAnswer(Answer answer) {
    final int previousScore = _selectedAnswer?.score ?? 0;
    final int newScore = answer.score;
    final int delta = newScore - previousScore;

    setState(() {
      _selectedAnswer = answer;
      widget.question.selectedAnswer = answer;
    });

    widget.onScoreDelta?.call(delta);
  }
}
