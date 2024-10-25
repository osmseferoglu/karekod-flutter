import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:karekod/Providers/provider.dart';

class CornerBottomSheet extends StatelessWidget {
  const CornerBottomSheet({super.key});

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
            ListTile(
                tileColor: prov.cornerRadius != 0
                    ? Theme.of(context).focusColor
                    : prov.color.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () async {
                  prov.toggleTarget();
                  HapticFeedback.selectionClick();
                  prov.setCornerRadius(0);
                },
                trailing: const Icon(
                  Icons.square_outlined,
                  size: 30,
                ),
                leading: const Text('None')),
            const SizedBox(height: 10),
            ListTile(
                onTap: () async {
                  await prov.toggleTarget();
                  HapticFeedback.selectionClick();
                  prov.setCornerRadius(20);
                },
                tileColor: prov.cornerRadius != 20
                    ? Theme.of(context).focusColor
                    : prov.color.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                trailing: const Icon(Icons.crop_square_outlined, size: 30),
                leading: const Text('Rounded')),
            const SizedBox(height: 10),
            ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: prov.cornerRadius != 40
                    ? Theme.of(context).focusColor
                    : prov.color.withOpacity(0.5),
                onTap: () async {
                  await prov.toggleTarget();
                  HapticFeedback.selectionClick();
                  prov.setCornerRadius(40);
                },
                leading: const Text('Extra Rounded'),
                trailing: const Icon(Icons.rounded_corner, size: 30)),
            const SizedBox(height: 50),
          ],
        ));
  }
}
