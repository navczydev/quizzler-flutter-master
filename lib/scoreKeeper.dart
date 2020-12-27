import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreKeeper {
  Widget getMeAnswerWidget(bool answer) {
    if (answer) {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.close,
        color: Colors.red,
      );
    }
  }
}
