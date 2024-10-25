import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.icon,
      this.isDestructive});
  final void Function() onPressed;
  final Widget child;
  final Widget? icon;
  final bool? isDestructive;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
        icon: icon,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              isDestructive != null && isDestructive == true
                  ? CupertinoColors.systemRed
                  : Theme.of(context).brightness == Brightness.dark
                      ? CupertinoColors.systemGrey6
                      : CupertinoColors.systemBlue),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        label: child);
  }
}
