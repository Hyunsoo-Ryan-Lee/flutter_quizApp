import 'package:flutter/material.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_quiz.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quiz> quizs = [
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0
    }),
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0
    }),
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0
    }),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('My Quiz App'),
              leading: Container(),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/moon.png',
                    width: width * 0.8,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildStep(width, "가즈아!!!"),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuizScreen(quizs: quizs)));
                      },
                      child: Text(
                        '문제풀이 ㄱㄱ',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          width * 0.05, width * 0.025, width * 0.05, width * 0.025),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(padding: EdgeInsets.only(right: width * 0.025)),
          Text(title)
        ],
      ),
    );
  }
}
