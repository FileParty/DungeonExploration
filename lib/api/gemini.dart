
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAPI {

  static Future<Map<String, dynamic>> callAPI(Map<String, dynamic> body) async {
    // .env 파일에서 API 키 가져오기
    String apiKey = dotenv.env['API_KEY']!;

    // API 요청 바디 생성
    String parse = jsonEncode(body);
    Map<String, dynamic> responseMap = {};

    // API 호출
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'));

    const prompt = 'List a few popular cookie recipes using this JSON schema:\n\n'
      'Recipe = {"recipeName": string}\n'
      'Return: Array<Recipe>';
    final response = await model.generateContent([Content.text(prompt)]);

    if( response.text != null ) {
      responseMap = jsonDecode(response.text!)['result']; 
    }

    return responseMap;
  }

}