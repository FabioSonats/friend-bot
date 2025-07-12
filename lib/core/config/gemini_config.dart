import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiConfig {
  // Chave da API Gemini (armazenada no .env)
  static String get apiKey {
    final key = dotenv.env['AIzaSyCQRkyEdgtfQtu5yQvIkdbHcwupAPU7ImM'];
    if (key == null || key.isEmpty) {
      throw Exception('GEMINI_API_KEY não encontrada no .env');
    }
    return key;
  }

  // Modelo a ser utilizado
  static const String model = 'gemini-pro';

  // Configurações de geração
  static const generationConfig = {
    'temperature': 0.9,
    'topK': 40,
    'topP': 0.95,
    'maxOutputTokens': 1024,
    'stopSequences': [],
  };

  // Configurações de segurança
  static const safetySettings = [
    {
      'category': 'HARM_CATEGORY_HARASSMENT',
      'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
    },
    {
      'category': 'HARM_CATEGORY_HATE_SPEECH',
      'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
    },
    {
      'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
      'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
    },
    {
      'category': 'HARM_CATEGORY_DANGEROUS_CONTENT',
      'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
    },
  ];
}
