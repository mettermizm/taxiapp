import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTextFormField extends StatelessWidget {

  static Widget textFormField(TextEditingController controller, String text,
      {TextInputType? inputType, bool? obsure, String? Function(String?)? validator,}) {
    return MyTextFormField(
      type: inputType ?? TextInputType.text,
      controller: controller,
      text: text,
      obscure: obsure ?? false,
    );
  }

  final TextEditingController controller;
  final String text;
  final TextInputType? type;
  final bool? obscure;
  final String? Function(String?)? validator;

  MyTextFormField(
      {required this.controller,
      required this.text,
      required this.type,
      this.validator,
      this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(FontAwesomeIcons.genderless),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow, width: 5),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      obscureText: obscure ?? false,
      keyboardType: type ?? TextInputType.text,
      validator: validator,
    );
  }
}


