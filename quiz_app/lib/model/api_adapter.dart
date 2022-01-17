import 'dart:convert';
import 'model_quiz.dart';

List<Quiz> parseQuiz(String responsebody) {
  final parsed = json.decode(responsebody).cast<Map<String, dynamic>>();
  return parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
}
