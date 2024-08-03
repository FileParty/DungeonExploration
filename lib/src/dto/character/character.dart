import 'package:gemini_survival/src/dto/common/character_type.dart';

class Character {
  final String name;
  final String description;
  int maxHp = 100; // 최대 체력
  int currentHp; // 현재 체력
  int maxShield = 0; // 최대 보호막
  int currentShield; // 현재 보호막
  int maxMentality; // 최대 정신력
  int currentMentality; // 현재 정신력
  int maxStrength; // 최대 힘
  int currentStrength; // 현재 힘 
  int maxAgility; // 최대 민첩
  int currentAgility; // 현재 민첩
  int maxArmor; // 최대 방어력
  int currentArmor; // 현재 방어력
  ArmorType armorType; // 방어구 타입

  Character({
    required this.name,
    required this.description,
    required this.maxHp,
    required this.maxMentality,
    required this.maxStrength,
    required this.maxAgility,
    required this.maxArmor,
    required this.armorType,
    this.maxShield = 0,
  }) : currentHp = maxHp,
       currentShield = maxShield,
       currentMentality = maxMentality,
       currentStrength = maxStrength,
       currentAgility = maxAgility,
       currentArmor = maxArmor;



}