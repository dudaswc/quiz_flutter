/*
Nome: Answer
Descrição: clsse responsavel pelo parsing de uma resposta vinda do backend
Autor: Silvano Malfatti
Data: 13/06/2026
 */

class Answer {
  final String title;
  final int score;

  Answer({
    required this.title,
    required this.score,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      title: json['title'] ?? '',
      score: json['score'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'score': score,
    };
  }

  @override
  bool operator == (Object other) {
    return other is Answer &&
        other.title == title &&
        other.score == score;
  }

  @override
  int get hashCode => Object.hash(title, score);
}