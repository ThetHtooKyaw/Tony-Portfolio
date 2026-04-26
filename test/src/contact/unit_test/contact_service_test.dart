import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tony_portfolio/core/status/failure.dart';
import 'package:tony_portfolio/core/status/success.dart';
import 'package:tony_portfolio/src/contact/repo/contact_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ContactService contactService;
  late MockHttpClient httpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() async {
    await dotenv.load();
    httpClient = MockHttpClient();
    contactService = ContactService(httpClient: httpClient);

    dotenv.env['SERVICE_ID'] = 'test_service';
    dotenv.env['TEMPLATE_ID'] = 'test_template';
    dotenv.env['PUBLIC_KEY'] = 'test_key';
  });

  group('sendEmail', () {
    test('return Success when statusCode is 200', () async {
      // arrange
      when(
        () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Message sent successfully', 200),
      );

      // act
      final result = await contactService.sendEmail(
        name: 'name',
        email: 'email',
        subject: 'subject',
        message: 'message',
      );

      // assert
      expect(result, isA<Success>());
      expect((result as Success).response, 'Message sent successfully');
      verify(
        () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).called(1);
      verifyNoMoreInteractions(httpClient);
    });

    test('return Failure when the statusCode is not 200', () async {
      // arrange
      when(
        () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Failed to send message. Try again.', 400),
      );

      // act
      final result = await contactService.sendEmail(
        name: 'name',
        email: 'email',
        subject: 'subject',
        message: 'message',
      );

      // assert
      expect(result, isA<Failure>());
      expect(
        (result as Failure).response,
        'Failed to send message. Try again.',
      );
      verify(
        () => httpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).called(1);
      verifyNoMoreInteractions(httpClient);
    });
  });
}
