import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final bool border;
  final double? width;
  final double? height;
  final Color? color;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? horizontalMargin;
  final double? verticalMargin;
  final double? radiusTopLeft;
  final double? radiusTopRight;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;

  const MyContainer({
    super.key,
    required this.child,
    this.color,
    this.border = false,
    this.width,
    this.height,
    this.horizontalPadding = 4,
    this.verticalPadding = 4,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
    this.radiusTopLeft = 10,
    this.radiusTopRight = 10,
    this.radiusBottomLeft = 10,
    this.radiusBottomRight = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding!,
        vertical: verticalPadding!,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin!,
        vertical: verticalMargin!,
      ),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusTopLeft!),
          topRight: Radius.circular(radiusTopRight!),
          bottomLeft: Radius.circular(radiusBottomLeft!),
          bottomRight: Radius.circular(radiusBottomRight!),
        ),
        border: (border)
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
      ),
      width: (width != null) ? width : null,
      height: (height != null) ? height : null,
      child: child,
    );
  }
}
