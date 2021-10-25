import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartHolder extends StatefulWidget {
  final Widget widget;
  final int direction; //0 - Left, 1 - Right. By default 0
  const ChartHolder(this.widget, {Key? key, this.direction = 0})
      : super(key: key);

  @override
  _ChartHolderState createState() => _ChartHolderState();
}

class _ChartHolderState extends State<ChartHolder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: widget.widget,
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(1 - _slideAnimation.value, 0) *
                (widget.direction == 0 ? -1 : 1) *
                40,
            child: child,
          );
        });
  }
}
