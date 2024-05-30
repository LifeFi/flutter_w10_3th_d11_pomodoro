import 'package:flutter/material.dart';

class InteractiveContainer extends StatefulWidget {
  final Widget child;
  final double bottomValue;
  final double topValue;

  const InteractiveContainer({
    super.key,
    required this.child,
    this.bottomValue = 0.7,
    this.topValue = 1.2,
  });

  @override
  State<InteractiveContainer> createState() => _ClickContainerState();
}

class _ClickContainerState extends State<InteractiveContainer> {
  double scaleFactor = 1.0;
  @override
  Widget build(BuildContext context) {
    return Listener(
      // behavior: HitTestBehavior.translucent,
      onPointerDown: (_) async {
        setState(() {
          scaleFactor = widget.bottomValue;
        });
        await Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            scaleFactor = widget.topValue;
          });
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            scaleFactor = 1.0;
          });
        });
      },

      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        scale: scaleFactor,
        child: widget.child,
      ),
    );
  }
}
