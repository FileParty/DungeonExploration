import 'package:gemini_survival/src/dto/map.dart';

Map<String, dynamic> exploreMapParam = {
  'prompt': '다음의 사항들은 api 반환값인 Map 오브젝트를 설명하고 있습니다. \n'
    'description에 있는 MapAiResponse의 메소드를 참고로 하여서 4개의 MapAiResponse을 만들어서 반환해야 합니다.\n'
    'returnExample를 참고로 같은 양식으로 json을 참고하되, 동일한 값으로 생성해서는 안됩니다.\n'
    '또한, roomRow와 roomCol은 각 룸의 난이도에 따라 크기를 10단위로 조정하세요. 최소는 10입니다.\n'
    '생성되는 데이터의 분위기는 판타지, 사이버펑크, 무협들에서 어둡고 건조한 분위기로 텍스트를 생성하세요.\n'
    '각 JSON 객체는 단일 줄로 표현되어야 하며, 어떠한 형태의 공백 문자도 포함되지 않아야 합니다.\n'
  ,
  'description': {
    'MapAiResponse': {
      'title': '맵의 제목을 나타내는 문자열입니다.',
      'description': '맵의 설명을 나타내는 문자열입니다.',
      'WorldViewType': '판타지, 사이버펑크, 무협, 공통의 세계관을 나타내는 열거형입니다.\n'
        '아래 3개의 타입 중 하나의 값으로 반환해야 합니다.\n'
        'WorldViewType.fantasy: 판타지\n'
        'WorldViewType.cyberpunk: 사이버펑크\n'
        'WorldViewType.martialArts: 무협\n'
      ,
      'WorldViewSubType': '세계관의 세부적인 세부 세계관을 나타내는 클래스입니다.'
        '위의 WorldViewType와 일치하는 타입 중 하나를 사용해야 합니다.\n'
        'WorldViewFantasy.forest: 숲\n'
        'WorldViewFantasy.cave: 동굴\n'
        'WorldViewFantasy.ruin: 폐허\n'
        'WorldViewFantasy.desert: 사막\n'
        'WorldViewCyberpunk.city: 도시\n'
        'WorldViewCyberpunk.factory: 공장\n'
        'WorldViewCyberpunk.lab: 연구소\n'
        'WorldViewCyberpunk.company: 회사\n'
        'WorldViewMartialArts.forest: 숲\n'
        'WorldViewMartialArts.temple: 사원\n'
        'WorldViewMartialArts.dojo: 도장\n'
        'WorldViewMartialArts.village: 마을\n'
      ,
    }
  },
  'returnExample': [
    MapAiResponse(
      title: '맵1',
      description: '맵1의 설명',
      worldViewType: 'fantasy',
      worldViewSubType: 'forest',
      roomRow: 10,
      roomCol: 10
    ).toJson(),
  ],
  'return': 'Array<MapAiResponse>'
};