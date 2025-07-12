import 'package:gemini_chatbot_web/domain/entities/chat_messages.dart';

abstract class ChatRemoteDataSource {
  Future<String> generateResponse(String prompt);
  Stream<List<ChatMessage>> getChatHistory(String userId);
  Future<void> saveMessage(ChatMessage message, String userId);
}
