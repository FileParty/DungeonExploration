import 'package:flutter/material.dart';

class GameInfoScreen extends StatelessWidget {
  const GameInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게임 정보 '),
      ),
      body: const Center(
        child: Text('여기에 게임 정보를 표시합니다.'),
      ),
    );
  }
}