import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/data/skill_info.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';
import 'package:tony_portfolio/core/theme/app_format.dart';
import 'package:tony_portfolio/src/home/widgets/animated_hover_hightlight_card.dart';
import 'package:tony_portfolio/src/home/widgets/animated_hover_skill_card.dart';
import 'package:tony_portfolio/src/home/widgets/responsive_widget.dart';
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
          CurvedAnimation(
            parent: _firstComboController,
            curve: Curves.easeInOut,
          ),
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

    final double firstComboTriggerPoint = screenSize.height * 0.58;

    if (widget.scrollController.offset >= firstComboTriggerPoint) {
      if (_firstComboController.status == AnimationStatus.dismissed ||
          _firstComboController.status == AnimationStatus.reverse) {
        _firstComboController.forward();
      }
    } else {
      _firstComboController.reset();
    }

    final double secondComboTriggerPoint = isDesktop
        ? screenSize.height * 0.76
        : screenSize.height * 0.9;
    final double endTriggerPoint = isDesktop
        ? screenSize.height * 1.8
        : screenSize.height * 2.0;

    if (widget.scrollController.offset >= secondComboTriggerPoint &&
        widget.scrollController.offset <= endTriggerPoint) {
      if (_secondCombonController.status == AnimationStatus.dismissed ||
          _secondCombonController.status == AnimationStatus.reverse) {
        _secondCombonController.forward();
        _counterController.forward();
      }
    } else {
      if (_secondCombonController.status == AnimationStatus.completed ||
          _secondCombonController.status == AnimationStatus.forward) {
        _secondCombonController.reverse();
        _counterController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isDesktop = ResponsiveWidget.isDesktop(context);
    final isSmallMobile = ResponsiveWidget.isSmallMobile(context);

    return Container(
      height: isSmallMobile ? screenSize.height + 20 : screenSize.height,
      width: double.infinity,
      color: AppColor.background,
      child: isDesktop
          ? _buildDesktopIntro(screenSize)
          : _buildMobileIntro(
              screenSize: screenSize,
              isSmallMobile: isSmallMobile,
            ),
    );
  }

  Widget _buildDesktopIntro(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Headline
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: (screenSize.width * 0.03).clamp(30.0, 50.0),
            horizontal: (screenSize.width * 0.03).clamp(
              AppFormat.priamaryPadding,
              120.0,
            ),
          ),
          child: _buildHeadline(screenSize),
        ),

        // Divider
        Container(height: 2, width: 100, color: AppColor.accent),
        const SizedBox(height: 40),

        FadeTransition(
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
                            // My Toolkit Title
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
                    SizedBox(
                      width: (screenSize.width * 0.04).clamp(40.0, 60.0),
                    ),

                    // TODO: Change Hover Animation
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
        ),
      ],
    );
  }

  Widget _buildMobileIntro({
    required Size screenSize,
    required bool isSmallMobile,
  }) {
    final titleFontSize = isSmallMobile
        ? 30.0
        : (screenSize.width * 0.04).clamp(40.0, 60.0);
    final spacing = isSmallMobile ? 20.0 : 30.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppFormat.priamaryPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Headline
          _buildHeadline(screenSize),
          SizedBox(height: spacing),

          // Divider
          Container(height: 2, width: 100, color: AppColor.accent),
          const SizedBox(height: 20),

          // My Toolkit Title
          AnimatedBuilder(
            animation: _titleSlideUpController,
            builder: (context, child) {
              bool startPlay = _titleSlideUpController.value > 0.1;

              if (!startPlay) {
                return SizedBox(height: titleFontSize);
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
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: spacing),

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
          SizedBox(height: spacing),

          // highlights
          FadeTransition(
            opacity: _secondFadeInAnimation,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SlideTransition(
                    position: _slideFromLeftAnimation,
                    child: _buildExperienceCard(),
                  ),
                ),
                SizedBox(width: 20),
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

  Widget _buildHeadline(Size screenSize) {
    final isSmallMobile = ResponsiveWidget.isSmallMobile(context);
    final isMobile = ResponsiveWidget.isMobile(context);
    final isTablet = ResponsiveWidget.isTablet(context);

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
              fontSize: isSmallMobile
                  ? 23
                  : isMobile
                  ? (screenSize.width * 0.04).clamp(23.0, 26.0)
                  : isTablet
                  ? (screenSize.width * 0.04).clamp(26.0, 30.0)
                  : (screenSize.width * 0.036).clamp(30.0, 80.0),
              height: 1.2,
            ),
            children: dynamicSpans,
          ),
        );
      },
    );
  }

  Widget _buildSkillsList() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      alignment: WrapAlignment.center,
      children: skillInfos.map((skill) {
        return AnimatedHoverSkillCard(skill: skill);
      }).toList(),
    );
  }

  Widget _buildExperienceCard() {
    return AnimatedHoverHightlightCard(
      isExpLabel: true,
      animation: _counterAnimation,
    );
  }

  Widget _buildProjectCard() {
    return AnimatedHoverHightlightCard(animation: _counterAnimation);
  }
}
