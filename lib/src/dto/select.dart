
import 'package:gemini_survival/src/dto/character/unit.dart';
import 'package:gemini_survival/src/dto/map.dart';

class SelectExplore {
  PlayerUnit? selectUnit;
  MapObject? selectMap;

  SelectExplore({
    this.selectUnit,
    this.selectMap,
  });

  PlayerUnit? getSelectUnit() => selectUnit;
  MapObject? getSelectMap() => selectMap;

  void reset() {
    selectUnit = null;
    selectMap = null;
  }

  void setSelectUnit(PlayerUnit unit) {
    selectUnit = unit;
  }

  void setSelectMap(MapObject map) {
    selectMap = map;
  }
}