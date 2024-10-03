import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';

class ReusableContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final List<BoxShadow> boxShadow;
  final Widget child;

  const ReusableContainer({
    Key? key,
    this.height = 0,
    this.width = 0,
    this.color = AppColors.purple,
    this.padding = const EdgeInsets.all(8.0),
    this.margin = const EdgeInsets.all(8.0),
    this.borderRadius = 10.0,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 5.0,
        offset: Offset(2, 2),
      ),
    ],
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
