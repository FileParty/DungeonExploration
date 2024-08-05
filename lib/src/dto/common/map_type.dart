
enum WorldViewType {
  fantasy, // 판타지
  cyberpunk, // 사이버펑크
  martialarts, // 무협
  common, // 공통
}

WorldViewType getWorldViewType(String value) {
  switch (value) {
    case 'fantasy':
      return WorldViewType.fantasy;
    case 'cyberpunk':
      return WorldViewType.cyberpunk;
    case 'martialarts':
      return WorldViewType.martialarts;
    case 'common':
      return WorldViewType.common;
    default:
      throw Exception('Unknown WorldViewType value: $value');
  }
}

String getWorldViewTypeName(WorldViewType worldViewType) {
  switch (worldViewType) {
    case WorldViewType.fantasy:
      return '판타지';
    case WorldViewType.cyberpunk:
      return '사이버펑크';
    case WorldViewType.martialarts:
      return '무협';
    default:
      return '없음';
  }
}

sealed class WorldViewSubType {}

WorldViewSubType getWorldViewSubType(WorldViewType worldViewType, String value) {
  switch (worldViewType) {
    case WorldViewType.fantasy:
      return WorldViewFantasy.fromString(value);
    case WorldViewType.cyberpunk:
      return WorldViewCyberpunk.fromString(value);
    case WorldViewType.martialarts:
      return WorldViewMartialArts.fromString(value);
    default:
      throw Exception('Unknown WorldViewType value: $value');
  }
}

String getWorldViewSubTypeName(WorldViewType worldViewType, WorldViewSubType worldViewSubType) {
  switch (worldViewType) {
    case WorldViewType.fantasy:
      return WorldViewFantasy.getName(worldViewSubType as WorldViewFantasy);
    case WorldViewType.cyberpunk:
      return WorldViewCyberpunk.getName(worldViewSubType as WorldViewCyberpunk);
    case WorldViewType.martialarts:
      return WorldViewMartialArts.getName(worldViewSubType as WorldViewMartialArts);
    default:
      return '';
  }
}

class WorldViewFantasy extends WorldViewSubType {
  final String value;
  WorldViewFantasy(this.value);

  static WorldViewFantasy forest = WorldViewFantasy('forest'); // 숲
  static WorldViewFantasy cave = WorldViewFantasy('cave'); // 동굴
  static WorldViewFantasy ruin = WorldViewFantasy('ruin'); // 폐허
  static WorldViewFantasy desert = WorldViewFantasy('desert'); // 사막

  static WorldViewFantasy fromString(String value) {
    switch (value) {
      case 'forest':
        return forest;
      case 'cave':
        return cave;
      case 'ruin':
        return ruin;
      case 'desert':
        return desert;
      default:
        throw Exception('Unknown WorldViewFantasy value: $value');
    }
  }

  static String getName(WorldViewFantasy worldViewFantasy) {
    switch (worldViewFantasy.value) {
      case 'forest':
        return '숲';
      case 'cave':
        return '동굴';
      case 'ruin':
        return '폐허';
      case 'desert':
        return '사막';
      default:
        return '';
    }
  }
}

class WorldViewCyberpunk extends WorldViewSubType {
  final String value;
  WorldViewCyberpunk(this.value);

  static WorldViewCyberpunk city = WorldViewCyberpunk('city'); // 도시
  static WorldViewCyberpunk factory = WorldViewCyberpunk('factory'); // 공장
  static WorldViewCyberpunk lab = WorldViewCyberpunk('lab'); // 연구소
  static WorldViewCyberpunk company = WorldViewCyberpunk('company'); // 회사

  static WorldViewCyberpunk fromString(String value) {
    switch (value) {
      case 'city':
        return city;
      case 'factory':
        return factory;
      case 'lab':
        return lab;
      case 'company':
        return company;
      default:
        throw Exception('Unknown WorldViewCyberpunk value: $value');
    }
  }

  static String getName(WorldViewCyberpunk worldViewCyberpunk) {
    switch (worldViewCyberpunk.value) {
      case 'city':
        return '도시';
      case 'factory':
        return '공장';
      case 'lab':
        return '연구소';
      case 'company':
        return '회사';
      default:
        return '';
    }
  }
}

class WorldViewMartialArts extends WorldViewSubType {
  final String value;
  WorldViewMartialArts(this.value);

  static WorldViewMartialArts forest = WorldViewMartialArts('forest'); // 숲
  static WorldViewMartialArts temple = WorldViewMartialArts('temple'); // 사원
  static WorldViewMartialArts dojo = WorldViewMartialArts('dojo'); // 도장
  static WorldViewMartialArts village = WorldViewMartialArts('village'); // 마을

  static WorldViewMartialArts fromString(String value) {
    switch (value) {
      case 'forest':
        return forest;
      case 'temple':
        return temple;
      case 'dojo':
        return dojo;
      case 'village':
        return village;
      default:
        throw Exception('Unknown WorldViewMartialArts value: $value');
    }
  }

  static String getName(WorldViewMartialArts worldViewMartialArts) {
    switch (worldViewMartialArts.value) {
      case 'forest':
        return '숲';
      case 'temple':
        return '사원';
      case 'dojo':
        return '도장';
      case 'village':
        return '마을';
      default:
        return '';
    }
  }
}

enum MapRoomType {
  start, // 플레이어 시작 위치
  event, // 이벤트
  normalMonster, // 일반 몬스터
  eliteMonster, // 엘리트 몬스터
  escapeRoom, // 탈출
  blank, // 빈 방
}