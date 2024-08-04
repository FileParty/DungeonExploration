import 'package:gemini_survival/src/dto/character/action/action.dart';
import 'package:gemini_survival/src/dto/character/character.dart';
import 'package:gemini_survival/src/dto/common/map_type.dart';

class PlayerUnit extends Character {

  int rank = 1; // 유닛 랭크
  WorldViewType worldViewType;
  List<PlayerAction> actions = [];

  PlayerUnit({
    required super.name,
    required super.description,
    required super.maxHp,
    required super.maxMentality,
    required super.maxStrength,
    required super.maxAgility,
    required super.maxArmor,
    required super.armorType,
    required this.rank,
    required this.worldViewType,
    required this.actions,
  });
}