import 'package:flutter/material.dart';

AppBar buildCommonAppBar() {
  return AppBar(
    title: const Text(
      '제미나이 서바이벌',
      style: TextStyle(
        color: Colors.white, // 텍스트 색상 흰색
        fontWeight: FontWeight.bold, // 텍스트 굵게
        fontSize: 24, // 텍스트 크기
        shadows: [
          Shadow(
            offset: Offset(1.5, 1.5), // 그림자 위치
            blurRadius: 3.0, // 그림자 흐림 정도
            color: Colors.black, // 그림자 색상 검정
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}