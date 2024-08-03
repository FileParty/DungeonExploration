
import 'package:gemini_survival/src/dto/character/monster.dart';
import 'package:gemini_survival/src/dto/common/character_type.dart';

class MapObject {

  final String title;
  final String description;
  final WorldViewType worldViewType;
  final List<Monster> monsters;

  MapObject({
    required this.title,
    required this.description,
    required this.worldViewType,
    required this.monsters,
  });

  String getTitle () => title;
  String getDescription () => description;
  WorldViewType getWorldViewType () => worldViewType;
  List<Monster> getMonsters () => monsters;

}