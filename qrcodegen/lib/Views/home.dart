import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../Components/bottomsheet.dart';
import '../Components/textfield.dart';
import '../Providers/provider.dart';
import '../Views/sheets/color_sheet.dart';
import '../Views/sheets/data_type_sheet.dart';
import '../Views/sheets/settings_sheet.dart';
import '../Views/sheets/border_sheet.dart';
import '../Views/sheets/corner_sheet.dart';
import '../Views/sheets/eye_sheet.dart';
import '../Views/sheets/image_sheets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingButtons(prov, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            _QrDisplaySection(prov: prov),
            const SizedBox(height: 20),
            _TextInputSection(prov: prov),
            if (prov.selectedDataType == 'WiFi')
              _WiFiPasswordSection(prov: prov),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(),
            ),
            _SettingsOptions(prov: prov),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButtons(QrProvider prov, BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      spacing: 20,
      children: [
        _buildFloatingButton(
          isCenterButton: false,
          context: context,
          color: prov.color,
          icon: SFIcons.sf_square_and_arrow_up,
          onPressed: prov.takeScreenshot,
          contextColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        _buildFloatingButton(
          isCenterButton: true,
          context: context,
          color: prov.color,
          icon: SFIcons.sf_shuffle,
          onPressed: prov.shuffleColor,
          buttonSize: const Size(100, 60),
        ),
        _buildFloatingButton(
          isCenterButton: false,
          context: context,
          color: prov.color,
          icon: SFIcons.sf_gear,
          onPressed: () => showCustomBottomSheet(
            context,
            const SettingsSheet(),
            showHandle: true,
          ),
          contextColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ],
    );
  }

  IconButton _buildFloatingButton(
      {required Color color,
      required IconData icon,
      required VoidCallback onPressed,
      Color? contextColor,
      Size buttonSize = const Size(60, 60),
      required BuildContext context,
      required bool isCenterButton}) {
    return IconButton.filled(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(buttonSize),
        backgroundColor:
            WidgetStateProperty.all(isCenterButton ? color : contextColor),
      ),
      color: color,
      onPressed: () {
        HapticFeedback.selectionClick();
        onPressed();
      },
      icon: SFIcon(
        icon,
        color: isCenterButton ? CupertinoColors.white : color,
      ),
    );
  }
}

class _QrDisplaySection extends StatelessWidget {
  final QrProvider prov;

  const _QrDisplaySection({required this.prov});

  @override
  Widget build(BuildContext context) {
    return Screenshot(
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
                color: Colors.black,
                eyeShape: prov.eyeStyle,
              ),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(prov.imageSize, prov.imageSize),
                color: Colors.transparent,
              ),
              embeddedImage:
                  prov.selectedImage == const AssetImage('assets/logo.png')
                      ? null
                      : prov.selectedImage,
              data: prov.qrData,
            ).animate(target: prov.target ? 1 : 0).shimmer(
                  duration: const Duration(milliseconds: 250),
                  color: prov.color,
                ),
            if (prov.showDescription) _QrDescription(prov: prov),
          ],
        ),
      ),
    );
  }
}

class _QrDescription extends StatelessWidget {
  final QrProvider prov;

  const _QrDescription({required this.prov});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SFIcon(prov.selectedDataTypeIcon, color: CupertinoColors.black),
        Text(prov.data, style: const TextStyle(color: CupertinoColors.black)),
      ],
    );
  }
}

class _TextInputSection extends StatelessWidget {
  final QrProvider prov;

  const _TextInputSection({required this.prov});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            onChanged: prov.setData,
            hintText: prov.hintText,
          ),
        ),
        IconButton(
          onPressed: () => showCustomBottomSheet(
            context,
            const DataTypeSheet(),
          ),
          icon: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: prov.color, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SFIcon(prov.selectedDataTypeIcon),
          ),
        ),
      ],
    );
  }
}

class _WiFiPasswordSection extends StatelessWidget {
  final QrProvider prov;

  const _WiFiPasswordSection({required this.prov});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          secondary: prov.showPassword
              ? const Icon(SFIcons.sf_lock_circle_fill)
              : const Icon(SFIcons.sf_lock_circle),
          tileColor: prov.color.withOpacity(0.5),
          title: const Text("Password"),
          value: prov.showPassword,
          onChanged: prov.setShowPassword,
        ),
        if (prov.showPassword)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Password',
                    onChanged: prov.setPassword,
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton(
                  value: prov.encryptionType,
                  icon: const SFIcon(SFIcons.sf_chevron_down, fontSize: 16),
                  underline: Container(),
                  items: const [
                    DropdownMenuItem(value: 'WPA', child: Text('WPA')),
                    DropdownMenuItem(value: 'WEP', child: Text('WEP')),
                  ],
                  onChanged: (value) {
                    prov.setEncryptionType(value!);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SettingsOptions extends StatelessWidget {
  final QrProvider prov;

  const _SettingsOptions({required this.prov});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SettingsTile(
          title: 'Color',
          icon: SFIcons.sf_circle_fill,
          onTap: () => showCustomBottomSheet(
            context,
            const ColorBottomSheet(),
            showHandle: true,
          ),
          prov: prov,
        ),
        _SettingsTile(
          title: 'Border',
          icon: SFIcons.sf_square_resize,
          onTap: () => showCustomBottomSheet(
            context,
            const BorderBottomSheet(),
            showHandle: true,
          ),
          prov: prov,
        ),
        _SettingsTile(
          title: 'Image',
          icon: SFIcons.sf_photo,
          onTap: () => showCustomBottomSheet(
            context,
            const ImageBottomSheet(),
            showHandle: true,
          ),
          prov: prov,
        ),
        _SettingsTile(
          title: 'Corners',
          icon: SFIcons.sf_square_dashed,
          onTap: () => showCustomBottomSheet(
            context,
            const CornerBottomSheet(),
            showHandle: true,
          ),
          prov: prov,
        ),
        _SettingsTile(
          title: 'Eyes',
          icon: SFIcons.sf_eye,
          onTap: () => showCustomBottomSheet(
            context,
            const EyeSheet(),
            showHandle: true,
          ),
          prov: prov,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: SwitchListTile.adaptive(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            tileColor: prov.color.withOpacity(0.5),
            title: const Text('Enable Description'),
            value: prov.showDescription,
            onChanged: prov.setShowDescription,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final QrProvider prov;

  const _SettingsTile({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.prov,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        tileColor: prov.color.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        trailing: SFIcon(icon, color: prov.color),
      ),
    );
  }
}
