import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const SignUpButton({
    super.key,
    required this.onTap,
    required this.text,
  });
  
  get child => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 55),
        decoration: BoxDecoration(
          color: const Color.fromARGB(207, 160, 1, 112),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(text,style: const TextStyle(
           color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12,letterSpacing: 6),
          ),
        ),
      );
  }
}