import 'package:gemini_chatbot_web/data/datasources/chat_remote_data_source.dart';
import 'package:gemini_chatbot_web/domain/entities/chat_messages.dart';

class GeminiDataSource implements ChatRemoteDataSource {
  final GenerativeModel _model;

  GeminiDataSource({required String apiKey})
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: apiKey,
        );

  @override
  Future<String> generateResponse(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    return response.text ?? 'No response from AI';
  }

  @override
  Stream<List<ChatMessage>> getChatHistory(String userId) {
    // TODO: implement getChatHistory
    throw UnimplementedError();
  }

  @override
  Future<void> saveMessage(ChatMessage message, String userId) {
    // TODO: implement saveMessage
    throw UnimplementedError();
  }

  // Implement other methods...
}
