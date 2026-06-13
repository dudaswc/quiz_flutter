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
  final ValueChanged<Answer>? onChanged;

  const QuestionWidget({
    super.key,
    required this.question,
    this.onChanged,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Answer? _selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionTitle(),
        const SizedBox(height: 16),
        _buildAnswersList(),
      ],
    );
  }

  void _selectAnswer(Answer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
    widget.onChanged?.call(answer);
  }

  Widget _buildQuestionTitle() {
    return Text(
      widget.question.title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
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
    return RadioListTile<Answer>(
      title: Text(answer.title),
      value: answer,
      groupValue: _selectedAnswer,
      onChanged: (value) {
        if (value != null) {
          _selectAnswer(value);
        }
      },
    );
  }
}