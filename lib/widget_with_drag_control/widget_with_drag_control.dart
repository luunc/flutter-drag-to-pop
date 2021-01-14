import 'dart:math' as math;

import 'package:flutter/material.dart';

class WidgetWithDragControl extends StatelessWidget {
  final String heroKey;
  final Widget child;
  final Offset dragOffset;
  final double scale;
  final Animation<Offset> animation;
  final Color backgroundColor;
  final Widget overlayWidget;
  final double minOverlayOpacity;
  final double maxOverlayOpacity;
  final double horizontalOpacityDragRate;
  final double verticalOpacityDragRate;

  const WidgetWithDragControl({
    Key key,
    @required this.dragOffset,
    @required this.scale,
    @required this.child,
    @required this.heroKey,
    @required this.animation,
    this.backgroundColor = Colors.black,
    this.overlayWidget,
    this.minOverlayOpacity = 0.0,
    this.maxOverlayOpacity = 1.0,
    this.verticalOpacityDragRate = 4,
    this.horizontalOpacityDragRate = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, Widget child) {
        Offset finalOffset = dragOffset;
        if (animation.status == AnimationStatus.forward)
          finalOffset = animation.value;

        final bgOpacity = finalOffset.distance == 0.0
            ? 1.0
            : math.min(
                maxOverlayOpacity -
                    (finalOffset.dy / 100 / verticalOpacityDragRate).abs(),
                maxOverlayOpacity -
                    (finalOffset.dx / 100 / horizontalOpacityDragRate).abs(),
              );

        return Stack(
          children: [
            Container(
              color: backgroundColor.withOpacity(
                math.max(bgOpacity, minOverlayOpacity),
              ),
              child: Transform.scale(
                scale: scale,
                child: Transform.translate(
                  offset: finalOffset,
                  child: child,
                ),
              ),
            ),
            if (finalOffset.distance == 0.0 && overlayWidget != null)
              overlayWidget,
          ],
        );
      },
      child: Center(
        child: Hero(
          tag: heroKey,
          child: child,
        ),
      ),
    );
  }
}
