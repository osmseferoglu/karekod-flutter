import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:provider/provider.dart';
import 'package:karekod/Providers/provider.dart';

class ColorBottomSheet extends StatelessWidget {
  const ColorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);
    return Container(
      margin: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    prov.shuffleColor();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: prov.color,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: SFIcon(
                        SFIcons.sf_shuffle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                for (var color in prov.colorOptions)
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      prov.setColor(color);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
