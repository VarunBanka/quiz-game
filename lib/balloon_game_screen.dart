import 'dart:async';
import 'package:flutter/material.dart';

class BalloonGameScreen extends StatefulWidget {
  @override
  _BalloonGameScreenState createState() => _BalloonGameScreenState();
}

class _BalloonGameScreenState extends State<BalloonGameScreen> {
  itsNerd() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const Text("Made by Varun Banka & Sovodip"),
    ); // never ever f with this func
  }

  levelTwo() {
    setState(
      () {
        question = "question 2";
        level = "Level: 2";
      },
    );
    restartGame();
  }

  showQuestions() {
    return Center(
      child: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                question,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gameWon = true;
                    });
                    Navigator.pop(
                        context); //  not here so that we can move to next question
                  },
                  child: Text(question)),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gameWon = false;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Option 1")),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gameWon = false;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Option 1")),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gameWon = false;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Option 1")),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // some shit variables
  double balloonPositionX = 0.5; // Initial horizontal position of the balloon
  double balloonPositionY = 1.0; // Initial vertical position of the balloon
  List<double> blockPositions = [
    0.1,
    0.9,
    0.3,
    0.7
  ]; // Positions of Blocks A, B, C, and D
  int currentBlockIndex = 0; // Index of the current block
  bool gameStarted = false;
  bool gameResultShown = false;
  bool gameWon = false;
  String question = "question 1 of lvl 1"; // q1 of l1
  String option1 = "option1";
  String option2 = "option1";
  String option3 = "option1";
  String option4 = "option1";
  String level = "Level: 1";

  @override
  void initState() {
    super.initState();
  } // dont mess with this func, cause idk why it is even alive xd, jk...

  void startGame() {
    setState(() {
      balloonPositionX = 0.5; // Reset horizontal position of the balloon
      balloonPositionY = 1.0; // Reset vertical position of the balloon
      gameStarted = true;
      gameResultShown = false;
      gameWon = false;
    });

    Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (balloonPositionY <= 0) {
        // Balloon reached the top
        timer.cancel();
        if (balloonPositionX >= blockPositions[currentBlockIndex] - 0.05 &&
            balloonPositionX <= blockPositions[currentBlockIndex] + 0.05) {
          // Balloon hit the current block
          setState(
            () {
              gameWon = true;
              showModalBottomSheet(
                context: context,
                builder: (ctx) => showQuestions(),
              );
            },
          );
        } else {
          // Balloon missed the current block
          setState(() {
            gameWon = false;
          });
        }
        setState(() {
          gameResultShown = true;
        });

        // Move to the next block
        currentBlockIndex++;
        if (currentBlockIndex >= blockPositions.length) {
          currentBlockIndex = 0;
        }
      } else {
        setState(() {
          balloonPositionY -= 0.005; // Move the balloon upwards
        });
      }
    });
  }

  void moveBalloonRight() {
    if (balloonPositionX < 1) {
      setState(() {
        balloonPositionX += 0.05; // Move the balloon to the right
      });
    }
  }

  void moveBalloonLeft() {
    if (balloonPositionX > 0) {
      setState(() {
        balloonPositionX -= 0.05; // Move the balloon to the left
      });
    }
  }

  void restartGame() {
    setState(() {
      balloonPositionX = 0.5; // Reset balloon position
      currentBlockIndex = 0; // Reset the current block index
      gameStarted = false;
      gameResultShown = false;
      gameWon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balloon Game'),
        actions: [
          IconButton(
            onPressed: itsNerd,
            icon: const Icon(Icons.info_outline_rounded),
          ),
          Text(
            level,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/1.jpg'),
                fit: BoxFit.cover,
              )),
              width: double.infinity,
              height: 400,
              child: Stack(
                children: [
                  Positioned(
                    top: balloonPositionY * 400,
                    left: MediaQuery.of(context).size.width * balloonPositionX -
                        25,
                    child: GestureDetector(
                      onTap: () {
                        if (!gameStarted) {
                          startGame();
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  // Render all four blocks at fixed positions

                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.1,
                    child: Column(
                      children: [
                        Container(
                          width: 10,
                          height: 100,
                          color: Colors.blue,
                        ),
                        Text('Block A'),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      children: [
                        Container(
                          width: 10,
                          height: 100,
                          color: Colors.orange,
                        ),
                        Text('Block C'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (gameResultShown)
              Text(
                gameWon ? 'You Win!' : 'You Lose!',
                style: TextStyle(fontSize: 20),
              ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!gameStarted) {
                      startGame();
                    }
                  },
                  child: Text('Start'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: moveBalloonLeft,
                  child: Text('Left'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: moveBalloonRight,
                  child: Text('Right'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (gameStarted && gameResultShown && gameWon == true)
              ElevatedButton(
                onPressed: levelTwo,
                child: const Text("Next level"),
              ),
            if (gameStarted && gameResultShown && gameWon == false)
              ElevatedButton(
                onPressed: restartGame,
                child: Text('Restart'),
              ),
          ],
        ),
      ),
    );
  }
}
