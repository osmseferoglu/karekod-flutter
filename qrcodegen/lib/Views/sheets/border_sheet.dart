import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:karekod/Providers/provider.dart';

class BorderBottomSheet extends StatelessWidget {
  const BorderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);
    return Container(
      margin: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10),
      child: Slider.adaptive(
        activeColor: prov.color,
        value: prov.borderRadius,
        onChanged: (value) {
          prov.setBorderRadius(value);
        },
        min: 20,
        max: 50,
      ),
    );
  }
}
