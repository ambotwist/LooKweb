import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LazyLoadImage extends StatefulWidget {
  final String imagePath;
  final BoxFit fit;
  final Alignment alignment;
  final double? height;
  final double? width;
  final Widget? placeholder;

  const LazyLoadImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.height,
    this.width,
    this.placeholder,
  });

  @override
  State<LazyLoadImage> createState() => _LazyLoadImageState();
}

class _LazyLoadImageState extends State<LazyLoadImage> {
  bool _isVisible = false;
  final _uniqueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('image-${widget.imagePath}-$_uniqueKey'),
      onVisibilityChanged: (visibilityInfo) {
        // Load the image when it's at least 10% visible
        if (visibilityInfo.visibleFraction > 0.1 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: _isVisible
          ? Image.asset(
              widget.imagePath,
              fit: widget.fit,
              alignment: widget.alignment,
              height: widget.height,
              width: widget.width,
            )
          : widget.placeholder ??
              Container(
                height: widget.height,
                width: widget.width,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
    );
  }
}
