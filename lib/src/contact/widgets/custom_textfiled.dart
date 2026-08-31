import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';

class CustomTextfiled extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool isMessageField;
  final String? Function(String?)? validator;
  const CustomTextfiled({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    this.isMessageField = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        minLines: 1,
        maxLines: isMessageField ? 4 : 1,
        style: TextStyle(color: AppColor.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColor.placeholder),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.placeholder),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.white),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
