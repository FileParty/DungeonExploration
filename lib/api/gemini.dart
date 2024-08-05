
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAPI {

  static Future<List<dynamic>> callJsonList<T>(Map<String, dynamic> body) async {
    try {
      // .env 파일에서 API 키 가져오기
      String apiKey = dotenv.env['GEMINI_API_KEY']!;

      // API 호출
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(responseMimeType: 'application/json'));

      final response = await model.generateContent([Content.text(jsonEncode(body))]);
      
      if( response.text != null ) {
        List<dynamic> jsonObject = jsonDecode(response.text!.toLowerCase());
        // description에서 줄바꿈 및 개행 문자 제거
        jsonObject = jsonObject.map((item) {
          item.forEach((key, value) {
            item[key] = value.toString().replaceAll('\n', '').replaceAll('\r', '').replaceAll(RegExp(r'\s+'), ' ');
          });
          return item;
        }).toList();
        return jsonObject;
      }
      return [];
    } catch(e) {
      print(e);
      throw Exception('Failed to load post');
    }
  }

}