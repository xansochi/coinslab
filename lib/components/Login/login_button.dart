import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isLoading;
  const LoginButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.isLoading
  });
  
  get child => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 1, 102, 160),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
           child: isLoading ? const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.0,
          ) : Text(text,style: const TextStyle(
           color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16,letterSpacing: 12),
          ),
        ),
      ),
    );
  }
}