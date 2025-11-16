import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/app_colors.dart';

class CustomSquareBtn extends StatelessWidget {
  VoidCallback onTap;
  double mWidth;
  double mHeight;
  Color bgColor;
  String text;
  Color textColor;
  String? mIconPath;
  bool isOutlined;
  Color iconColor;
  double fontSize;
  double sBoxSize;
  double sBoxSize2;
  double iconHeight;

  CustomSquareBtn({
    required this.onTap,
    required this.text,
    this.textColor=Colors.white,
    this.mIconPath,
    this.mWidth=300,
    this.mHeight=50,
    this.bgColor=Colors.white,
    this.isOutlined=false,
    this.iconColor=Colors.white,
    this.fontSize=30,
    this.sBoxSize=30,
    this.sBoxSize2=30,
    this.iconHeight=30,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: mWidth,
        height: mHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isOutlined ? Colors.transparent: bgColor,
          border: isOutlined ? Border.all(
            width: 3,
            color: isOutlined ? AppColors.primaryColor : Colors.transparent,
          ) : null,
        ),
        child: mIconPath != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
              children: [
                SizedBox(height: sBoxSize,),
                SvgPicture.asset(mIconPath!, height: iconHeight, color: iconColor,),
                SizedBox(height: sBoxSize2,),
                Expanded(child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.bold, ),)),
              ]
          ),
        ) : Center(
          child: Center(child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}
