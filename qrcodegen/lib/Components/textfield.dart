import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:karekod/Providers/provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
  });
  final Function onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);
    return TextField(
      autocorrect: false,
      onChanged: (value) {
        onChanged(value);
      },
      onTap: () {
        HapticFeedback.selectionClick();
      },
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: prov.color == Colors.white
            ? Theme.of(context).hoverColor
            : prov.color.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
