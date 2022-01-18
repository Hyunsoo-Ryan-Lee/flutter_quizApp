import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_result.dart';
import 'package:quiz_app/widget/widget_candidate.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;
  QuizScreen({required this.quizs});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> _answer = [-1, -1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple)),
          width: width * 0.8,
          height: height * 0.5,
          child: Swiper(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            loop: false,
            itemCount: widget.quizs.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildQuizCard(widget.quizs[index], width, height);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.025, 0, width * 0.025),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                  fontSize: width * 0.06, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: width * 0.05, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Container()),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                  child: Text('나가기'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              OutlinedButton(
                child: _currentIndex == widget.quizs.length - 1
                    ? Text('결과보기')
                    : Text('다음문제'),
                onPressed: _answer[_currentIndex] == -1
                    ? null
                    : () {
                        if (_currentIndex == widget.quizs.length - 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                      answers: _answer, quizs: widget.quizs)));
                        } else {
                          _answerState = [false, false, false, false];
                          _currentIndex += 1;
                          _controller.next();
                        }
                      },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(CandWidget(
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answer[_currentIndex] = j + 1;
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
          text: quiz.candidates[i],
          index: i,
          answerState: _answerState[i],
          width: width));
      _children.add(Padding(padding: EdgeInsets.all(width * 0.025)));
    }
    return _children;
  }
}
