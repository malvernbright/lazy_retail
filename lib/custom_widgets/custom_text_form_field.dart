import 'package:flutter/material.dart';

Widget buildTextFormField(
    {required String hintText,
    bool obscureText = false,
    required TextEditingController controller,
    required Color borderHintFocusTextColor,
    required Color fillColor,
    TextInputType keyboardType = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      keyboardType: keyboardType,
      autofocus: true,
      textAlign: TextAlign.center,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return '$hintText is required';
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: borderHintFocusTextColor,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderHintFocusTextColor,
          ),
        ),
        focusColor: borderHintFocusTextColor,
        hintStyle: TextStyle(
          color: borderHintFocusTextColor,
        ),
        hintText: hintText,
      ),
    ),
  );
}
