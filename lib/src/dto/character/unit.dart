

import 'package:gemini_survival/src/dto/character/character.dart';

class Unit extends Character {

  
  int rank = 1; // 유닛 랭크

  Unit({
    required super.name,
    required super.description,
    required super.maxHp,
    required super.maxMentality,
    required super.maxStrength,
    required super.maxAgility,
    required super.maxArmor,
    required super.armorType,
    required this.rank,
  });
}