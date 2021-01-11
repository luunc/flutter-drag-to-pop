import 'package:flutter/material.dart';

import 'package:flutter_drag_to_pop/full_screen_modal/full_screen_modal.dart';
import 'package:flutter_drag_to_pop/helper.dart';

class DragToPop extends StatelessWidget {
  final String heroKey = DragDownToPopKey.getKey();

  final Widget closeWidget;
  final Widget openWidget;
  final Widget openOverlayWidget;
  final Color openBackgroundColor;

  DragToPop({
    Key key,
    @required this.closeWidget,
    @required this.openWidget,
    this.openOverlayWidget,
    this.openBackgroundColor = Colors.black,
  }) : super(key: key);

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
              ),
            ),
          ),
        ),
      );
}
