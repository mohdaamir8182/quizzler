import 'package:flutter/material.dart';
import 'package:quizzler/question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


void main() => runApp(MyApp());
QuestionBank questionBank = QuestionBank();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Quizzler(),
    );
  }
}

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {

  List<Icon> scoreKeeper = [];
  int questionNumber = 0;
  int result = 0;

  void onClickEvent(bool userAnswer){
    bool correctAnswer = questionBank.getAnswer();
    setState(() {
      if(questionBank.isFinished() == true){
        print("Finished");

        Alert(
            context: context,
            title: "Quizzler Finished",
            desc: "You 've got $result out of 12")
            .show();

        questionBank.resetQuestionBank();
        scoreKeeper = [];
        result = 0;
      }
      else{
        if(userAnswer == correctAnswer){
          scoreKeeper.add(Icon(Icons.check , color: Colors.green,));
          result++;
        }
        else{
          scoreKeeper.add(Icon(Icons.close , color: Colors.red,));
        }
        questionBank.increaseQuestionNumber();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Quizzler"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8.0),
                child: Center(
                  child: Text(questionBank.getNextQuestion(),
                  style: TextStyle(color: Colors.white70,fontSize: 24),),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8.0),
                child: FlatButton(
                  color: Colors.green,
                  onPressed: (){
                    onClickEvent(true);
                    },
                  child: Text("True"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0 , vertical: 8.0),
                child: FlatButton(
                  color: Colors.red,
                  onPressed: (){
                    onClickEvent(false);
                  },
                  child: Text("False"),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: scoreKeeper,
              ),
            )
          ],
        ),
      ),
    );
  }
}
