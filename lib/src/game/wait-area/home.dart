import 'package:flutter/material.dart';
import 'package:gemini_survival/api/gemini.dart';
import 'package:gemini_survival/src/common/bottom_btns.dart';
import 'package:gemini_survival/src/game/api/wait_area.dart';
import 'package:gemini_survival/src/game/wait-area/explore/index.dart';
import 'package:gemini_survival/src/provider/provider.dart';
import 'package:provider/provider.dart';

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  _GameHomeState createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  double _opacity = 1.0;
  bool _isTransitioning = false;
  GameState? _nextScreen;

  Future<void> _setScreen(GameState screen) async {
    setState(() {
      _opacity = 0.0;
      _isTransitioning = true;
    });

    await Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _nextScreen = screen;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return Stack(
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 500),
                onEnd: () {
                  if (_isTransitioning) {
                    setState(() {
                      _opacity = 1.0;
                      _isTransitioning = false;
                    });
                    if (_nextScreen != null) {
                      Provider.of<AppState>(context, listen: false).setGameState(_nextScreen!);
                      _nextScreen = null;
                    }
                  }
                },
                child: _isTransitioning
                    ? Container(color: Colors.black)
                    : _buildCurrentScreen(appState),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCurrentScreen(AppState appState) {
    switch (appState.gameState) {
      case GameState.explore:
        return const ExploreIndex();
      case GameState.shop:
        return const Center(child: Text('Shop Screen'));
      case GameState.units:
        return const Center(child: Text('Units Screen'));
      default:
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                '/menu/game_home.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigation(buttons: [
                ButtonInfo(
                  color: Colors.blue,
                  text: '탐험',
                  callBack: () => _setScreen(GameState.explore),
                ),
                ButtonInfo(
                  color: const Color.fromARGB(255, 231, 59, 159),
                  text: 'API 테스트',
                  callBack: () async {
                    final response = await GeminiAPI.callJsonList(exploreMapParam);
                    print(response);
                  },
                    // '상점',
                  //callBack: () => _setScreen(GameState.shop),
                ),
                ButtonInfo(
                  color: const Color.fromARGB(255, 44, 44, 44),
                  text: '유닛 관리',
                  callBack: () => _setScreen(GameState.units),
                ),
                ButtonInfo(
                  color: Colors.red,
                  text: '종료',
                  callBack: () => _setScreen(GameState.exit),
                ),
              ]),
            ),
          ],
        );
    }
  }
}