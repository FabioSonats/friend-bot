import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.greenAccent.withOpacity(0.2) : Colors.black,
          border: Border.all(
            color: Colors.greenAccent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (isUser)
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.greenAccent,
            fontFamily: 'RobotoMono',
            fontSize: 16,
            shadows: [
              if (!isUser)
                Shadow(
                  color: Colors.greenAccent.withOpacity(0.4),
                  blurRadius: 10,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
