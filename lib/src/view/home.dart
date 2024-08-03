
import 'package:flutter/material.dart';
import 'package:gemini_survival/src/common/app_bar.dart';
import 'package:gemini_survival/src/provider/provider.dart';
import 'package:provider/provider.dart';

import 'info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지
        Positioned.fill(
          child: Image.asset(
            '/menu/main.png',
            fit: BoxFit.cover,
          ),
        ),
        // Scaffold 위젯
        Scaffold(
          backgroundColor: Colors.transparent, // Scaffold의 배경을 투명하게 설정
          appBar: buildCommonAppBar(),
          body: Align(
            alignment: const Alignment(0, 0.7), // y축 0.7 위치에 배치 (하단에서 20% 떨어진 곳)
            child: FractionallySizedBox(
              widthFactor: 0.8, // 화면 너비의 80%를 차지하도록 설정
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<AppState>(context, listen: false).setPalyState(PlayState.playing);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // 버튼 배경색 파란색
                      foregroundColor: Colors.white, // 텍스트 색상 하얀색
                      padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 26), // 버튼 크기 조정
                    ),
                    child: const Text('게임 시작'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GameInfoScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 버튼 배경색 검은색
                      foregroundColor: Colors.white, // 텍스트 색상 하얀색
                      padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 26), // 버튼 크기 조정
                    ),
                    child: const Text('게임 정보'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}