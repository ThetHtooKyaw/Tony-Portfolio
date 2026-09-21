import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/app_snackbars.dart';
import 'package:tony_portfolio/src/contact/view_model/contact_view_model.dart';
import 'package:tony_portfolio/core/utils/responsive_widget.dart';
import 'package:tony_portfolio/src/contact/widgets/contact_icon_button.dart';
import 'package:tony_portfolio/src/contact/widgets/custom_textfiled.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';

class ContactView extends StatefulWidget {
  final bool isTestMode;
  const ContactView({super.key, this.isTestMode = false});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _sendEmail(ContactViewModel vm) async {
    if (!formKey.currentState!.validate()) return;
    await vm.sendEmail();

    if (vm.errorMessage != null) {
      AppSnackbars.showErrorSnackbar(context, vm.errorMessage!);
      vm.setError(null);
    } else {
      AppSnackbars.showSuccessSnackbar(context, vm.successMessage!);
      vm.setSuccess(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isTablet = ResponsiveWidget.isTablet(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: widget.isTestMode
          ? AppBar(title: Text('Test'))
          : buildAppBar(context: context, screenSize: screenSize),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop
              ? (screenSize.width * 0.04).clamp(AppFormat.primaryPadding, 80.0)
              : isTablet
              ? (screenSize.width * 0.1).clamp(40, 150.0)
              : (screenSize.width * 0.08).clamp(AppFormat.primaryPadding, 40.0),
        ),
        height: screenSize.height,
        width: double.infinity,
        color: AppColor.background,
        child: isDesktop
            ? _buildDesktopLayout(screenSize)
            : _buildMobileLayout(screenSize),
      ),
    );
  }

  Widget _buildMobileLayout(Size screenSize) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            // Title Text
            _buildTitleText(screenSize, 'LET\'S WORK'),
            _buildTitleText(screenSize, 'TOGETHER'),
            const SizedBox(height: 40),

            // Sub Title
            _buildSubTitleSection(screenSize),
            const SizedBox(height: 40),

            // Contact Form
            _buildContactForm(screenSize),
            const SizedBox(height: 40),

            // Contact Info
            _buildContactInfo(screenSize),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(Size screenSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Text
              _buildTitleText(screenSize, 'LET\'S'),
              _buildTitleText(screenSize, 'WORK'),
              _buildTitleText(screenSize, 'TOGETHER'),
              const SizedBox(height: 40),

              // Contact Info
              _buildContactInfo(screenSize),
            ],
          ),
        ),
        SizedBox(width: (screenSize.width * 0.03).clamp(20.0, 100.0)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sub Title
              _buildSubTitleSection(screenSize),
              const SizedBox(height: 40),

              // Contact Form
              _buildContactForm(screenSize),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubTitleSection(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubTitleText(
          screenSize: screenSize,
          text: "Let’s discuss the 'what.'",
        ),

        _buildSubTitleText(
          screenSize: screenSize,
          text: "I’ll take care of the 'how'.",
        ),
      ],
    );
  }

  Widget _buildContactInfo(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildContactInfoCard(
          screenWidth: screenSize.width,
          icon: Icons.mail_outline_rounded,
          contactInfo: '2003tonyc123@gmail.com',
        ),
        const SizedBox(height: 10),

        _buildContactInfoCard(
          screenWidth: screenSize.width,
          icon: Icons.phone_outlined,
          contactInfo: '+66 924955940',
        ),
        const SizedBox(height: 10),

        _buildContactInfoCard(
          screenWidth: screenSize.width,
          icon: Icons.phone_outlined,
          contactInfo: '+971 585683997',
        ),
      ],
    );
  }

  Widget _buildContactForm(Size screenSize) {
    final iconPadding = (screenSize.width * 0.03).clamp(10.0, 20.0);

    return Consumer<ContactViewModel>(
      builder: (context, vm, child) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contacter Name Field
              CustomTextfiled(
                controller: vm.nameController,
                label: 'Name',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  } else if (value.length <= 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Email Field
              CustomTextfiled(
                controller: vm.emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Subject Field
              CustomTextfiled(
                controller: vm.subjectController,
                label: 'Job Title',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job title';
                  } else if (value.length < 6) {
                    return 'Job title must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Message Field
              CustomTextfiled(
                controller: vm.messageController,
                label: 'Message',
                keyboardType: TextInputType.text,
                isMessageField: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  } else if (value.length < 6) {
                    return 'Message must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              Row(
                children: [
                  // Submit Button
                  ElevatedButton(
                    onPressed: () => _sendEmail(vm),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.accent,
                      padding: EdgeInsets.all(
                        (screenSize.width * 0.03).clamp(20.0, 30.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: vm.isActionLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColor.white,
                              strokeWidth: 2,
                            ),
                          )
                        : AutoSizeText(
                            'Send Message',
                            maxFontSize: 20,
                            minFontSize: 16,
                            style: TextStyle(
                              fontFamily: 'Questrial',
                              color: AppColor.white,
                              fontSize: screenSize.width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(width: iconPadding),

                  // Contact Icon Buttons
                  ContactIconButton(
                    screenWidth: screenSize.width,
                    icon: 'assets/icons/linkedin.webp',
                    link: 'https://www.linkedin.com/in/tonyjohnsons/',
                  ),
                  SizedBox(width: iconPadding),

                  ContactIconButton(
                    screenWidth: screenSize.width,
                    icon: 'assets/icons/github.webp',
                    link: 'https://github.com/ThetHtooKyaw',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleText(Size screenSize, String text) {
    final isDesktop = ResponsiveWidget.isDesktop(context);

    return AutoSizeText(
      text,
      maxFontSize: isDesktop ? 140 : 100.0,
      minFontSize: 50.0,
      maxLines: 1,
      style: TextStyle(
        fontFamily: 'Racing Sans One',
        color: AppColor.white,
        height: 0.8,
        fontSize: screenSize.width * 0.1,
      ),
    );
  }

  Widget _buildSubTitleText({required Size screenSize, required String text}) {
    final isLargeScreen = ResponsiveWidget.isLargeScreen(context);

    return AutoSizeText(
      text,
      maxFontSize: 34,
      minFontSize: 18,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Oswald',
        color: AppColor.white,
        fontSize: screenSize.width * (isLargeScreen ? 0.04 : 0.038),
      ),
    );
  }

  Widget _buildContactInfoCard({
    required double screenWidth,
    required IconData icon,
    required String contactInfo,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColor.white,
          size: (screenWidth * 0.03).clamp(20, 30),
        ),
        const SizedBox(width: 10),

        AutoSizeText(
          contactInfo,
          maxFontSize: 20,
          minFontSize: 16,
          style: TextStyle(
            fontFamily: 'Questrial',
            color: AppColor.white,
            fontSize: screenWidth * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
