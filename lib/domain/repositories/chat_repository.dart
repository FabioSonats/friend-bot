import 'package:gemini_chatbot_web/domain/entities/chat_messages.dart';

abstract class ChatRepository {
  Future<Either<Failure, String>> sendMessage(String message);
  Stream<List<ChatMessage>> getChatHistory(String userId);
}
