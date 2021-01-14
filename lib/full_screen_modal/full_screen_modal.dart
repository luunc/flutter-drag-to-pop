import 'package:flutter/material.dart';

import 'package:flutter_drag_to_pop/flutter_drag_to_pop/flutter_drag_to_pop.dart';
import 'package:flutter_drag_to_pop/widget_with_drag_control/widget_with_drag_control.dart';

class FullScreenModal extends StatefulWidget {
  final Widget child;
  final Widget overlayWidget;
  final Color backgroundColor;
  final String heroKey;
  final double minOverlayOpacity;
  final double maxOverlayOpacity;
  final double horizontalOpacityDragRate;
  final double verticalOpacityDragRate;
  final DragToPopDirection dragToPopDirection;

  const FullScreenModal({
    Key key,
    @required this.child,
    @required this.heroKey,
    this.backgroundColor = Colors.black,
    this.overlayWidget,
    this.minOverlayOpacity,
    this.maxOverlayOpacity,
    this.horizontalOpacityDragRate,
    this.verticalOpacityDragRate,
    this.dragToPopDirection,
  }) : super(key: key);

  @override
  _FullScreenModalState createState() => _FullScreenModalState();
}

class _FullScreenModalState extends State<FullScreenModal>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;
  Offset _dragOffset;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animationController.addStatusListener(_onAnimationEnd);

    _animation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_onAnimationEnd);
    _animationController.dispose();
    super.dispose();
  }

  void _onAnimationEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reset();
      setState(() => _dragOffset = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onModalDragUpdate,
      onPanEnd: _onModalDragEnd,
      child: WidgetWithDragControl(
        child: widget.child,
        dragOffset: _dragOffset ?? Offset(0.0, 0.0),
        heroKey: widget.heroKey,
        animation: _animation,
        backgroundColor: widget.backgroundColor,
        overlayWidget: widget.overlayWidget,
        maxOverlayOpacity: widget.maxOverlayOpacity,
        minOverlayOpacity: widget.minOverlayOpacity,
        horizontalOpacityDragRate: widget.horizontalOpacityDragRate,
        verticalOpacityDragRate: widget.verticalOpacityDragRate,
      ),
    );
  }

  void _onModalDragEnd(DragEndDetails dragEndDetails) {
    if (_dragOffset == null) return;

    final screenSize = MediaQuery.of(context).size;

    if ((_dragOffset?.dy ?? 0).abs() >= screenSize.height / 3 ||
        (_dragOffset?.dx ?? 0).abs() >= screenSize.width / 1.8) {
      Navigator.of(context).pop();
      return;
    }

    final velocity = dragEndDetails.velocity?.pixelsPerSecond;
    final velocityY = velocity?.dy ?? 0.0;
    final velocityX = velocity?.dx ?? 0.0;

    if (velocityY.abs() > 150.0 || velocityX.abs() > 200.0) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _animation = Tween<Offset>(
        begin: Offset(_dragOffset.dx, _dragOffset.dy),
        end: Offset(0.0, 0.0),
      ).animate(_animationController);
    });

    _animationController.forward();
    return;
  }

  void _onModalDragUpdate(DragUpdateDetails dragUpdateDetails) {
    final delta = dragUpdateDetails.delta;
    final newX = (_dragOffset?.dx ?? 0.0) + delta.dx;
    final newY = (_dragOffset?.dy ?? 0.0) + delta.dy;
    setState(() => _dragOffset = Offset(newX, newY));
  }
}
