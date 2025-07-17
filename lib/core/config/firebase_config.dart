import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfig {
  // Configuração do Firebase para o projeto web
  static final Map<String, String> firebaseConfig = {
    "apiKey": dotenv.env['GEMINI_API_KEY'] ?? "",
    "authDomain": "flutter-chat-bot-e867d.firebaseapp.com",
    "projectId": "flutter-chat-bot-e867d",
    "storageBucket": "flutter-chat-bot-e867d.appspot.com",
    "messagingSenderId": "100689872833",
    "appId": "1:100689872833:web:d947247f184a14c1d39140",
    "measurementId": "G-GNJ1FPF99M"
  };

  // Coleções do Firestore
  static const Map<String, String> firebaseCollections = {
    "users": "users",
    "chats": "chats",
  };
}
