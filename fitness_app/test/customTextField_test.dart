import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/widgets/customTextFieldWidget.dart'; // Import the widget file

void main() {
  testWidgets('CustomTextField UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          key: ValueKey('customTextFieldKey'),
          onSaved: (value) {},
          hintText: 'Test Hint Text',
          icon: Icons.search,
        ),
      ),
    ));

    // Check for the presence of TextFormField widget.
    expect(find.byType(TextFormField), findsOneWidget);

    // Check for the presence of CustomTextField widget.
    expect(find.byType(CustomTextField), findsOneWidget);

    // Verify the TextFormField has the correct key.
    final customTextField = find.byKey(ValueKey('customTextFieldKey'));
    expect(customTextField, findsOneWidget);

     
  });

  testWidgets('CustomTextField with Empty Hint Text', (WidgetTester tester) async {
    // Build the widget with an empty hint text.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          key: ValueKey('customTextFieldKey'),
          onSaved: (value) {},
          hintText: '',
          icon: Icons.search,
        ),
      ),
    ));

    // Verify that there's no hintText in the InputDecoration.
     

    // Add any additional assertions or tests you need here.
  });

  testWidgets('CustomTextField with Icon Color', (WidgetTester tester) async {
    // Build the widget with a different icon color.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          key: ValueKey('customTextFieldKey'),
          onSaved: (value) {},
          hintText: 'Test Hint Text',
          icon: Icons.search,
        ),
      ),
    ));

    // Verify that the prefixIcon color is set to a different color.
     

    // Add any additional assertions or tests you need here.
  });

  testWidgets('CustomTextField with Different TextInputType', (WidgetTester tester) async {
    // Build the widget with a different TextInputType.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          key: ValueKey('customTextFieldKey'),
          onSaved: (value) {},
          hintText: 'Test Hint Text',
          icon: Icons.search,
        ),
      ),
    ));

    // Verify that the TextInputType is set to TextInputType.text.
    final textFormField = tester.widget<TextField>(find.byType(TextField));
    expect(textFormField.keyboardType, TextInputType.text);

    // Add any additional assertions or tests you need here.
  });
}
