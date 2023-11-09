import 'package:flutter/material.dart';

const String fontName = '';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final bool bold, italic, shadowed;
  final Color color;

  const MyText(
      {super.key,
      required this.text,
      required this.size,
      this.bold = false,
      this.italic = false,
      this.shadowed = true,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    FontWeight fw = FontWeight.normal;
    if (bold == true) {
      fw = FontWeight.bold;
    }
    FontStyle fs = FontStyle.normal;
    if (italic == true) {
      fs = FontStyle.italic;
    }

    if (shadowed == true) {
      return Text(text,
          style: TextStyle(
            fontSize: size,
            color: color,
            fontFamily: fontName,
            fontStyle: fs,
            fontWeight: fw,
            shadows: const <Shadow>[
              Shadow(
                color: Color.fromARGB(175, 158, 158, 158),
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ));
    } else {
      return Text(text,
          style: TextStyle(
            fontSize: size,
            color: color,
            fontFamily: fontName,
            fontStyle: fs,
            fontWeight: fw,
          ));
    }
  }
}
