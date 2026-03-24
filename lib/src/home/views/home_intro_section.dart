import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/animated_hover_hightlight_card.dart';
import 'package:tony_portfolio/src/home/widgets/animated_hover_skill_card.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class HomeIntroSection extends StatefulWidget {
  final ScrollController scrollController;
  const HomeIntroSection({super.key, required this.scrollController});

  @override
  State<HomeIntroSection> createState() => _HomeIntroSectionState();
}

class _HomeIntroSectionState extends State<HomeIntroSection>
    with TickerProviderStateMixin {
  late AnimationController _titleSlideUpController;
  late AnimationController _firstComboController;
  late AnimationController _secondCombonController;
  late AnimationController _counterController;

  late Animation<double> _firstFadeInAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _secondFadeInAnimation;
  late Animation<Offset> _slideFromLeftAnimation;
  late Animation<Offset> _slideFromRightAnimation;
  late Animation<double> _counterAnimation;

  final skills = [
    {'text': 'Flutter', 'icon': 'assets/icons/flutter.png'},
    {'text': 'Dart', 'icon': 'assets/icons/dart.png'},
    {'text': 'Python', 'icon': 'assets/icons/python.png'},
    {'text': 'Java', 'icon': 'assets/icons/java.png'},
    {'text': 'Kotlin', 'icon': 'assets/icons/kotlin.png'},
    {'text': 'HTML', 'icon': 'assets/icons/html.png'},
    {'text': 'CSS', 'icon': 'assets/icons/css.png'},
    {'text': 'JavaScript', 'icon': 'assets/icons/javascript.png'},
    {'text': 'Firebase', 'icon': 'assets/icons/firebase.png'},
    {'text': 'WordPress', 'icon': 'assets/icons/wordpress.png'},
    {'text': 'Github', 'icon': 'assets/icons/github.png'},
    {'text': 'Git', 'icon': 'assets/icons/git.png'},
    {'text': 'Figma', 'icon': 'assets/icons/figma.png'},
  ];

  @override
  void initState() {
    super.initState();

    _titleSlideUpController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _firstComboController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _secondCombonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _counterController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _firstFadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _firstComboController, curve: Curves.easeInOut),
    );

    _slideUpAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _firstComboController, curve: Curves.easeIn),
        );

    _secondFadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _secondCombonController, curve: Curves.easeInOut),
    );

    _slideFromLeftAnimation =
        Tween<Offset>(begin: const Offset(-0.2, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _secondCombonController,
            curve: Curves.easeInOut,
          ),
        );

    _slideFromRightAnimation =
        Tween<Offset>(begin: const Offset(0.2, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _secondCombonController,
            curve: Curves.easeInOut,
          ),
        );

    _counterAnimation = CurvedAnimation(
      parent: _counterController,
      curve: Curves.easeInOut,
    );

    widget.scrollController.addListener(_animationListener);
  }

  @override
  void dispose() {
    super.dispose();
    _titleSlideUpController.dispose();
    _firstComboController.dispose();
    _secondCombonController.dispose();
    _counterController.dispose();
    widget.scrollController.removeListener(_animationListener);
  }

  void _animationListener() {
    if (!mounted || !widget.scrollController.hasClients) return;

    final Size screenSize = MediaQuery.sizeOf(context);
    bool isDesktop = screenSize.width > 800;

    if (widget.scrollController.offset >= screenSize.height * 0.43) {
      if (_titleSlideUpController.status == AnimationStatus.dismissed ||
          _titleSlideUpController.status == AnimationStatus.reverse) {
        _titleSlideUpController.forward();
      }
    } else {
      _titleSlideUpController.reset();
    }

    final double firstFadeInTriggerPoint = screenSize.height * 0.53;

    if (widget.scrollController.offset >= firstFadeInTriggerPoint) {
      if (_firstComboController.status == AnimationStatus.dismissed ||
          _firstComboController.status == AnimationStatus.reverse) {
        _firstComboController.forward();
      }
    } else {
      _firstComboController.reset();
    }

    final double secondFadeInTriggerPoint = isDesktop
        ? screenSize.height * 0.7
        : screenSize.height * 0.9;
    final double endTriggerPoint = screenSize.height * 1.8;

    if (widget.scrollController.offset >= secondFadeInTriggerPoint &&
        widget.scrollController.offset <= endTriggerPoint) {
      if (_secondCombonController.status == AnimationStatus.dismissed ||
          _secondCombonController.status == AnimationStatus.reverse) {
        _secondCombonController.forward();
      }
    } else {
      if (_secondCombonController.status == AnimationStatus.completed ||
          _secondCombonController.status == AnimationStatus.forward) {
        _secondCombonController.reverse();
      }
    }

    final double counterTriggerPoint = isDesktop
        ? screenSize.height * 0.75
        : screenSize.height * 0.8;

    if (widget.scrollController.offset >= counterTriggerPoint) {
      if (_counterController.status == AnimationStatus.dismissed ||
          _counterController.status == AnimationStatus.reverse) {
        _counterController.forward();
      }
    } else {
      if (_counterController.status == AnimationStatus.completed ||
          _counterController.status == AnimationStatus.forward) {
        _counterController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final bool isDesktop = screenSize.width > 650;

    final horizontalPadding = isDesktop
        ? (screenSize.width * 0.08).clamp(40.0, 120.0)
        : AppFormat.priamaryPadding;

    return Container(
      height: screenSize.height,
      width: double.infinity,
      color: AppColor.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Headline
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isDesktop
                  ? (screenSize.width * 0.06).clamp(30.0, 50.0)
                  : 30,
              horizontal: horizontalPadding,
            ),
            child: _buildHeadline(screenSize),
          ),

          // Divider
          Container(height: 2, width: 100, color: AppColor.accent),
          const SizedBox(height: 20),

          // Lower Intro Part
          if (screenSize.width > 800) ...[
            const SizedBox(height: 30),
            _buildDesktopIntro(screenSize),
          ] else
            _buildMobileIntro(screenSize, horizontalPadding),
        ],
      ),
    );
  }

  Widget _buildHeadline(Size screenSize) {
    return AnimatedBuilder(
      animation: widget.scrollController,
      builder: (context, child) {
        final double startColorOffset = screenSize.height * 0.36;
        final double endColorOffset = screenSize.height * 0.74;
        double scrollPercent = 0.0;

        if (widget.scrollController.hasClients) {
          double currentOffset = widget.scrollController.offset;
          scrollPercent =
              ((currentOffset - startColorOffset) /
                      (endColorOffset - startColorOffset))
                  .clamp(0.0, 1.0);
        }

        const String firstPart =
            "\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0I’m a versatile mobile developer with";
        const String accentPart =
            " solid foundation in software architecture and hands-on experience in full-cycle app development. I turn ";
        const String lastPart =
            " concepts into reality with a focus on clean interfaces, and fast delivery.";

        const String fullString = firstPart + accentPart + lastPart;
        final int litLetters = (fullString.length * scrollPercent).toInt();

        int currentIndex = 0;
        List<TextSpan> dynamicSpans = [];

        void processSegment(String text, Color color) {
          for (int i = 0; i < text.length; i++) {
            bool isLit = currentIndex < litLetters;
            Color finalColor = isLit ? color : AppColor.disable;

            dynamicSpans.add(
              TextSpan(
                text: text[i],
                style: TextStyle(color: finalColor),
              ),
            );

            currentIndex++;
          }
        }

        processSegment(firstPart, AppColor.white);
        processSegment(accentPart, AppColor.accent);
        processSegment(lastPart, AppColor.white);

        return RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Oswald',
              color: AppColor.white,
              fontSize: (screenSize.width * 0.03).clamp(27.0, 100.0),
              height: 1.2,
            ),
            children: dynamicSpans,
          ),
        );
      },
    );
  }

  Widget _buildDesktopIntro(Size screenSize) {
    return FadeTransition(
      opacity: _secondFadeInAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SlideTransition(
                    position: _slideFromLeftAnimation,
                    child: Column(
                      children: [
                        // Title
                        Text(
                          'My Toolkit',
                          style: TextStyle(
                            fontFamily: 'Racing Sans One',
                            color: AppColor.white,
                            fontSize: (screenSize.width * 0.04).clamp(
                              40.0,
                              60.0,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Skills List
                        _buildSkillsList(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: (screenSize.width * 0.04).clamp(40.0, 60.0)),

                // Highlights
                Expanded(
                  flex: 1,
                  child: SlideTransition(
                    position: _slideFromRightAnimation,
                    child: Column(
                      children: [
                        _buildExperienceCard(),
                        const SizedBox(height: 20),

                        _buildProjectCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileIntro(Size screenSize, double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          // Title
          AnimatedBuilder(
            animation: _titleSlideUpController,
            builder: (context, child) {
              bool startPlay = _titleSlideUpController.value > 0.1;

              if (!startPlay) {
                return SizedBox(
                  height: (screenSize.width * 0.04).clamp(40.0, 60.0),
                );
              }

              return ClipRect(
                child: TextAnimator(
                  key: ValueKey(startPlay),
                  'My Toolkit',
                  incomingEffect:
                      WidgetTransitionEffects.incomingSlideInFromBottom(
                        curve: Curves.easeOutCubic,
                        duration: const Duration(milliseconds: 400),
                      ),
                  style: TextStyle(
                    fontFamily: 'Racing Sans One',
                    color: AppColor.white,
                    fontSize: (screenSize.width * 0.04).clamp(40.0, 60.0),
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),

          // Skills List
          FadeTransition(
            opacity: _firstFadeInAnimation,
            child: ClipRect(
              child: SlideTransition(
                position: _slideUpAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _buildSkillsList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // highlights
          FadeTransition(
            opacity: _secondFadeInAnimation,
            child: Row(
              children: [
                Expanded(
                  child: SlideTransition(
                    position: _slideFromLeftAnimation,
                    child: _buildExperienceCard(),
                  ),
                ),
                const SizedBox(width: 20),

                Expanded(
                  child: SlideTransition(
                    position: _slideFromRightAnimation,
                    child: _buildProjectCard(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      alignment: WrapAlignment.center,
      children: skills.map((skill) {
        return AnimatedHoverSkillCard(skill: skill);
      }).toList(),
    );
  }

  Widget _buildExperienceCard() {
    return AnimatedHoverHightlightCard(
      targetNumber: 3,
      title: 'YEARS OF EXPERIENCE',
      desc: "Specializing in Flutter & Firebase",
      icon: 'assets/icons/code.png',
      animation: _counterAnimation,
    );
  }

  Widget _buildProjectCard() {
    return AnimatedHoverHightlightCard(
      targetNumber: 20,
      title: 'PROJECTS COMPLETED',
      desc: "From Concept to Production-Ready Apps",
      icon: 'assets/icons/project.png',
      animation: _counterAnimation,
    );
  }
}
