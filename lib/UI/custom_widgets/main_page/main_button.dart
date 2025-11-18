import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.titleText,
    required this.contentText,
    required this.assetImagePath,
    required this.onPressed,
  });

  final String titleText;
  final String contentText;
  final String assetImagePath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(10),
              Text(
                contentText,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
        Gap(20),
        SizedBox(
            width: 150,
            child: Column(
              children: [
                Image.asset(
                  assetImagePath,
                  fit: BoxFit.fitWidth,
                  width: 120,
                ),
                Gap(15),
                FilledButton(
                    onPressed: onPressed,
                    child: Text(
                      'Przejdź',
                      // style: Theme.of(context).textTheme.bodyMedium,
                    ))
              ],
            ))
      ],
    );
  }
}
