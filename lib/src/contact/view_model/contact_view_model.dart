import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/status/failure.dart';
import 'package:tony_portfolio/core/status/success.dart';
import 'package:tony_portfolio/core/utils/base_view_model.dart';
import 'package:tony_portfolio/src/contact/repo/contact_service.dart';

class ContactViewModel extends BaseViewModel {
  // Dependencies
  final ContactService contactService;
  ContactViewModel({required this.contactService});

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  // Use Cases
  void clearForm() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> sendEmail() async {
    startScreenLoading(true);

    final response = await contactService.sendEmail(
      name: nameController.text,
      email: emailController.text.toLowerCase(),
      subject: subjectController.text,
      message: messageController.text,
    );

    if (response is Failure) {
      stopActionLoadingWithErrorMessage(response.response.toString());
      clearForm();
      return;
    }

    stopActionLoadingWithSuccessMessage(
      (response as Success).response.toString(),
    );
    clearForm();
  }
}
