

import 'package:gemini_survival/src/dto/character/action/action.dart';
import 'package:gemini_survival/src/dto/character/character.dart';

class Monster extends Character {

  List<MonsterAction> partten = []; // 몬스터 패턴 목록
  List<String> dropItems = []; // 드랍 아이템 목록
  final int level; // 몬스터 난이도 레벨

  Monster({
    required super.name,
    required super.description,
    required super.maxHp,
    required super.maxMentality,
    required super.maxStrength,
    required super.maxAgility,
    required super.maxArmor,
    required super.armorType,
    required this.partten,
    required this.dropItems,
    required this.level
  });
}