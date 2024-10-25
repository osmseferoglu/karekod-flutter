import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:karekod/Providers/provider.dart';

Future pickImage(QrProvider prov) async {
    try {
      final image = await ImagePicker()
          .pickImage(imageQuality: 30, source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      prov.setSelectedImage(FileImage(imageTemp));
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }