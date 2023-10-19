import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: color,
        ),
      ),
    );
  }
}
