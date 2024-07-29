import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CardGameApp());
}

class CardGameApp extends StatelessWidget {
  const CardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Survival',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

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
          appBar: AppBar(
            title: const Text(
              '제미나이 서바이벌',
              style: TextStyle(
                color: Colors.white, // 텍스트 색상 흰색
                fontWeight: FontWeight.bold, // 텍스트 굵게
                fontSize: 24, // 텍스트 크기
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5), // 그림자 위치
                    blurRadius: 3.0, // 그림자 흐림 정도
                    color: Colors.black, // 그림자 색상 검정
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent, // AppBar의 배경을 투명하게 설정
          ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GameScreen()),
                      );
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
                      SystemNavigator.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 버튼 배경색 검은색
                      foregroundColor: Colors.white, // 텍스트 색상 하얀색
                      padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 26), // 버튼 크기 조정
                    ),
                    child: const Text('게임 종료'),
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

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Screen'),
      ),
      body: const Center(
        child: Text('Game Area'),
      ),
    );
  }
}