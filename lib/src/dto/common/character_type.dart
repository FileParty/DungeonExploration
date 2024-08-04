// 방어구 유형
enum ArmorType {
  none, // light : 100%, medium : 100%, heavy : 100%
  light, // ligth : 100% , medium : 50% , heavy : 25%
  medium, // ligth : 50% , medium : 100% , heavy : 75%
  heavy, // ligth : 25% , medium : 50% , heavy : 100%
}

// 피해 유형
enum DeamgeType {
  light, // none : 100%, light : 100%, medium: 50%, heavy : 25%
  medium, // none : 100%, light : 50%, medium: 100%, heavy : 50%
  heavy, // none : 100%, light : 25%, medium: 50%, heavy : 100%
  normal, // all : 100%
}

// 액션 유형
enum ActionType { 
  damage, // 공격
  heal, // 회복
  buff, // 버프
}

// 코스트 유형
enum CostType {
  mentality,
  strength,
  agility,
  armor,
  hp,
  shield,
  none,
}

// 버프 유형
enum BuffType {
  damageIncrease, // 데미지 증가
  damageDecrease, // 데미지 감소
  armorIncrease, // 방어력 증가
  armorDecrease, // 방어력 감소
  healDecrease, // 회복 감소
  healIncrease, // 회복 증가
  shieldDecrease, // 보호막 감소
  shieldIncrease, // 보호막 증가
  costDecrease, // 코스트 감소
  costIncrease, // 코스트 증가
  coolTimeDecrease, // 쿨타임 감소
  coolTimeIncrease, // 쿨타임 증가
  heal, // 회복
  stun, // 기절
}