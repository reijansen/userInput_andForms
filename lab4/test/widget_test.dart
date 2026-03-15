import 'package:flutter_test/flutter_test.dart';
import 'package:lab4/main.dart';

void main() {
  testWidgets('App renders main form elements', (WidgetTester tester) async {
    await tester.pumpWidget(const UserInputFormsApp());

    expect(find.text('User Input and Forms'), findsOneWidget);
    expect(find.text('Personal Information'), findsOneWidget);
    expect(find.text('Generate ID'), findsOneWidget);
  });
}
