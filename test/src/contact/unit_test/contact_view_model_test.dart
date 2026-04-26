import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tony_portfolio/core/status/failure.dart';
import 'package:tony_portfolio/core/status/success.dart';
import 'package:tony_portfolio/src/contact/repo/contact_service.dart';
import 'package:tony_portfolio/src/contact/view_model/contact_view_model.dart';

class MockContactService extends Mock implements ContactService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockContactService contactService;
  late ContactViewModel viewModel;

  setUp(() {
    contactService = MockContactService();
    viewModel = ContactViewModel(contactService: contactService);
  });

  group('sendEmail', () {
    test('Should call sendEmail and return success', () async {
      // arrange
      when(
        () => contactService.sendEmail(
          name: any(named: 'name'),
          email: any(named: 'email'),
          subject: any(named: 'subject'),
          message: any(named: 'message'),
        ),
      ).thenAnswer((_) async => Success(response: 'ok'));

      viewModel.nameController.text = 'name';
      viewModel.emailController.text = 'email';
      viewModel.subjectController.text = 'subject';
      viewModel.messageController.text = 'message';

      // act
      await viewModel.sendEmail();

      // assert
      expect(viewModel.isActionLoading, false);
      expect(viewModel.errorMessage, null);
      expect(viewModel.successMessage, 'ok');
      expect(viewModel.nameController.text, '');
      expect(viewModel.emailController.text, '');
      expect(viewModel.subjectController.text, '');
      expect(viewModel.messageController.text, '');

      verify(
        () => contactService.sendEmail(
          name: 'name',
          email: 'email',
          subject: 'subject',
          message: 'message',
        ),
      ).called(1);
      verifyNoMoreInteractions(contactService);
    });

    test('Should call sendEmail and return failure', () async {
      // arrange
      when(
        () => contactService.sendEmail(
          name: any(named: 'name'),
          email: any(named: 'email'),
          subject: any(named: 'subject'),
          message: any(named: 'message'),
        ),
      ).thenAnswer((_) async => Failure(response: 'error'));

      viewModel.nameController.text = 'name';
      viewModel.emailController.text = 'email';
      viewModel.subjectController.text = 'subject';
      viewModel.messageController.text = 'message';

      // act
      await viewModel.sendEmail();

      // assert
      expect(viewModel.isActionLoading, false);
      expect(viewModel.errorMessage, 'error');
      expect(viewModel.successMessage, null);
      expect(viewModel.nameController.text, '');
      expect(viewModel.emailController.text, '');
      expect(viewModel.subjectController.text, '');
      expect(viewModel.messageController.text, '');

      verify(
        () => contactService.sendEmail(
          name: 'name',
          email: 'email',
          subject: 'subject',
          message: 'message',
        ),
      ).called(1);
      verifyNoMoreInteractions(contactService);
    });
  });
}
