import 'package:gemini_chatbot_web/data/datasources/chat_remote_data_source.dart';
import 'package:gemini_chatbot_web/domain/entities/chat_messages.dart';
import 'package:gemini_chatbot_web/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> sendMessage(String message) async {
    try {
      final response = await remoteDataSource.generateResponse(message);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<ChatMessage>> getChatHistory(String userId) {
    return remoteDataSource.getChatHistory(userId);
  }
}
