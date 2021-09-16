import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String phrase;
    if (resultScore < 10) {
      phrase = "You are innocent";
    } else if (resultScore < 16) {
      phrase = "You are not bad";
    } else {
      phrase = "You are baad";
    }
    return phrase;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetHandler,
            child: Text('Restart quiz!'),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
