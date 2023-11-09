import 'package:flutter/material.dart';

import '../../assets/colors.dart';

const String fontName = '';

class MyTextStyle {
  static TextStyle get(
      {required double size,
      Color color = BLACK,
      bool bold = false,
      bool italic = false,
      bool shadowed = true}) {
    FontWeight fw = FontWeight.normal;
    if (bold == true) {
      fw = FontWeight.bold;
    }
    FontStyle fs = FontStyle.normal;
    if (italic == true) {
      fs = FontStyle.italic;
    }

    if (shadowed == true) {
      return TextStyle(
        fontSize: size,
        color: color,
        fontFamily: fontName,
        fontStyle: fs,
        fontWeight: fw,
        shadows: const <Shadow>[
          Shadow(
            color: GREY,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      );
    } else {
      return TextStyle(
        fontSize: size,
        color: color,
        fontFamily: fontName,
        fontStyle: fs,
        fontWeight: fw,
      );
    }
  }
}
