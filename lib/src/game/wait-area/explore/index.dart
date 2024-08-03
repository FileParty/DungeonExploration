import 'package:flutter/material.dart';
import 'package:gemini_survival/src/common/bottom_btns.dart';
import 'package:gemini_survival/src/provider/provider.dart';
import 'package:provider/provider.dart';

class ExploreIndex extends StatefulWidget {
  const ExploreIndex({super.key});

  @override
  _ExploreIndexState createState() => _ExploreIndexState();
}

class _ExploreIndexState extends State<ExploreIndex> {
  String _selectedInfo = '탐험할 지역을 목록에서 선택하세요.';
  String _selectedType = '지역';

  final List<String> _explorationItems = [
    '숲',
    '동굴',
    '초원',
    '폐허'
  ];

  final Map<String, String> _explorationDetails = {
    '숲': '적막한 숲입니다. 괴물들이 숲을 떠돌고 있습니다. 위험도 5',
    '동굴': '어둡고 무서운 동굴입니다. 위험도 1',
    '초원': '푸르른 초원입니다. 넓은 지역은 언제나 위협적입니다. 위험도 3',
    '폐허': '오래전에 무너진 폐허입니다. 시체들이 살아 움직입니다. 위험도 2',
  };

  void _onItemTap(String item) {
    setState(() {
      _selectedInfo = _explorationDetails[item] ?? 'No details available.';
    });
  }

  void _onTypeTap(String type) {
    setState(() {
      _selectedType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppState>(
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
                    text: '뒤로가기',
                    callBack: () {
                      Provider.of<AppState>(context, listen: false).setGameState(GameState.home);
                    },
                  ),
                ]),
              ),
              Center(
                child: Container(
                  height: 350,
                  width: 550,
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _selectedInfo,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle start exploration button press
                            _onTypeTap('유닛');
                          },
                          child: const Text('유닛 선택'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 100,
                bottom: 100,
                child: Container(
                  width: 200,
                  color: Colors.black54,
                  child: ListView.builder(
                    itemCount: _explorationItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _explorationItems[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () => _onItemTap(_explorationItems[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}