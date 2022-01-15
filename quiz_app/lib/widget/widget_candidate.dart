// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CandWidget extends StatefulWidget {
  VoidCallback tap;
  String text;
  int index;
  double width;
  bool answerState;

  CandWidget(
      {required this.tap,
      required this.text,
      required this.index,
      required this.answerState,
      required this.width});

  @override
  _CandWidgetState createState() => _CandWidgetState();
}

class _CandWidgetState extends State<CandWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.width * 0.7,
        height: widget.width * 0.1,
        padding: const EdgeInsets.all(8.0),
        // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        color: widget.answerState ? Colors.deepPurple : Colors.grey,
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.width * 0.035,
              color: widget.answerState ? Colors.white : Colors.black),
        ),
      ),
      onTap: () {
        setState(() {
          widget.tap();
          widget.answerState = !widget.answerState;
        });
        print(widget.text);
      },
    );
  }
}
