import 'package:flutter/material.dart';

class RegisterUsernameTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const RegisterUsernameTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          onTap: ()=> {},
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(Icons.login_outlined,color: Color.fromARGB(176, 139, 9, 89),),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 134, 134, 134), fontSize: 15,fontWeight:FontWeight.w400),
          ),
        ),
      ),
    );
  }
}