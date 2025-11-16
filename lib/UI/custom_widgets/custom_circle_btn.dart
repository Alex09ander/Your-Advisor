import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/app_colors.dart';



class CustomCircleBtn extends StatelessWidget {

  void toggleOutlinedState() {
      isOutlined = !isOutlined;
  }

  VoidCallback onTap;
  double mRadius;
  Color bgColor;
  bool isOutlined;

  CustomCircleBtn({
    required this.onTap,
    this.mRadius=50,
    this.bgColor=Colors.white,
    this.isOutlined=false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(360),
      child: Container(
        width: mRadius,
        height: mRadius,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(360),
          color: isOutlined ? Colors.transparent: bgColor,
          border: isOutlined ? Border.all(
            width: 3,
            color: isOutlined ? bgColor : Colors.transparent,
          ) : null,
        ),
      ),
    );
  }
}
