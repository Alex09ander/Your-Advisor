import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_advisor/domain/app_colors.dart';

class ProgressBar extends StatelessWidget {

  double progress;

  ProgressBar({
    this.progress=50,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Container(
            width: 350,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.informColor,
            ),
          ),
          Container(
            width: progress,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
