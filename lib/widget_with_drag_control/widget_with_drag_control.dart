import 'package:flutter/material.dart';

class WidgetWithDragControl extends StatelessWidget {
  final Widget child;
  final Offset dragOffset;
  final String heroKey;
  final Animation<Offset> animation;
  final Color backgroundColor;
  final Widget overlayWidget;

  const WidgetWithDragControl({
    Key key,
    @required this.dragOffset,
    @required this.child,
    @required this.heroKey,
    @required this.animation,
    this.backgroundColor = Colors.black,
    this.overlayWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, Widget child) {
        Offset finalOffset = dragOffset;
        if (animation.status == AnimationStatus.forward) {
          finalOffset = animation.value;
        }

        var bgOpacity = 1 - (finalOffset.dy / 500).abs();
        if (bgOpacity < 0) bgOpacity = 0.0;

        return Stack(
          children: [
            Container(
              color: backgroundColor.withOpacity(bgOpacity),
              child: Transform.translate(
                offset: finalOffset,
                child: child,
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
