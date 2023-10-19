import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final TextEditingController controller ;
  final String? Function(String?) validator;


   const CustomFormField({
    super.key,
    required this.label,
    this.inputType,
     this.isPassword = false,
     required this.controller,
     required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        hintStyle:const TextStyle(
        color: Colors.black26,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}
