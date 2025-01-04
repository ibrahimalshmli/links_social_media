import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.Color,
  });
  final String text;
  final color;
  final Color;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      color: color,

      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(color: Color, fontSize: 25, fontFamily: "Roboto"),
        ),
      ),
    );
  }
}
