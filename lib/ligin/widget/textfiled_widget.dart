// import 'package:flutter/material.dart';
//
// class TextfiledWidget extends StatelessWidget {
//   const TextfiledWidget({
//     super.key,
//     required this.text,
//     required this.onChanged,
//   });
//   final String text;
//
//   final ValueChanged onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         hintText: text,
//         hintStyle: TextStyle(color: Color(0xffCECECE)),
//         contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
//         //filled: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Color(0xff2D2B4E)),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

Widget customTextField(
  controller,
  label, {
  required Function(dynamic value) validator,
}) {
  dynamic validator;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Form(
      //  elevation: 8,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
        validator: validator,

        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          hintStyle: TextStyle(color: Color(0xffCECECE)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          //filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff2D2B4E)),
          ),
        ),
      ),
    ),
  );
}

Widget customPasswordTextField(
  controller,
  label, {
  required Function(dynamic value) validator,
}) {
  dynamic validator;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Form(
      //elevation: 8,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
        obscureText: true,
        validator: validator,
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          label: Text(label),
          hintStyle: TextStyle(color: Color(0xffCECECE)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff2D2B4E)),
          ),
        ),
      ),
    ),
  );
}
