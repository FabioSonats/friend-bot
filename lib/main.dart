import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/firebase_config.dart';
import 'package:gemini_chatbot_web/presentation/views/auth_screen.dart';
import 'package:provider/provider.dart';
import 'presentation/views/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega variáveis de ambiente
  await dotenv.load(fileName: "assets/.env");

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: FirebaseConfig.firebaseConfig["apiKey"]!,
      authDomain: FirebaseConfig.firebaseConfig["authDomain"]!,
      projectId: FirebaseConfig.firebaseConfig["projectId"]!,
      storageBucket: FirebaseConfig.firebaseConfig["storageBucket"]!,
      messagingSenderId: FirebaseConfig.firebaseConfig["messagingSenderId"]!,
      appId: FirebaseConfig.firebaseConfig["appId"]!,
      measurementId: FirebaseConfig.firebaseConfig["measurementId"]!,
    ),
  );

  runApp(const GeminiChatbotApp());
}

class GeminiChatbotApp extends StatelessWidget {
  const GeminiChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          create: (_) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'StrikerBot Chat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return user != null ? const ChatScreen() : const AuthScreen();
  }
}
