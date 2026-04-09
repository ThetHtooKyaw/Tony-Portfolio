import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/core/utils/app_snackbars.dart';
import 'package:tony_portfolio/src/contact/view_model/contact_view_model.dart';
import 'package:tony_portfolio/src/widgets/responsive_widget.dart';
import 'package:tony_portfolio/src/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  Future<void> _sendEmail(ContactViewModel vm) async {
    await vm.sendEmail();

    if (vm.errorMessage != null) {
      AppSnackbars.showErrorSnackbar(context, vm.errorMessage!);
      vm.setError(null);
    } else {
      AppSnackbars.showSuccessSnackbar(context, vm.successMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isTablet = ResponsiveWidget.isTablet(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: buildAppBar(context: context, screenSize: screenSize),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 0.0 : 100.0,
            horizontal: isDesktop
                ? (screenSize.width * 0.04).clamp(
                    AppFormat.priamaryPadding,
                    80.0,
                  )
                : isTablet
                ? (screenSize.width * 0.1).clamp(40, 150.0)
                : (screenSize.width * 0.08).clamp(
                    AppFormat.priamaryPadding,
                    40.0,
                  ),
          ),
          height: isDesktop ? screenSize.height : null,
          width: double.infinity,
          color: AppColor.background,
          child: isDesktop
              ? _buildDesktopLayout(screenSize)
              : _buildMobileLayout(screenSize),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
      ],
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
    final isDesktop = ResponsiveWidget.isDesktop(context);

    return AutoSizeText(
      text,
      maxFontSize: 34,
      minFontSize: 18,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Oswald',
        color: AppColor.white,
        fontSize: screenSize.width * (isDesktop ? 0.04 : 0.03),
      ),
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
          contactInfo: '+95 924955940',
        ),
      ],
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

  Widget _buildContactForm(Size screenSize) {
    final iconPadding = (screenSize.width * 0.03).clamp(10.0, 20.0);

    return Consumer<ContactViewModel>(
      builder: (context, vm, child) {
        return Form(
          key: vm.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Fields
              _buildTextField(
                controller: vm.nameController,
                label: 'Name',
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  } else if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildTextField(
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

              _buildTextField(
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

              _buildTextField(
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
                  _buildContactIconBtn(
                    screenWidth: screenSize.width,
                    icon: 'assets/icons/linkedin.png',
                    link: 'https://www.linkedin.com/in/tonyjohnsons/',
                  ),
                  SizedBox(width: iconPadding),

                  _buildContactIconBtn(
                    screenWidth: screenSize.width,
                    icon: 'assets/icons/github.png',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    bool isMessageField = false,
    required String? Function(String?)? validator,
  }) {
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

  Widget _buildContactIconBtn({
    required double screenWidth,
    required String icon,
    required String link,
  }) {
    final btnSize = (screenWidth * 0.03).clamp(18.0, 24.0);

    return IconButton(
      onPressed: () async {
        final Uri url = Uri.parse(link);

        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          debugPrint('Could not launch $url');
        }
      },
      style: IconButton.styleFrom(
        padding: EdgeInsets.all((screenWidth * 0.03).clamp(18.0, 24.0)),
        backgroundColor: AppColor.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      // padding: const EdgeInsets.all(20),
      icon: Image.asset(
        icon,
        color: AppColor.white,
        height: btnSize,
        width: btnSize,
      ),
    );
  }
}
