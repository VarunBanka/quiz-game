import 'package:flutter/material.dart';
import 'balloon_game.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const BalloonGame(),
    ),
  );
}
