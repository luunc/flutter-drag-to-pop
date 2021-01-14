import 'package:flutter/material.dart';

import 'package:flutter_drag_to_pop/full_screen_modal/full_screen_modal.dart';
import 'package:flutter_drag_to_pop/helper.dart';

enum DragToPopDirection {
  all,
  horizontal,
  vertical,
  right,
  left,
  bottom,
  top,
}

class DragToPop extends StatelessWidget {
  final String heroKey = DragDownToPopKey.getKey();

  final Widget closeWidget;
  final Widget openWidget;
  final Widget openOverlayWidget;
  final Color openBackgroundColor;
  final double minOverlayOpacity;
  final double maxOverlayOpacity;
  final double horizontalOpacityDragRate;
  final double verticalOpacityDragRate;
  final DragToPopDirection dragToPopDirection;

  DragToPop({
    Key key,
    @required this.closeWidget,
    @required this.openWidget,
    this.openOverlayWidget,
    this.dragToPopDirection = DragToPopDirection.all,
    this.openBackgroundColor = Colors.black,
    this.minOverlayOpacity = 0.0,
    this.maxOverlayOpacity = 1.0,
    this.horizontalOpacityDragRate = 6,
    this.verticalOpacityDragRate = 4,
  })  : assert(minOverlayOpacity != null && minOverlayOpacity >= 0.0),
        assert(maxOverlayOpacity != null &&
            maxOverlayOpacity >= minOverlayOpacity),
        super(key: key);

  @override
  Widget build(BuildContext context) => Hero(
        tag: heroKey,
        child: GestureDetector(
          child: closeWidget,
          onTap: () => Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
              pageBuilder: (BuildContext context, _, __) => FullScreenModal(
                child: openWidget,
                heroKey: heroKey,
                backgroundColor: openBackgroundColor,
                overlayWidget: openOverlayWidget,
                maxOverlayOpacity: maxOverlayOpacity,
                minOverlayOpacity: minOverlayOpacity,
                horizontalOpacityDragRate: horizontalOpacityDragRate,
                verticalOpacityDragRate: verticalOpacityDragRate,
              ),
            ),
          ),
        ),
      );
}
