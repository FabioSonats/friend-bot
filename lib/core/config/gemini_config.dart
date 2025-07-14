import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiConfig {
  // Chave da API
  static String get apiKey {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('GEMINI_API_KEY não encontrada no .env');
    }
    return key;
  }

  // Atualize para o modelo correto (versão mais recente)
  static const String model =
      'gemini-1.5-pro'; // Ou 'gemini-1.0-pro' se preferir

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
