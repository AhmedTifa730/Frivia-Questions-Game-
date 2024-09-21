import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int maxQuestions = 10;
  final String difficultyA;
  List? questions;
  int currentQuestionCount = 0;
  int correctCount = 0;

  BuildContext context;
  HomePageProvider({required this.context , required this.difficultyA}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    getQuestions();
  }

  Future<void> getQuestions() async {
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulity': difficultyA,
      },
    );
    var data = jsonDecode(
      response.toString(),
    );
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![currentQuestionCount]["question"];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![currentQuestionCount]["correct_answer"] == answer;
    correctCount += isCorrect ? 1 : 0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    Navigator.pop(context);
    currentQuestionCount++;
    if (currentQuestionCount == maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End Game",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          content: Text("Score: $correctCount/$maxQuestions"),
        );
      },
    );
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
