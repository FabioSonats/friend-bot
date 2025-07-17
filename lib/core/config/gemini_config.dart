import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiConfig {
  static String get apiKey {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('GEMINI_API_KEY não encontrada no .env');
    }
    return key;
  }

  static const String model = 'gemini-2.0-flash';

  // Configurações de geração
  static final generationConfig = GenerationConfig(
    temperature: 0.9,
    topK: 40,
    topP: 0.95,
    maxOutputTokens: 1024,
    stopSequences: [],
  );

  // Configurações de segurança
  static final safetySettings = [
    SafetySetting(
      HarmCategory.harassment,
      HarmBlockThreshold.medium,
    ),
    SafetySetting(
      HarmCategory.hateSpeech,
      HarmBlockThreshold.medium,
    ),
    SafetySetting(
      HarmCategory.sexuallyExplicit,
      HarmBlockThreshold.medium,
    ),
    SafetySetting(
      HarmCategory.dangerousContent,
      HarmBlockThreshold.medium,
    ),
  ];
}
