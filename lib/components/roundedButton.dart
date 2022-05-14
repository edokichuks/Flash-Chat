import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color colour;
  final on_pressed;
  final String text;
  final Function? validator;

  const RoundedButton({
    required this.colour,
    required this.text,
    required this.on_pressed,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: on_pressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
