import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  final String content;
  final double? width;
  final double? height;
  final bool isDimmed;

  const TimerCard({
    Key? key,
    required this.content,
    this.width,
    this.height,
    this.isDimmed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = width ?? constraints.maxWidth;
      double maxHeight = height ?? constraints.maxHeight;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < 2; i++)
            Positioned(
              top: -5 * (i + 1),
              left: maxWidth * ((i + 1) * 0.1) / 2,
              width: maxWidth * (1 - (i + 1) * 0.1),
              height: maxHeight * (1 - (i + 1) * 0.1),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          Container(
            width: maxWidth,
            height: maxHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10)),
            child: Text(content,
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: isDimmed
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                      : Theme.of(context).colorScheme.primary,
                )),
          ),
        ],
      );
    });
  }
}
