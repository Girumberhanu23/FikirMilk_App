import 'package:flutter/material.dart';

import '../../const.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;

  final String text;
  const Button({super.key, required this.onPressed, required this.text});

  double getRelativeWidth(BuildContext context, double fraction) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * fraction;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50, bottom: 30),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: btn_color,
              padding: EdgeInsets.symmetric(
                horizontal: 215,
                vertical: 20,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
