import 'package:flutter/material.dart';

class CustomMatrixButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomMatrixButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.greenAccent,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.greenAccent, width: 2),
        ),
        textStyle: const TextStyle(
          fontFamily:
              'RobotoMono', // Use uma fonte monoespaçada para efeito Matrix
          fontWeight: FontWeight.bold,
          fontSize: 18,
          letterSpacing: 2,
        ),
        elevation: 8,
        shadowColor: Colors.greenAccent.withOpacity(0.5),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                strokeWidth: 3,
              ),
            )
          : Text(
              text,
              style: const TextStyle(
                color: Colors.greenAccent,
                shadows: [
                  Shadow(
                    color: Colors.green,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
    );
  }
}
