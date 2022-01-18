import 'package:flutter/material.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_home.dart';

class ResultScreen extends StatelessWidget {
  List<int> answers;
  List<Quiz> quizs;

  ResultScreen({required this.answers, required this.quizs});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    int score = 0;

    for (int i = 0; i < quizs.length; i++) {
      if (quizs[i].answer == answers[i]) {
        score += 1;
      }
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('퀴즈앱'),
          backgroundColor: Colors.deepPurple,
          leading: Container(),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.deepPurple),
            width: width * 0.85,
            height: height * 0.5,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: width * 0.05)),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.white),
                  width: width * 0.73,
                  height: height * 0.25,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, width * 0.05, 0, width * 0.012),
                        child: Text(
                          '수고하셨습니다!',
                          style: TextStyle(
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '당신의 점수는',
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      Text(
                        score.toString() + '/' + quizs.length.toString(),
                        style: TextStyle(
                            fontSize: width * 0.21,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Padding(padding: EdgeInsets.all(width * 0.012))
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.only(bottom: width * 0.05),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    },
                    child: Text(
                      '홈으로 돌아가기',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      // side: BorderSide(width: 2.0, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
