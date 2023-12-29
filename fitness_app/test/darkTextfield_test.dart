import 'package:fitness_app/widgets/darkTextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('DarkTextField UI Test', (WidgetTester tester) async {
     
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DarkTextField(
          label: 'Test Label',
          controller: TextEditingController(),
        ),
      ),
    ));

     
    expect(find.text('Test Label'), findsOneWidget); // Check for the label text
    expect(find.byType(TextFormField), findsOneWidget); // Check for TextFormField widget
    expect(find.byType(DarkTextField), findsOneWidget); // Check for DarkTextField widget

     
    await tester.enterText(find.byType(TextFormField), 'Test Input');

    
  });
}
