import 'package:flutter/material.dart';

Widget title(String text, {double fontSize = 25,FontWeight fontWeight = FontWeight.w900}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      letterSpacing: 0,
      fontWeight: fontWeight,
      color: const Color.fromRGBO(60, 60, 60, 1.0),
    ),
  );
}
