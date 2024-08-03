
import 'package:flutter/material.dart';
import 'package:gemini_survival/src/common/bottom_btns.dart';
import 'package:gemini_survival/src/provider/provider.dart';
import 'package:provider/provider.dart';

class ExploreLocation extends StatelessWidget {
  const ExploreLocation({super.key});

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
                      const Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '탐험할 지역을 선택하세요.',
                              style: TextStyle(fontSize: 18, color: Colors.white),
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
                            //_onTypeTap('유닛');
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
                    itemCount: appState.maps.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          appState.maps[index].title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        //onTap: () => _onItemTap(_explorationItems[index]),
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