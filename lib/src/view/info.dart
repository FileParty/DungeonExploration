import 'package:flutter/material.dart';
import 'package:gemini_survival/src/common/app_bar.dart';

class GameInfoScreen extends StatelessWidget {
  const GameInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Scaffold의 배경을 투명하게 설정
      appBar: buildCommonAppBar(),
      body: const Center(
        child: Text('여기에 게임 정보를 표시합니다.'),
      ),

    );
  }
}