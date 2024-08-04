import 'package:flutter/material.dart';
import 'package:gemini_survival/src/dto/character/action/action.dart';
import 'package:gemini_survival/src/dto/character/unit.dart';
import 'package:gemini_survival/src/dto/common/character_type.dart';
import 'package:gemini_survival/src/dto/common/map_type.dart';
import 'package:gemini_survival/src/dto/map.dart';

enum PlayState { loading, playing, gameOver, mainMenu }
enum GameState { explore, battle, shop, units, home, exit }

class AppState extends ChangeNotifier {

  PlayState _playState = PlayState.mainMenu;
  GameState _gameState = GameState.home;
  List<MapObject> _maps = [];
  List<PlayerUnit> _units = [
    PlayerUnit(
      name: '테스트',
      description: '테스트용',
      maxHp: 1000,
      maxMentality: 100,
      maxStrength: 10,
      maxAgility: 10,
      maxArmor: 10,
      armorType: ArmorType.medium, 
      rank: 10,
      worldViewType: WorldViewType.common,
      actions: [
        PlayerAction(
          name: '공격',
          description: '더미 액션',
          worldViewType: WorldViewType.common,
          cost: 0,
          cooldown: 0,
          waitTime: 0,
          actionList: [
            ActionTypeDeamge(
              deamgeType: DeamgeType.heavy,
              value: 50,
              type: ActionType.damage,
            ),
          ],
        ),
        PlayerAction(
          name: '회복',
          description: '더미 액션2',
          worldViewType: WorldViewType.common,
          cost: 0,
          cooldown: 1,
          waitTime: 0,
          actionList: [
            ActionTypeHeal(
              value: 50, 
              type: ActionType.heal,
            )
          ],
        ),
      ]
    ),
  ];

  PlayState get playState => _playState;
  GameState get gameState => _gameState;
  List<MapObject> get maps => _maps;
  List<PlayerUnit> get units => _units;

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

  void setUnits(List<PlayerUnit> units) {
    _units = units;
    notifyListeners();
  }
}