import 'package:flutter/material.dart';
import 'balloon_game_screen.dart';

class BalloonGame extends StatelessWidget {
  const BalloonGame({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BalloonGameScreen(),
    );
  }
}
