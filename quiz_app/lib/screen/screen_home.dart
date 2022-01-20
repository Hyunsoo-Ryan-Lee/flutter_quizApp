import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/api_adapter.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_quiz.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Quiz> quizs = [];

  // List<Quiz> quizs = [
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  // ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            // key: _scaffoldKey,
            appBar: AppBar(
              title: Text('My Quiz App'),
              leading: Container(), // 뒤로가기가 사라지는 효과!
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
                    height: size.height * 0.03,
                  ),
                  _buildStep(width, "필름카메라에 관한 간단한 퀴즈입니다."),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        _fetchQuiz().whenComplete(() {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuizScreen(quizs: quizs)));
                        });
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(padding: EdgeInsets.only(right: width * 0.025)),
          Text(
            title,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _fetchQuiz() async {
    final response = await http.get(
        Uri.parse('https://b076-112-154-191-206.ngrok.io/quiz/4/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      setState(() {
        quizs = parseQuiz(utf8.decode(response.bodyBytes));
      });
    } else {
      throw Exception('failed');
    }
  }
}
