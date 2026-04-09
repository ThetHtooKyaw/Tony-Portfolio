import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tony_portfolio/core/status/failure.dart';
import 'package:tony_portfolio/core/status/success.dart';

class ContactService {
  Future<Object> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final String serviceId = dotenv.env['SERVICE_ID'] ?? '';
    final String templateId = dotenv.env['TEMPLATE_ID'] ?? '';
    final String publicKey = dotenv.env['PUBLIC_KEY'] ?? '';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Origin': 'http://localhost',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'sender_name': name,
            'sender_email': email,
            'job_title': subject,
            'message': message,
          },
        }),
      );

      if (response.statusCode == 200) {
        return Success(response: 'Message sent successfully');
      } else {
        return Failure(response: 'Failed to send message. Try again.');
      }
    } catch (e) {
      return Failure(response: 'An error occurred while sending the message');
    }
  }
}
