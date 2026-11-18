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
  final PageController _pageController = PageController(viewportFraction: 1.05);
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.asset(
                        widget.images[index],
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
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
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
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
}
