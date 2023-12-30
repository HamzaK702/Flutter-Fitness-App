import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  final Function() onTap;

  CustomCard({
    required this.color,
     required  this.textcolor,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 75,
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textcolor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
