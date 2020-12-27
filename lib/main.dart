import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/scoreKeeper.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('QuizApp'),
          backgroundColor: Colors.lightBlue,
        ),
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final ScoreKeeper scoreKeep = ScoreKeeper();
  List<Widget> scoreKeeper = [];
  int questionNumber = 0;
  int correctAnswerCounter = 0;
  List<Question> questionBank = [
    Question('You can use Kotlin to build multi platform apps', true),
    Question('Android-KTX library helps to write concise code', true),
    Question('You need to add ; at the end od each statement in Kotlin', false),
    Question(
        'Kotlin supports default values for arguments and properties', true)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[questionNumber].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    //The user picked true.
                    bool correctAnswer = questionBank[questionNumber].answer;
                    if (correctAnswer == true) {
                      print('right');
                      scoreKeeper.add(scoreKeep.getMeAnswerWidget(true));
                      correctAnswerCounter++;
                    } else {
                      scoreKeeper.add(scoreKeep.getMeAnswerWidget(false));
                      print('wrong');
                    }
                    setState(() {
                      if (((questionBank.length - 1) - questionNumber) == 0) {
                        //questionNumber = 0;
                        // finish the quiz and kill the app
                        _showMyDialog();
                      } else {
                        questionNumber++;
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: FlatButton(
                    color: Colors.red,
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      //The user picked false.
                      bool correctAnswer = questionBank[questionNumber].answer;
                      if (correctAnswer == false) {
                        print('right');
                        scoreKeeper.add(scoreKeep.getMeAnswerWidget(true));
                        correctAnswerCounter++;
                      } else {
                        print('wrong');
                        scoreKeeper.add(scoreKeep.getMeAnswerWidget(false));
                      }
                      setState(() {
                        if (((questionBank.length - 1) - questionNumber) == 0) {
                          //questionNumber = 0;
                          _showMyDialog();
                        } else {
                          questionNumber++;
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)))),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: scoreKeeper),
        )
        //TODO: Add a Row here as your score keeper
      ],
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Quiz Result',style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You score $correctAnswerCounter out of ${questionBank.length}',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
