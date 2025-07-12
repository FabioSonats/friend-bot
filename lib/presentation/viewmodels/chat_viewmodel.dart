import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/entities/chat_messages.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatViewModel with ChangeNotifier {
  final ChatRepository _chatRepository;
  final String _userId;

  ChatViewModel({
    required ChatRepository chatRepository,
    required String userId,
  })  : _chatRepository = chatRepository,
        _userId = userId;

  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StreamSubscription<List<ChatMessage>>? _chatSubscription;

  void init() {
    _chatSubscription =
        _chatRepository.getChatHistory(_userId).listen((messages) {
      _messages = messages;
      notifyListeners();
    });
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message,
      timestamp: DateTime.now(),
      isUser: true,
    );

    _messages = [..._messages, userMessage];
    _isLoading = true;
    notifyListeners();

    final response = await _chatRepository.sendMessage(message);

    response.fold(
      (failure) {
        // Handle error
        _messages = [
          ..._messages,
          ChatMessage(
            id: 'error-${DateTime.now().millisecondsSinceEpoch}',
            content: 'Error: ${failure?.message ?? "Unknown error"}',
            timestamp: DateTime.now(),
            isUser: false,
          )
        ];
      },
      (aiResponse) {
        _messages = [
          ..._messages,
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: aiResponse,
            timestamp: DateTime.now(),
            isUser: false,
          )
        ];
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    super.dispose();
  }
}
