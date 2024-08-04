import 'package:flutter/material.dart';
import 'package:gemini_survival/api/gemini.dart';
import 'package:gemini_survival/src/common/bottom_btns.dart';
import 'package:gemini_survival/src/dto/common/map_type.dart';
import 'package:gemini_survival/src/dto/map.dart';
import 'package:gemini_survival/src/game/api/wait_area.dart';
import 'package:gemini_survival/src/provider/provider.dart';
import 'package:provider/provider.dart';

class ExploreIndex extends StatefulWidget {
  const ExploreIndex({super.key});

  @override
  _ExploreIndexState createState() => _ExploreIndexState();
}

class _ExploreIndexState extends State<ExploreIndex> {
  String _selectedInfo = '탐험할 지역을 목록에서 선택하세요.';
  WorldViewType? _selectedType;
  WorldViewSubType? _selectedSubType;
  bool _isUnitSelection = false;
  

  void _onItemTap(MapObject item) {
    setState(() {
      _selectedInfo = item.description;
      _selectedType = item.worldViewType;
      _selectedSubType = item.worldViewSubType;
    });
  }

  void _toggleUnitSelection() {
    setState(() {
      _isUnitSelection = !_isUnitSelection;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<MapObject> currentMaps = Provider.of<AppState>(context, listen: false).maps;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (currentMaps.length <= 2) { // 예시: 최소 10개의 맵이 필요한 경우
          // 비동기 처리
          Future(() async {
            // API 호출
            final response = await GeminiAPI.callJsonList(exploreMapParam);
            List<MapAiResponse> responseList = [];
            for (var e in response) {
              responseList.add(MapAiResponse(
                title: e['title'],
                description: e['description'],
                worldViewType: e['worldViewType'],
                worldViewSubType: e['worldViewSubType'],
                roomRow: e['roomRow'],
                roomCol: e['roomCol'],
              ));
            }
            // 로컬 데이터 생성
            List<MapObject> generMap = MapGenerater().generateRandomMaps(responseList);
            // Provider 업데이트 (UI 렌더링 후 실행)
            Provider.of<AppState>(context, listen: false).setMaps(generMap);
          });
        }
      } catch(e) {
        print(e);
      }
    });

    

    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                '/game/explore.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigation(buttons: [
                ButtonInfo(
                  color: Colors.red,
                  text: _isUnitSelection ? '지역 재선택' : '뒤로가기',
                  callBack: () {
                    if (_isUnitSelection) {
                      _toggleUnitSelection();
                    } else {
                      Provider.of<AppState>(context, listen: false).setGameState(GameState.home);
                    }
                  },
                ),
              ]),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 50), // 여백을 통해 화면 상단과의 간격 조절
                height: 450,
                width: 750,
                child: _isUnitSelection ? _buildUnitSelection(appState) : _buildExplorationSelection(appState),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExplorationSelection(AppState appState) {
    String worldViewTypeName = getWorldViewTypeName(_selectedType ?? WorldViewType.common);
    String worldViewSubTypeName = getWorldViewSubTypeName(_selectedType ?? WorldViewType.common, _selectedSubType ?? WorldViewFantasy.forest);
    return Column(
      children: [
        Container(
          height: 100,
          margin: const EdgeInsets.only(bottom: 10),
          color: Colors.black54,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: appState.maps.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 175, // 각 아이템의 너비를 설정
                child: ListTile(
                  title: Text(
                    appState.maps[index].getTitle(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => _onItemTap(appState.maps[index]),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 750.0,
                minHeight: 500.0,
              ),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(top: 10),
              color: Colors.black54,
              child: Column(
                children: [
                  Text(
                    '$worldViewTypeName : $worldViewSubTypeName'
                    ,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _selectedInfo,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _toggleUnitSelection,
            child: const Text('유닛 선택'),
          ),
        ),
      ],
    );
  }

  Widget _buildUnitSelection(AppState appState) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '탐험을 나설 유닛을 선택하세요.',
            style: TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: const Text('유닛 1', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // 유닛 1 선택 처리
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // 유닛 선택 완료 시 실행할 코드 추가
            },
            child: const Text('탐험 시작'),
          ),
        ),
      ],
    );
  }
}
