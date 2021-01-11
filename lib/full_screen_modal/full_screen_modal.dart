import 'package:flutter/material.dart';

import 'package:flutter_drag_to_pop/widget_with_drag_control/widget_with_drag_control.dart';

class FullScreenModal extends StatefulWidget {
  final Widget child;
  final Widget overlayWidget;
  final Color backgroundColor;
  final String heroKey;

  const FullScreenModal({
    Key key,
    @required this.child,
    @required this.heroKey,
    this.backgroundColor = Colors.black,
    this.overlayWidget,
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
      onPanStart: _onModalDragStart,
      onPanUpdate: _onModalDragUpdate,
      onPanEnd: _onModalDragEnd,
      child: WidgetWithDragControl(
        child: widget.child,
        dragOffset: _dragOffset ?? Offset(0.0, 0.0),
        heroKey: widget.heroKey,
        animation: _animation,
        backgroundColor: widget.backgroundColor,
        overlayWidget: widget.overlayWidget,
      ),
    );
  }

  void _onModalDragEnd(DragEndDetails dragEndDetails) {
    if ((_dragOffset.dy).abs() >= MediaQuery.of(context).size.height / 4) {
      Navigator.of(context).pop();
      return;
    }

    final velocity = dragEndDetails.velocity?.pixelsPerSecond;
    final velocityY = velocity?.dy ?? 0.0;

    if (velocityY.abs() > 150.0) {
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
    if (_dragOffset == null) return;

    final delta = dragUpdateDetails.delta;
    final newX = _dragOffset.dx + delta.dx;
    final newY = _dragOffset.dy + delta.dy;
    setState(() => _dragOffset = Offset(newX, newY));
  }

  void _onModalDragStart(DragStartDetails dragStartDetails) {
    _dragOffset = Offset(0.0, 0.0);
  }
}
