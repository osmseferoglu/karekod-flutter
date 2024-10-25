import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:karekod/Providers/provider.dart';

class EyeSheet extends StatelessWidget {
  const EyeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);
    return Container(
        width: double.infinity,
        margin: MediaQuery.of(context).viewInsets +
            const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            ListTile(
                tileColor: prov.eyeStyle != QrEyeShape.square
                    ? Theme.of(context).focusColor
                    : prov.color.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  HapticFeedback.selectionClick();
                  prov.setEyeStyle(QrEyeShape.square);
                },
                trailing: prov.eyeStyle == QrEyeShape.square
                    ? const Icon(Icons.square, size: 30)
                    : const Icon(Icons.crop_square_outlined, size: 30),
                leading: const Text('Sqaure')),
            const SizedBox(height: 10),
            ListTile(
                tileColor: prov.eyeStyle != QrEyeShape.circle
                    ? Theme.of(context).focusColor
                    : prov.color.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  HapticFeedback.selectionClick();
                  prov.setEyeStyle(QrEyeShape.circle);
                },
                trailing: prov.eyeStyle == QrEyeShape.circle
                    ? const Icon(Icons.circle, size: 30)
                    : const Icon(Icons.circle_outlined, size: 30),
                leading: const Text('Circle')),
            const SizedBox(height: 50),
          ],
        ));
  }
}
