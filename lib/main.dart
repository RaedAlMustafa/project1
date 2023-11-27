import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TapTheBallScreen(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}

class TapTheBallScreen extends StatefulWidget {
  @override
  _TapTheBallScreenState createState() => _TapTheBallScreenState();
}

class _TapTheBallScreenState extends State<TapTheBallScreen> {
  int score = 0;
  int timeLeft = 30; // in seconds
  late Timer timer;
  bool game = false;
  void startGameTimer() {
    game = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        endGame();
      }
    });
  }

  void endGame() {
    timer.cancel();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      game = false;
      score = 0;
      timeLeft = 30;
    });
    startGameTimer();
  }

  void onTap() {
    if (game) {
      setState(() {
        score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap The Ball Game'),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(onPressed: startGameTimer, child: Text("Start!")),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Time left: $timeLeft seconds',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'Tap!',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(onPressed: endGame, child: Text("Reset The Game"))
            ],
          ),
        ),
      ),
    );
  }
}
