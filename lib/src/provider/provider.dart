import 'package:flutter/material.dart';
import 'package:gemini_survival/src/dto/map.dart';

enum PlayState { loading, playing, gameOver, mainMenu }
enum GameState { explore, battle, shop, units, home, exit }

class AppState extends ChangeNotifier {

  PlayState _playState = PlayState.mainMenu;
  GameState _gameState = GameState.home;
  List<MapObject> _maps = [];

  PlayState get playState => _playState;
  GameState get gameState => _gameState;
  List<MapObject> get maps => _maps;

  void setPalyState(PlayState playState) {
    _playState = playState;
    notifyListeners();
  }

  void setGameState(GameState gameState) {
    _gameState = gameState;
    if( gameState == GameState.exit ) {
      setPalyState(PlayState.mainMenu);
    }
    notifyListeners();
  }

  void setMaps(List<MapObject> maps) {
    _maps = maps;
    notifyListeners();
  }
}