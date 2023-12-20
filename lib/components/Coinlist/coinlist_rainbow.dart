import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
 
 class RainbowText extends StatefulWidget {
  final dataFromChild;
   const RainbowText({ super.key, required this.dataFromChild });
 
   @override
   _RainbowText createState() => _RainbowText();
 }
 
 class _RainbowText extends State<RainbowText> {
    bool isColorChange = false;
    var randomValue = Random().nextInt(10); // Value is > 0 and < 10.
    final duration = Duration(seconds: Random().nextInt(20) + 5);

    void makeTimer() { 
      Timer.periodic(duration, (timer) {
        if (mounted) {
      setState(() {
        isColorChange = !isColorChange;
        randomValue = Random().nextInt(10);
        timer.cancel();
      });
        }
    });
    }

    // Shader colors red //
        static final Shader _linearGradientRed = const LinearGradient(
              colors: <Color>[Color.fromARGB(255, 238, 162, 162), Color.fromARGB(255, 129, 7, 7)],
            ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

        static final Shader _linearGradientGreen = const LinearGradient(
              colors: <Color>[Color.fromARGB(255, 164, 241, 171), Color.fromARGB(255, 4, 119, 56)],
            ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    // Shader colors green//

    final TextStyle initialStyle = TextStyle(
      fontSize: 16,
      // color: Color.fromARGB(255, 158, 2, 2),
      foreground: Paint()..shader = _linearGradientRed);

    final TextStyle finalStyle = TextStyle(
      fontSize: 16,
      // color: Color.fromARGB(255, 30, 119, 82),
      foreground: Paint()..shader = _linearGradientGreen);

   @override
   Widget build(BuildContext context) {
    String newTextforWidget = widget.dataFromChild.toString().substring(0, (widget.dataFromChild.toString()).length - 1);
        makeTimer();
    return 
    AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 700),
          style: isColorChange ? initialStyle : finalStyle,
          child: Text('\$$newTextforWidget$randomValue')
    );
   }
 }