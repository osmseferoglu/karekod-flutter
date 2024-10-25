import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:karekod/Views/sheets/data_type_sheet.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:karekod/Components/bottomsheet.dart';
import 'package:karekod/Components/textfield.dart';
import 'package:karekod/Providers/provider.dart';
import 'package:karekod/Views/sheets/border_sheet.dart';
import 'package:karekod/Views/sheets/color_sheet.dart';
import 'package:karekod/Views/sheets/corner_sheet.dart';
import 'package:karekod/Views/sheets/eye_sheet.dart';
import 'package:karekod/Views/sheets/image_sheets.dart';
import 'package:karekod/Views/sheets/settings_sheet.dart';
import 'package:screenshot/screenshot.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        spacing: 20,
        children: [
          IconButton.filled(
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(60, 60)),
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).scaffoldBackgroundColor),
            ),
            color: prov.color,
            onPressed: () {
              HapticFeedback.selectionClick();
              prov.takeScreenshot();
            },
            icon: const SFIcon(SFIcons.sf_square_and_arrow_up),
          ),
          IconButton.filled(
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(100, 60)),
              backgroundColor: WidgetStateProperty.all(prov.color),
            ),
            onPressed: () {
              HapticFeedback.selectionClick();
              prov.shuffleColor();
            },
            icon: const SFIcon(
              SFIcons.sf_shuffle,
            ),
          ),
          IconButton.filled(
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(60, 60)),
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).scaffoldBackgroundColor),
            ),
            color: prov.color,
            onPressed: () {
              HapticFeedback.selectionClick();
              showCustomBottomSheet(
                context,
                const SettingsSheet(),
                showHandle: true,
              );
            },
            icon: const SFIcon(
              SFIcons.sf_gear,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: <Widget>[
            Screenshot(
              controller: prov.screenshotController,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).hoverColor,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                  color: prov.color,
                  borderRadius: BorderRadius.circular(prov.cornerRadius),
                ),
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(prov.borderRadius),
                child: Column(
                  children: [
                    QrImageView(
                            eyeStyle: QrEyeStyle(
                                color: Colors.black, eyeShape: prov.eyeStyle),
                            embeddedImageStyle: QrEmbeddedImageStyle(
                                size: Size(prov.imageSize, prov.imageSize),
                                color: Colors.transparent),
                            embeddedImage: prov.selectedImage ==
                                    const AssetImage('assets/logo.png')
                                ? null
                                : prov.selectedImage,
                            data: prov.qrData)
                        .animate(target: prov.target ? 1 : 0)
                        .shimmer(
                            duration: const Duration(milliseconds: 250),
                            color: prov.color),
                    if (prov.showDescription) ...[
                      Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SFIcon(
                            prov.selectedDataTypeIcon,
                            color: CupertinoColors.black,
                          ),
                          Text(
                            prov.data,
                            style:
                                const TextStyle(color: CupertinoColors.black),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  onChanged: (value) {
                    prov.setData(value);
                  },
                  hintText: prov.hintText,
                )),
                IconButton(
                    onPressed: () {
                      showCustomBottomSheet(context, const DataTypeSheet());
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: prov.color, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SFIcon(prov.selectedDataTypeIcon),
                    )),
              ],
            ),
            if (prov.selectedDataType == 'WiFi')
              SwitchListTile.adaptive(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                secondary: prov.showPassword
                    ? const Icon(SFIcons.sf_lock_circle_fill)
                    : const Icon(SFIcons.sf_lock_circle),
                dense: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: prov.color == Colors.white
                    ? Theme.of(context).hoverColor
                    : prov.color.withOpacity(0.5),
                title: const Text("Password"),
                value: prov.showPassword,
                onChanged: (value) {
                  HapticFeedback.selectionClick();
                  prov.setShowPassword(value);
                },
              ),
            if (prov.showPassword) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Password',
                      onChanged: (value) {
                        prov.setPassword(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                      value: prov.encryptionType,
                      icon: const SFIcon(SFIcons.sf_chevron_down, fontSize: 16),
                      underline: Container(),
                      items: const [
                        DropdownMenuItem(
                          value: 'WPA',
                          child: Text('WPA'),
                        ),
                        DropdownMenuItem(
                          value: 'WEP',
                          child: Text('WEP'),
                        ),
                      ],
                      onChanged: (value) {
                        HapticFeedback.selectionClick();
                        prov.setEncryptionType(value!);
                      })
                ],
              ),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(),
            ),
            ListTile(
              onTap: () {
                HapticFeedback.selectionClick();
                showCustomBottomSheet(
                  context,
                  const ColorBottomSheet(),
                  showHandle: true,
                );
              },
              tileColor: prov.color == Colors.white
                  ? Theme.of(context).hoverColor
                  : prov.color.withOpacity(0.5),
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Color'),
              trailing: SFIcon(SFIcons.sf_circle_fill, color: prov.color),
            ),
            const SizedBox(height: 10),
            ListTile(
                onTap: () {
                  HapticFeedback.selectionClick();
                  showCustomBottomSheet(
                    context,
                    const BorderBottomSheet(),
                    showHandle: true,
                  );
                },
                tileColor: prov.color == Colors.white
                    ? Theme.of(context).hoverColor
                    : prov.color.withOpacity(0.5),
                style: ListTileStyle.list,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Border'),
                trailing: const SFIcon(SFIcons.sf_square_resize)),
            const SizedBox(height: 10),
            ListTile(
              onTap: () async {
                HapticFeedback.selectionClick();
                showCustomBottomSheet(context, const ImageBottomSheet(),
                    showHandle: true);
              },
              tileColor: prov.color == Colors.white
                  ? Theme.of(context).hoverColor
                  : prov.color.withOpacity(0.5),
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Image'),
              trailing: const SFIcon(
                SFIcons.sf_photo,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () {
                HapticFeedback.selectionClick();
                showCustomBottomSheet(
                  context,
                  const CornerBottomSheet(),
                  showHandle: true,
                );
              },
              tileColor: prov.color == Colors.white
                  ? Theme.of(context).hoverColor
                  : prov.color.withOpacity(0.5),
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text('Corners',
                  style: Theme.of(context).textTheme.bodyMedium),
              trailing: const SFIcon(
                SFIcons.sf_square_dashed,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              onTap: () => {
                HapticFeedback.selectionClick(),
                showCustomBottomSheet(
                  context,
                  const EyeSheet(),
                  showHandle: true,
                ),
              },
              tileColor: prov.color == Colors.white
                  ? Theme.of(context).hoverColor
                  : prov.color.withOpacity(0.5),
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title:
                  Text('Eyes', style: Theme.of(context).textTheme.bodyMedium),
              trailing: const SFIcon(
                SFIcons.sf_eye,
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile.adaptive(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: prov.color == Colors.white
                  ? Theme.of(context).hoverColor
                  : prov.color.withOpacity(0.5),
              title: const Text(
                'Enable Description',
              ),
              value: prov.showDescription,
              onChanged: (value) {
                HapticFeedback.selectionClick();
                prov.setShowDescription(value);
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
