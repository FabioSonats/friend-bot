import 'package:flutter/material.dart';
import 'package:gemini_chatbot_web/core/widgets/custom_button.dart';
import 'package:gemini_chatbot_web/presentation/views/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChatScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e.code);
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este e-mail já está em uso';
      case 'invalid-email':
        return 'E-mail inválido';
      case 'weak-password':
        return 'Senha fraca';
      default:
        return 'Erro ao cadastrar';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.green.shade900.withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.app_registration,
                      size: 100, color: Colors.greenAccent),
                  const SizedBox(height: 32),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.greenAccent, Colors.green],
                      stops: [0.5, 1.0],
                    ).createShader(bounds),
                    child: const Text(
                      'CADASTRAR CONTA',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.greenAccent),
                    decoration: _buildInputDecoration('E-mail', Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu e-mail';
                      }
                      if (!value.contains('@')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.greenAccent),
                    decoration: _buildInputDecoration('Senha', Icons.lock),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  CustomMatrixButton(
                    text: 'REGISTRAR',
                    onPressed: _register,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Voltar ao login',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontFamily: 'RobotoMono',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.greenAccent.withOpacity(0.7)),
      prefixIcon: Icon(icon, color: Colors.greenAccent),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }
}
