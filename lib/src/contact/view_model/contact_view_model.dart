import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/status/failure.dart';
import 'package:tony_portfolio/core/status/success.dart';
import 'package:tony_portfolio/core/utils/base_view_model.dart';
import 'package:tony_portfolio/src/contact/repo/contact_service.dart';

class ContactViewModel extends BaseViewModel {
  final ContactService _contactService = ContactService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> sendEmail() async {
    if (!formKey.currentState!.validate()) return;

    setActionLoading(true);
    setError(null);

    final response = await _contactService.sendEmail(
      name: nameController.text,
      email: emailController.text,
      subject: subjectController.text,
      message: messageController.text,
    );

    if (response is Success) {
      setSuccess(response.response.toString());
      clearForm();
    } else if (response is Failure) {
      setError(response.response.toString());
    }

    setActionLoading(false);
  }

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
}
