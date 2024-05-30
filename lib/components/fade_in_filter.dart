import 'package:flutter/material.dart';

class FadeInFilter extends StatelessWidget {
  final Color sideColor;
  final Color centerColor;
  const FadeInFilter({
    super.key,
    required this.sideColor,
    required this.centerColor,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              sideColor,
              centerColor,
              centerColor,
              sideColor,
            ],
            stops: const [
              0.0,
              0.3,
              0.7,
              1.0,
            ],
          ),
        ),
      ),
    );
  }
}
