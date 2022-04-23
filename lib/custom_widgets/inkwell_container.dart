import 'package:flutter/material.dart';

class CustomInkwellContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double height;
  final double borderRadius;
  final Color? splashColor;

  CustomInkwellContainer(
      {required this.onPressed,
      this.backgroundColor = Colors.white,
      this.height = 75,
      required this.child,
      this.borderRadius = 8,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: this.backgroundColor,
      borderRadius: BorderRadius.all(
        Radius.circular(
          this.borderRadius,
        ),
      ),
      child: InkWell(
        splashColor: this.splashColor,
        onTap: this.onPressed,
        child: Container(
          height: this.height,
          child: this.child,
        ),
      ),
    );
  }
}
