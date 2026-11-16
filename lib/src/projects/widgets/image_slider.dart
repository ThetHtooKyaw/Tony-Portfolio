import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';

class ImageSlider extends StatefulWidget {
  final List<String> images;

  const ImageSlider({super.key, required this.images});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < widget.images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.animateToPage(
        widget.images.length - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 300),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppFormat.secondaryBorderRadius),
          child: Container(
            color: AppColor.background,
            height: 300,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Image Carousel
                PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      widget.images[index],
                      fit: BoxFit.contain,
                      width: double.infinity,
                    );
                  },
                ),

                // Subtle bottom gradient for dot visibility
                IgnorePointer(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.75),
                        ],
                      ),
                    ),
                  ),
                ),

                // Left Arrow Button
                if (widget.images.length > 1)
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _buildArrowButton(
                        icon: Icons.chevron_left,
                        onPressed: _previousPage,
                      ),
                    ),
                  ),

                // Right Arrow Button
                if (widget.images.length > 1)
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _buildArrowButton(
                        icon: Icons.chevron_right,
                        onPressed: _nextPage,
                      ),
                    ),
                  ),

                // Progress Bubble Dots Overlay
                if (widget.images.length > 1)
                  Positioned(
                    bottom: 10,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(widget.images.length, (index) {
                        final bool isActive = _currentIndex == index;
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: isActive ? 22 : 10,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColor.accent
                                  : AppColor.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(AppFormat.secondaryPadding),
          child: Icon(icon, color: AppColor.white, size: 24),
        ),
      ),
    );
  }
}
