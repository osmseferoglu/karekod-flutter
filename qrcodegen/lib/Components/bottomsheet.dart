import 'package:flutter/material.dart';

void showCustomBottomSheet(BuildContext context, Widget child,
    {bool? showHandle}) {
  showModalBottomSheet(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    showDragHandle: showHandle,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height * 0.2,
      maxHeight: MediaQuery.of(context).size.height * 0.8,
    ),
    context: context,
    builder: (context) {
      return child;
    },
  );
}
