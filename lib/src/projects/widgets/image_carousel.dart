import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_format.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;

  const ImageCarousel({super.key, required this.images});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, bool> _imageOrientations = {};
  Timer? _snapTimer;
  bool _isUserDragging = false;

  @override
  void initState() {
    super.initState();
    _precacheOrientations();
  }

  @override
  void dispose() {
    _snapTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _precacheOrientations() {
    for (final path in widget.images) {
      final ImageStream stream = AssetImage(
        path,
      ).resolve(ImageConfiguration.empty);
      stream.addListener(
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
          if (mounted) {
            final isHoriz = info.image.width > info.image.height;
            if (_imageOrientations[path] != isHoriz) {
              setState(() {
                _imageOrientations[path] = isHoriz;
              });
            }
          }
        }),
      );
    }
  }

  /// Computes exact scroll offsets for the start of every image item
  List<double> _calculateItemOffsets(
    double verticalWidth,
    double horizontalWidth,
    double spacing,
  ) {
    final List<double> offsets = [];
    double currentOffset = 0.0;

    for (final path in widget.images) {
      offsets.add(currentOffset);
      final bool isHorizontal = _imageOrientations[path] ?? false;
      final double itemWidth = isHorizontal ? horizontalWidth : verticalWidth;
      currentOffset += itemWidth + spacing;
    }

    return offsets;
  }

  /// Finds the nearest item index for the current scroll offset
  int _getNearestIndex(double currentOffset, List<double> offsets) {
    if (offsets.isEmpty) return 0;
    int closestIndex = 0;
    double minDistance = (currentOffset - offsets[0]).abs();

    for (int i = 1; i < offsets.length; i++) {
      final double distance = (currentOffset - offsets[i]).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }
    return closestIndex;
  }

  /// Snaps to the nearest image boundary after user finishes dragging
  void _scheduleSnap(
    double verticalWidth,
    double horizontalWidth,
    double spacing,
  ) {
    _snapTimer?.cancel();
    _snapTimer = Timer(const Duration(milliseconds: 120), () {
      if (!mounted || !_scrollController.hasClients || _isUserDragging) return;

      final List<double> offsets = _calculateItemOffsets(
        verticalWidth,
        horizontalWidth,
        spacing,
      );
      if (offsets.isEmpty) return;

      final double currentOffset = _scrollController.offset;
      final double maxExtent = _scrollController.position.maxScrollExtent;
      final int nearestIndex = _getNearestIndex(currentOffset, offsets);
      final double targetOffset = offsets[nearestIndex].clamp(0.0, maxExtent);

      // Snap if we are off by more than 1 pixel
      if ((currentOffset - targetOffset).abs() > 1.0) {
        _scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void _scroll(
    bool forward,
    double verticalWidth,
    double horizontalWidth,
    double spacing,
  ) {
    _snapTimer?.cancel();
    if (!_scrollController.hasClients) return;

    final List<double> offsets = _calculateItemOffsets(
      verticalWidth,
      horizontalWidth,
      spacing,
    );
    if (offsets.isEmpty) return;

    final int currentIndex = _getNearestIndex(
      _scrollController.offset,
      offsets,
    );
    final int targetIndex = (forward ? currentIndex + 1 : currentIndex - 1)
        .clamp(0, offsets.length - 1);

    final double targetPosition = offsets[targetIndex].clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      targetPosition,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    const double commonHeight = 420.0;
    const double fixedVerticalWidth = 235.0; // Fixed portrait frame width
    const double maxHorizontalWidth = 850.0; // Fixed landscape frame max width
    const double spacing = 20.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        // 1. Calculate how many full fixed-width vertical images fit
        final int visibleVerticalCount =
            ((maxWidth + spacing) / (fixedVerticalWidth + spacing))
                .floor()
                .clamp(1, widget.images.length);

        // 2. If only 1 vertical image fits and screen is narrower than fixedVerticalWidth,
        // scale the image width down to fit the screen cleanly.
        final double effectiveVerticalWidth =
            (visibleVerticalCount == 1 && maxWidth < fixedVerticalWidth)
            ? maxWidth
            : fixedVerticalWidth;

        final double effectiveHorizontalWidth = maxWidth < maxHorizontalWidth
            ? maxWidth
            : maxHorizontalWidth;

        // 3. Calculate the exact width needed for the whole vertical images (no half-images)
        final bool firstIsHorizontal =
            widget.images.isNotEmpty &&
            (_imageOrientations[widget.images.first] ?? false);

        final double viewportWidth = firstIsHorizontal
            ? effectiveHorizontalWidth
            : (visibleVerticalCount * effectiveVerticalWidth) +
                  ((visibleVerticalCount - 1) * spacing);

        return Stack(
          alignment: Alignment.center,
          children: [
            // Horizontal Image List
            // Horizontal Image List with Reliable Drag & Wheel Snap
            Center(
              child: SizedBox(
                width: viewportWidth,
                height: commonHeight,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollStartNotification) {
                      _isUserDragging = notification.dragDetails != null;
                      _snapTimer?.cancel();
                    } else if (notification is ScrollUpdateNotification) {
                      _isUserDragging = notification.dragDetails != null;
                      if (!_isUserDragging) {
                        _scheduleSnap(
                          effectiveVerticalWidth,
                          effectiveHorizontalWidth,
                          spacing,
                        );
                      }
                    } else if (notification is ScrollEndNotification) {
                      _isUserDragging = false;
                      _scheduleSnap(
                        effectiveVerticalWidth,
                        effectiveHorizontalWidth,
                        spacing,
                      );
                    }
                    return false;
                  },
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      },
                    ),
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.images.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: spacing),
                      itemBuilder: (context, index) {
                        final imagePath = widget.images[index];
                        final bool isHorizontal =
                            _imageOrientations[imagePath] ?? false;

                        return SizedBox(
                          width: isHorizontal
                              ? effectiveHorizontalWidth
                              : effectiveVerticalWidth,
                          height: commonHeight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.card,
                              borderRadius: BorderRadius.circular(
                                AppFormat.primaryBorderRadius,
                              ),
                              border: Border.all(
                                color: AppColor.disable,
                                width: 0.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppFormat.primaryBorderRadius,
                              ),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.contain,
                                height: commonHeight,
                                gaplessPlayback: true,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Left Arrow Button
            Positioned(
              left: 8,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColor.white,
                    size: 18,
                  ),
                  onPressed: () => _scroll(
                    false,
                    effectiveVerticalWidth,
                    effectiveHorizontalWidth,
                    spacing,
                  ),
                ),
              ),
            ),

            // Right Arrow Button
            Positioned(
              right: 8,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.white,
                    size: 18,
                  ),
                  onPressed: () => _scroll(
                    true,
                    effectiveVerticalWidth,
                    effectiveHorizontalWidth,
                    spacing,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
