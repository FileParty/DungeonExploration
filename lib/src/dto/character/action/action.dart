

import 'package:gemini_survival/src/dto/common/character_type.dart';

class Action {
  final String name;
  final String description;
  final ActionType type;

  Action({
    required this.name,
    required this.description,
    required this.type,
  });

}

class MonsterAction {
  final String name;
  final String description;
  final List<Action> actionList;

  MonsterAction({
    required this.name,
    required this.description,
    required this.actionList,
  });
}

class PlayerAction {
  final String name;
  final String description;
  final List<Action> actionList;
  final WorldViewType worldViewType;
  int cost;
  int cooldown;
  int waitTime;

  PlayerAction({
    required this.name,
    required this.description,
    required this.actionList,
    required this.worldViewType,
    this.cost = 0,
    this.cooldown = 0,
    this.waitTime = 0,
  });
}

class ActionTypeDeamge extends Action {
  final ActionType actionType = ActionType.damage;
  final DeamgeType deamgeType;
  final int value;

  ActionTypeDeamge({
    required this.deamgeType,
    required this.value,
    required super.name,
    required super.description,
    required super.type,
  });
}

class ActionTypeHeal extends Action {
  final ActionType actionType = ActionType.heal;
  final int value;

  ActionTypeHeal({
    required this.value,
    required super.name,
    required super.description,
    required super.type,
  });
}

class ActionTypeBuff extends Action {
  final ActionType actionType = ActionType.buff;
  final BuffType buffType;
  final int value;

  ActionTypeBuff({
    required this.buffType,
    required this.value,
    required super.name,
    required super.description,
    required super.type,
  });
}