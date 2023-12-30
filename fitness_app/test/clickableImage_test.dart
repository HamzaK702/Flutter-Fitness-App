import 'package:fitness_app/widgets/clickableImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('ClickableImageWithLink UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ClickableImageWithLink(
          imageUrl: 'assets/Chest.png', // Replace with your image path
          linkUrl: 'https://picsum.photos/250?image=9', // Replace with your link URL
        ),
      ),
    ));

    // Check for the presence of GestureDetector widget.
    expect(find.byType(GestureDetector), findsOneWidget);

    // Check for the presence of ClickableImageWithLink widget.
    expect(find.byType(ClickableImageWithLink), findsOneWidget);

    // Tap the image.
    await tester.tap(find.byType(GestureDetector));

    // Trigger a frame to rebuild the widget after the tap.
    await tester.pump();

    // Add any additional assertions or tests you need here.
  });
}
