import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:karekod/Constants/constants.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          MediaQuery.of(context).viewInsets + const EdgeInsets.only(bottom: 40),
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          ListTile(
              leading: const SFIcon(SFIcons.sf_star_fill,
                  color: CupertinoColors.systemYellow),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).hoverColor,
              title: const Text('Rate Us'),
              onTap: () async {
                // Show the rate dialog
                RateMyApp rateMyApp = RateMyApp(
                    appStoreIdentifier: Constants.appstoreIdentifier,
                    googlePlayIdentifier: '');

                await rateMyApp.init();
                context.mounted ? rateMyApp.showRateDialog(context) : null;
              }),
          const SizedBox(height: 10),
          ListTile(
            leading: const SFIcon(
              SFIcons.sf_book_and_wrench_fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Theme.of(context).hoverColor,
            title: const Text('Source Code'),
            onTap: () {
              // Open the source code link in the browser
              final url = Uri.parse(Constants.githubUrl);
              launchUrl(url);
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const SFIcon(SFIcons.sf_shield_fill),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Theme.of(context).hoverColor,
            title: const Text('Privacy Policy'),
            onTap: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: const Text('Privacy Policy'),
                    content: const Text(Constants.privacyPolicy),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const SFIcon(SFIcons.sf_info_circle_fill),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Theme.of(context).hoverColor,
            title: const Text('About'),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: 'Karekod - QR Code Generator',
                applicationVersion: '1.0.0',
                applicationIcon: const Image(
                  image: AssetImage('assets/appstore.png'),
                  width: 100,
                  height: 100,
                ),
                applicationLegalese: '© 2024 Osman Seferoglu',
              );
            },
          ),
        ],
      ),
    );
  }
}
