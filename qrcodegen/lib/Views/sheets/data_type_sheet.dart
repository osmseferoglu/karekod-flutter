import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:karekod/Providers/provider.dart';
import 'package:provider/provider.dart';

class DataTypeSheet extends StatelessWidget {
  const DataTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QrProvider>(context, listen: true);
    return Container(
      margin:
          MediaQuery.of(context).viewInsets + const EdgeInsets.only(bottom: 40),
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const Icon(Icons.text_fields),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: prov.selectedDataType != 'Text'
                ? Theme.of(context).hoverColor
                : prov.color.withOpacity(0.5),
            title: const Text('Text'),
            onTap: () {
              // Set the data type to Text
              // This will be used to generate the Text
              prov.setSelectedDataType('Text');
              prov.setShowPassword(false);
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const SFIcon(SFIcons.sf_link),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: prov.selectedDataType != 'URL'
                ? Theme.of(context).hoverColor
                : prov.color.withOpacity(0.5),
            title: const Text('URL'),
            onTap: () {
              // Set the data type to URL
              // This will be used to generate the URL
              prov.setSelectedDataType('URL');
              prov.setShowPassword(false);
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const SFIcon(SFIcons.sf_wifi),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: prov.selectedDataType != 'WiFi'
                ? Theme.of(context).hoverColor
                : prov.color.withOpacity(0.5),
            title: const Text('WiFi'),
            onTap: () {
              // Set the data type to wifi
              // This will be used to generate the wifi qr code
              prov.setSelectedDataType('WiFi');
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
