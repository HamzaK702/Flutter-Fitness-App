import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableImageWithLink extends StatelessWidget {
  final String imageUrl;
  final String linkUrl;
  const ClickableImageWithLink({
    required this.imageUrl,
    required this.linkUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () async {
            if (await canLaunch(linkUrl)) {
              await launch(linkUrl);
            } else {
              print('Could not launch $linkUrl');
            }
          },
          child: SizedBox(
            height: 180,
            width: 230,
            child: buildCardioSections(context, imageUrl),
          ),
        ),
      ),
    );
  }



    Widget buildCardioSections(BuildContext context, String image) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [
            SizedBox(height: 130),
            Container(
          padding: const EdgeInsets.only(left: 5),
          color: Colors.grey[900],
          child: Row(
            mainAxisSize: MainAxisSize.min, // Use min to wrap content
            children: [
              Icon(Icons.play_arrow, color: Colors.white), // Play icon
              Text(" WATCH ON YOUTUBE ", style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
              )
              ),
           ],
            ),
            
            ),
          
          ],
        ),
      ),
    ),
  );
}
}
