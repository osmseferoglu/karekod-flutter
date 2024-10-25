import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:provider/provider.dart';
import 'package:karekod/Providers/provider.dart';
import 'package:karekod/Utilities/image_picker.dart';

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);
    return Container(
      margin: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prov.selectedImage != const AssetImage('assets/logo.png')) ...[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const SFIcon(
                  SFIcons.sf_trash_fill,
                  fontSize: 20,
                  color: CupertinoColors.destructiveRed,
                ),
                onPressed: () {
                  prov.deleteImage();
                },
              ),
            ),
          ],
          GestureDetector(
            onTap: () {
              if (prov.selectedImage == const AssetImage('assets/logo.png')) {
                pickImage(prov);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 275,
              height: 275,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 5, color: Theme.of(context).hoverColor),
                borderRadius: BorderRadius.circular(40),
              ),
              child: prov.selectedImage == const AssetImage('assets/logo.png')
                  ? const Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SFIcon(SFIcons.sf_photo_badge_plus_fill,
                              fontSize: 100),
                        ),
                        Text(
                          'Tap to add image',
                        ),
                      ],
                    )
                  : Image(
                      isAntiAlias: true,
                      width: 100,
                      height: 100,
                      image: prov.selectedImage),
            ),
          ),
          const SizedBox(height: 20),
          if (prov.selectedImage != const AssetImage('assets/logo.png')) ...[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Image Size'),
                Slider.adaptive(
                    activeColor: CupertinoColors.activeBlue,
                    label: 'Image Size',
                    min: 30,
                    max: 50,
                    value: prov.imageSize,
                    onChanged: (value) {
                      HapticFeedback.selectionClick();
                      prov.setImageSize(value);
                    }),
              ],
            ),
          ],
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
