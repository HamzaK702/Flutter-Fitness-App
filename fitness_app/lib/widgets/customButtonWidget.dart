import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color primaryColor;
  final Color onPrimaryColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final double width;
  final double height;

  CustomElevatedButton({
    required this.buttonText,
    required this.onPressed,
    this.primaryColor = const Color(0xFFF2FF00), // Yellow color
    this.onPrimaryColor = Colors.white, // Text color on the button
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.textColor = Colors.black,
    this.width = 200,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        buttonText,
        style: GoogleFonts.notoSans(
          textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: textColor),
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        minimumSize: Size(width, height),
      ),
    );
  }
}