/*
Nome: Answer
Descrição: clsse responsavel pelo parsing de uma pergunta vinda do backend
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'answer.dart';

class Question {
  final String title;
  final List<Answer> answers;

  Answer? selectedAnswer;

  Question({
    required this.title,
    required this.answers,
    this.selectedAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'] as String,
      answers: (json['answers'] as List)
          .map((item) => Answer.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'answers': answers.map((e) => e.toJson()).toList(),
    };
  }
}