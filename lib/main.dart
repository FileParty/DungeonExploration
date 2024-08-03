import 'package:flutter/material.dart';
import 'package:gemini_survival/src/common/config.dart';
import 'package:gemini_survival/src/common/loading.dart';
import 'package:gemini_survival/src/game/wait-area/home.dart';
import 'package:gemini_survival/src/provider/provider.dart';
import 'package:gemini_survival/src/view/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const CardGameApp(),
    ),
  );
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
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: gameWidth,
                  height: gameHeight,
                  child: Consumer<AppState>(
                    builder: (context, appState, child) {
                      switch (appState.playState) {
                        case PlayState.loading:
                          return const LoadingScreen();
                        case PlayState.playing:
                          return const GameHome();
                        case PlayState.gameOver:
                        case PlayState.mainMenu:
                          return const HomeScreen();
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
