import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({
    super.key,
    required this.texts,
    this.colors,
    this.Colors,
    required this.onPresseds,
    required this.Colores,
  });
  final String texts;
  final colors;
  final Colors;
  final Colores;
  final void Function() onPresseds;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(color: Colores, width: 2.5),
      ),
      color: colors,

      onPressed: onPresseds,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          texts,
          style: TextStyle(color: Colors, fontSize: 25, fontFamily: "Roboto"),
        ),
      ),
    );
  }
}
