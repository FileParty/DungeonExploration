import 'package:flutter/material.dart';
import 'package:gemini_survival/api/gemini.dart';
import 'package:gemini_survival/src/common/bottom_btns.dart';
import 'package:gemini_survival/src/dto/character/unit.dart';
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
  bool _isUnitSelection = false;
  MapObject? _selectedMap;
  

  void _onItemTap(MapObject item) {
    setState(() {
      _selectedMap = item;
    });
  }

  void _toggleUnitSelection(BuildContext context) {
    setState(() {
      Provider.of<AppState>(context, listen: false).setSelectExploreInMap(_selectedMap!);
      _isUnitSelection = !_isUnitSelection;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<MapObject> currentMaps = Provider.of<AppState>(context, listen: false).maps;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (currentMaps.isEmpty) {
          // 비동기 처리
          Future(() async {
            // API 호출
            Provider.of<AppState>(context, listen: false).toggleLoading();
            final response = await GeminiAPI.callJsonList(exploreMapParam);
            List<MapAiResponse> responseList = [];
            for (var e in response) {
              responseList.add(MapAiResponse(
                title: e['title'] ?? '',
                description: e['description'] ?? '',
                worldViewType: e['worldviewtype'] ?? '',
                worldViewSubType: e['worldviewsubtype'] ?? '',
                roomRow: e['roomrow'] != null ? int.tryParse(e['roomrow'].toString()) ?? 0 : 0,
                roomCol: e['roomcol'] != null ? int.tryParse(e['roomcol'].toString()) ?? 0 : 0,
              ));
            }
            // 로컬 데이터 생성
            List<MapObject> generMap = MapGenerater().generateRandomMaps(responseList);
            // Provider 업데이트 (UI 렌더링 후 실행)
            Provider.of<AppState>(context, listen: false).setMaps(generMap);
            Provider.of<AppState>(context, listen: false).toggleLoading();
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
                      _toggleUnitSelection(context);
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
    String worldViewTypeName = getWorldViewTypeName(_selectedMap?.worldViewType ?? WorldViewType.common);
    String worldViewSubTypeName = getWorldViewSubTypeName(
      _selectedMap?.worldViewType ?? WorldViewType.common, 
      _selectedMap?.worldViewSubType ?? WorldViewFantasy.forest
    );
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
                width: 200,
                child: Wrap(
                  children: [
                    ListTile(
                      title: Text(
                        appState.maps[index].getTitle(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () => _onItemTap(appState.maps[index]),
                    ),
                  ],
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
                    '$worldViewTypeName $worldViewSubTypeName',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _selectedMap?.getDescription() ?? '지역을 선택하세요.',
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
            onPressed: _selectedMap == null ? null : () => _toggleUnitSelection(context),
            child: const Text('유닛 선택'),
          ),
        ),
      ],
    );
  }

  Widget _buildUnitSelection(AppState appState) {
    return Container(
      color: Colors.black54,
      child: Column(
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
            child: ListView.builder(
              itemCount: appState.units.length,
              itemBuilder: (context, index) {
                PlayerUnit unit = appState.units[index];
                return Card(
                  color: Colors.black54,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      unit.name,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('설명: ${unit.description}', style: TextStyle(color: Colors.white70)),
                        Text('HP: ${unit.maxHp}', style: TextStyle(color: Colors.white70)),
                        Text('정신력: ${unit.maxMentality}', style: TextStyle(color: Colors.white70)),
                        Text('힘: ${unit.maxStrength}', style: TextStyle(color: Colors.white70)),
                        Text('민첩성: ${unit.maxAgility}', style: TextStyle(color: Colors.white70)),
                        Text('방어력: ${unit.maxArmor}', style: TextStyle(color: Colors.white70)),
                        Text('방어 유형: ${unit.armorType}', style: TextStyle(color: Colors.white70)),
                        Text('랭크: ${unit.rank}', style: TextStyle(color: Colors.white70)),
                        Text('월드 뷰 타입: ${unit.worldViewType}', style: TextStyle(color: Colors.white70)),
                        Text('행동:', style: TextStyle(color: Colors.white70)),
                        ...unit.actions.map((action) => Text('${action.name}: ${action.description}', style: TextStyle(color: Colors.white70))),
                      ],
                    ),
                    onTap: () {
                      appState.setSelectExploreInUnit(unit);
                      // 유닛 선택 처리
                    },
                  ),
                );
              },
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
      )
    );
  }
}
