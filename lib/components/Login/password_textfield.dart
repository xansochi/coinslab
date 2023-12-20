import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final onIconTap;
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onIconTap,
  });

  //   validatePassword(String value) {
  //   if (value.isEmpty) {
  //     return "Password should contain more than 5 characters";
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            // errorText: validatePassword(controller.text),
            floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: IconButton(
        icon: const Icon(
              Icons.visibility,
          color: Color.fromARGB(138, 3, 36, 85),
          size: 20,
        ),
          onPressed: ()=>onIconTap()
          ,
      ),
            prefixIcon: const Icon(Icons.lock_open_sharp,color: Color.fromARGB(195, 139, 9, 89),),
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