import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tony_portfolio/core/status/failure.dart';
import 'package:tony_portfolio/core/status/success.dart';
import 'package:tony_portfolio/src/contact/view_model/contact_view_model.dart';
import 'package:tony_portfolio/src/contact/views/contact_view.dart';

import '../unit_test/contact_view_model_test.dart';

void main() {
  final mockContactService = MockContactService();

  final nameField = find.byWidgetPredicate(
    (w) =>
        w is InputDecorator &&
        w.decoration.labelText?.toLowerCase().contains('name') == true,
  );
  final emailField = find.byWidgetPredicate(
    (w) =>
        w is InputDecorator &&
        w.decoration.labelText?.toLowerCase().contains('email') == true,
  );
  final subjectField = find.byWidgetPredicate(
    (w) =>
        w is InputDecorator &&
        w.decoration.labelText?.toLowerCase().contains('job title') == true,
  );
  final messageField = find.byWidgetPredicate(
    (w) =>
        w is InputDecorator &&
        w.decoration.labelText?.toLowerCase().contains('message') == true,
  );

  testWidgets('Check formFields', (tester) async {
    // act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => ContactViewModel(contactService: MockContactService()),
          child: ContactView(isTestMode: true),
        ),
      ),
    );

    // assert
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Send Message'), findsOneWidget);
  });

  testWidgets('Check empty formFields form validation ', (tester) async {
    // act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) =>
              ContactViewModel(contactService: MockContactService()),
          child: ContactView(isTestMode: true),
        ),
      ),
    );

    await tester.ensureVisible(find.text('Send Message'));
    await tester.tap(find.text('Send Message'));
    await tester.pump();

    // assert
    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter the job title'), findsOneWidget);
    expect(find.text('Please enter your message'), findsOneWidget);
  });

  testWidgets('Check incorrect formFields form validation', (tester) async {
    // act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => ContactViewModel(contactService: MockContactService()),
          child: ContactView(isTestMode: true),
        ),
      ),
    );

    await tester.enterText(nameField, 'A');
    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(subjectField, 'Test');
    await tester.enterText(messageField, 'Hi');

    await tester.ensureVisible(find.text('Send Message'));
    await tester.tap(find.text('Send Message'));
    await tester.pump();

    // assert
    expect(find.text('Name must be at least 3 characters'), findsOneWidget);
    expect(find.text('Please enter a valid email address'), findsOneWidget);
    expect(
      find.text('Job title must be at least 6 characters'),
      findsOneWidget,
    );
    expect(find.text('Message must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Check successful formFields submission', (tester) async {
    // arrange

    when(
      () => mockContactService.sendEmail(
        name: any(named: 'name'),
        email: any(named: 'email'),
        subject: any(named: 'subject'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async => Success(response: 'Message sent Successfully!'));

    // act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => ContactViewModel(contactService: mockContactService),
          child: ContactView(isTestMode: true),
        ),
      ),
    );

    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'johndoe@gmail.com');
    await tester.enterText(subjectField, 'Offering a job');
    await tester.enterText(
      messageField,
      'Hi, I would like to offer you a job.',
    );

    await tester.ensureVisible(find.text('Send Message'));
    await tester.tap(find.text('Send Message'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // assert
    expect(find.text('Please enter your name'), findsNothing);
    expect(find.text('Please enter your email'), findsNothing);
    expect(find.text('Please enter the job title'), findsNothing);
    expect(find.text('Please enter your message'), findsNothing);
    expect(find.text('Name must be at least 3 characters'), findsNothing);
    expect(find.text('Please enter a valid email address'), findsNothing);
    expect(find.text('Job title must be at least 6 characters'), findsNothing);
    expect(find.text('Message must be at least 6 characters'), findsNothing);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Message sent Successfully!'), findsOneWidget);
  });

  testWidgets('Check formFields submission failure ', (tester) async {
    // arrange
    when(
      () => mockContactService.sendEmail(
        name: any(named: 'name'),
        email: any(named: 'email'),
        subject: any(named: 'subject'),
        message: any(named: 'message'),
      ),
    ).thenAnswer(
      (_) async => Failure(response: 'Failed to send message. Try again.'),
    );

    // act
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => ContactViewModel(contactService: mockContactService),
          child: ContactView(isTestMode: true),
        ),
      ),
    );

    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'johndoe@gmail.com');
    await tester.enterText(subjectField, 'Offering a job');
    await tester.enterText(
      messageField,
      'Hi, I would like to offer you a job.',
    );

    await tester.ensureVisible(find.text('Send Message'));
    await tester.tap(find.text('Send Message'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // assert
    expect(find.text('Please enter your name'), findsNothing);
    expect(find.text('Please enter your email'), findsNothing);
    expect(find.text('Please enter the job title'), findsNothing);
    expect(find.text('Please enter your message'), findsNothing);
    expect(find.text('Name must be at least 3 characters'), findsNothing);
    expect(find.text('Please enter a valid email address'), findsNothing);
    expect(find.text('Job title must be at least 6 characters'), findsNothing);
    expect(find.text('Message must be at least 6 characters'), findsNothing);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Failed to send message. Try again.'), findsOneWidget);
  });
}
