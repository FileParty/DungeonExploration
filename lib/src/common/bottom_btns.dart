import 'package:flutter/material.dart';

class ButtonInfo {
  final Color color;
  final String text;
  final VoidCallback callBack;

  ButtonInfo({
    required this.color,
    required this.text,
    required this.callBack,
  });
}

class BottomNavigation extends StatelessWidget {
  final List<ButtonInfo> buttons;

  const BottomNavigation({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(72.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((button) {
          return _buildStyledButton(
            onPressed: button.callBack,
            backgroundColor: button.color,
            text: button.text,
          );
        }).toList(),
      ),
    );
  }

  ElevatedButton _buildStyledButton({
    required VoidCallback onPressed,
    required Color backgroundColor,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return const TextStyle(fontWeight: FontWeight.w800, fontSize: 18.0);
          }
          return const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0);
        }),
        side: WidgetStateProperty.all(const BorderSide(color: Colors.black)),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0)),
        minimumSize: WidgetStateProperty.all(const Size(150, 50)),
      ),
      child: Text(text),
    );
  }
}