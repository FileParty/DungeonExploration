import 'dart:math';

import 'package:gemini_survival/src/dto/common/map_type.dart';

class MapObject {

  final String title;
  final String description;
  final WorldViewType worldViewType;
  final WorldViewSubType worldViewSubType;
  final List<List<MapRoom>> mapRooms;
  final int limitTrun;

  MapObject({
    required this.title,
    required this.description,
    required this.worldViewType,
    required this.worldViewSubType,
    required this.mapRooms,
    this.limitTrun = 100,
  });

  String getTitle () => title;
  String getDescription () => description;
  WorldViewType getWorldViewType () => worldViewType;
  List<List<MapRoom>> getMapRooms () => mapRooms;
  int getLimitTrun () => limitTrun;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'worldViewType': worldViewType.toString().split('.').last,
      'mapRooms': mapRooms.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      'limitTrun': limitTrun,
    };
  }

}

class MapRoom {

  final MapRoomType mapRoomType;
  bool isTopClose;
  bool isRightClose;
  bool isBottomClose;
  bool isLeftClose;

  MapRoom({
    required this.mapRoomType,
    required this.isTopClose,
    required this.isRightClose,
    required this.isBottomClose,
    required this.isLeftClose,
  });

  Map<String, dynamic> toJson() {
    return {
      'mapRoomType': mapRoomType.toString().split('.').last,
      'isTopClose': isTopClose,
      'isRightClose': isRightClose,
      'isBottomClose': isBottomClose,
      'isLeftClose': isLeftClose,
    };
  }
}

class MapAiResponse {
  final String title;
  final String description;
  final String worldViewType;
  final String worldViewSubType; 
  final int roomRow;
  final int roomCol;
  
  MapAiResponse({
    required this.title,
    required this.description,
    required this.worldViewType,
    required this.worldViewSubType,
    required this.roomRow,
    required this.roomCol,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'worldViewType': worldViewSubType,
      'worldViewSubType': worldViewSubType,
      'roomRow': roomRow,
      'roomCol': roomCol,
    };
  }
}

class MapGenerater {

  MapRoom generateRoom(MapRoomType type) {
    final random = Random();
    return MapRoom(
      mapRoomType: type,
      isTopClose: type == MapRoomType.blank ? false : random.nextBool(),
      isRightClose: type == MapRoomType.blank ? false : random.nextBool(),
      isBottomClose: type == MapRoomType.blank ? false : random.nextBool(),
      isLeftClose: type == MapRoomType.blank ? false : random.nextBool(),
    );
  }

  List<List<MapRoom>> initializeMap(int width, int height) {
    List<List<MapRoom>> mapRooms = List.generate(height, (y) => List.generate(width, (x) => generateRoom(MapRoomType.blank)));
    return mapRooms;
  }

  List<int> findFurthestPoint(int startX, int startY, int width, int height) {
    // start로부터 가장 먼 지점을 찾기 위해 모든 점과의 거리를 계산합니다.
    int furthestX = 0;
    int furthestY = 0;
    double maxDistance = 0;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        double distance = sqrt(pow((x - startX), 2) + pow((y - startY), 2));
        if (distance > maxDistance) {
          maxDistance = distance;
          furthestX = x;
          furthestY = y;
        }
      }
    }

    return [furthestY, furthestX];
  }

  void openPassages(List<List<MapRoom>> mapRooms, int width, int height) {
    final random = Random();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (mapRooms[y][x].mapRoomType != MapRoomType.blank) {
          int openCount = 0;
          if (!mapRooms[y][x].isTopClose && y > 0) openCount++;
          if (!mapRooms[y][x].isRightClose && x < width - 1) openCount++;
          if (!mapRooms[y][x].isBottomClose && y < height - 1) openCount++;
          if (!mapRooms[y][x].isLeftClose && x > 0) openCount++;
          while (openCount < 2) {
            switch (random.nextInt(4)) {
              case 0:
                if (y > 0 && mapRooms[y - 1][x].mapRoomType != MapRoomType.blank) {
                  mapRooms[y][x].isTopClose = false;
                  mapRooms[y - 1][x].isBottomClose = false;
                  openCount++;
                }
                break;
              case 1:
                if (x < width - 1 && mapRooms[y][x + 1].mapRoomType != MapRoomType.blank) {
                  mapRooms[y][x].isRightClose = false;
                  mapRooms[y][x + 1].isLeftClose = false;
                  openCount++;
                }
                break;
              case 2:
                if (y < height - 1 && mapRooms[y + 1][x].mapRoomType != MapRoomType.blank) {
                  mapRooms[y][x].isBottomClose = false;
                  mapRooms[y + 1][x].isTopClose = false;
                  openCount++;
                }
                break;
              case 3:
                if (x > 0 && mapRooms[y][x - 1].mapRoomType != MapRoomType.blank) {
                  mapRooms[y][x].isLeftClose = false;
                  mapRooms[y][x - 1].isRightClose = false;
                  openCount++;
                }
                break;
            }
          }
        }
      }
    }
  }

  List<List<MapRoom>> generateMapRooms(int width, int height) {
    final random = Random();
    List<List<MapRoom>> mapRooms = initializeMap(width, height);

    // 시작 방 설정
    int startY = random.nextInt(height);
    int startX = random.nextInt(width);
    mapRooms[startY][startX] = generateRoom(MapRoomType.start);

    // 엘리트 몬스터 방 개수 계산
    int numEliteMonsters = ((width + height) / 10).ceil();

    // 엘리트 몬스터 방 설정
    for (int i = 0; i < numEliteMonsters; i++) {
      List<int> furthestPoint = findFurthestPoint(startX, startY, width, height);
      int eliteY = furthestPoint[0];
      int eliteX = furthestPoint[1];
      mapRooms[eliteY][eliteX] = generateRoom(MapRoomType.eliteMonster);
      // Start point for the next elite monster
      startX = eliteX;
      startY = eliteY;
    }

    // 나머지 방 설정
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (mapRooms[y][x].mapRoomType == MapRoomType.blank) {
          mapRooms[y][x] = generateRoom(random.nextBool() ? MapRoomType.normalMonster : MapRoomType.event);
        }
      }
    }

    // 통로 열기
    openPassages(mapRooms, width, height);

    return mapRooms;
  }

  List<MapObject> generateRandomMaps(List<MapAiResponse> mapAiResponses) {
    final random = Random();
    final maps = <MapObject>[];

    for (int i = 0; i < mapAiResponses.length; i++) {
      final title = mapAiResponses[i].title;
      final description = mapAiResponses[i].description;
      final worldViewType = mapAiResponses[i].worldViewType;
      final worldViewSubType = mapAiResponses[i].worldViewSubType;
      final int randomWidth = random.nextInt(mapAiResponses[i].roomCol + 5) + mapAiResponses[i].roomCol;
      final int randomHeight = random.nextInt(mapAiResponses[i].roomRow + 5) + mapAiResponses[i].roomRow;
      final mapRooms = generateMapRooms(randomWidth, randomHeight);

      final WorldViewType parseWorldViewType = getWorldViewType(worldViewType);
      final WorldViewSubType parseWorldViewSubType = getWorldViewSubType(parseWorldViewType, worldViewSubType);

      maps.add(MapObject(
        title: title,
        description: description,
        worldViewType: parseWorldViewType,
        worldViewSubType: parseWorldViewSubType,
        mapRooms: mapRooms,
        limitTrun: (randomWidth + randomHeight) * 4,
      ));
    }

    return maps;
  }
}