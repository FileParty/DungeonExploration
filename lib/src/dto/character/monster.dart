

import 'package:gemini_survival/src/dto/character/character.dart';

class Monster extends Character {

  List<String> partten = []; // 몬스터 패턴 목록
  List<String> dropItems = []; // 드랍 아이템 목록

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
  });
}