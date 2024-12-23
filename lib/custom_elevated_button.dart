import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.text, required this.onTapFunction, this.shape});
  final String text;
  final void Function()? onTapFunction;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTapFunction,
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 189, 240, 131),
          foregroundColor: const Color.fromARGB(255, 7, 77, 9),
          padding: EdgeInsets.symmetric(horizontal: 35),
          side: BorderSide(
            width: 1.5,
            color: const Color.fromARGB(255, 7, 77, 9),
          ),
          shape: shape),
      child: Text(text),
    );
  }
}
