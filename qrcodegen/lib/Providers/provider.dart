import 'dart:math';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrProvider extends ChangeNotifier {
  // The data variable is used to store the data that will be used to generate the QR code.
  String _data = 'Karekod';
  String get data => _data;

  // The setData method is used to update the data variable.
  void setData(String value) {
    _data = value;
   
    notifyListeners();
  }

  // Color variable is used to store the color of the QR code.
  Color _color = CupertinoColors.systemBlue;
  Color get color => _color;
  // The setColor method is used to update the color variable.
  Future<void> setColor(Color value) async {
    await toggleTarget();

    _color = value;
    notifyListeners();
  }

  // Color options for the QR code.
  final List<Color> _colorOptions = [
    CupertinoColors.systemGrey, // Grey
    CupertinoColors.white, // White
    CupertinoColors.systemYellow, // Yellow
    CupertinoColors.systemMint, // Mint
    CupertinoColors.systemCyan, // Cyan
    CupertinoColors.systemTeal, // Teal
    CupertinoColors.systemGreen, // Green
    CupertinoColors.systemOrange, // Orange
    CupertinoColors.systemRed, // Red
    CupertinoColors.systemPink, // Pink
    CupertinoColors.systemPurple, // Purple
    CupertinoColors.systemIndigo, // Indigo
    CupertinoColors.systemBlue, // Blue
    CupertinoColors.systemBrown // Brown
  ];

  // The getColorOptions method is used to get the color options.
  List<Color> get colorOptions => _colorOptions;

  // The shuffleColor method is used to select a random color from the color options.
  Future<void> shuffleColor() async {
    // Toggle Animation
    await toggleTarget();

    // Create a random number generator
    Random random = Random();

    // Select a random index from the color options
    int randomIndex = random.nextInt(_colorOptions.length);

    // Set the selected color
    _color = _colorOptions[randomIndex];

    // Notify listeners to update the UI
    notifyListeners();
  }

  // Data type options for the QR code.
  final List<String> _dataType = ['URL', 'Text', 'Email', 'Phone'];
  List<String> get dataType => _dataType;

  // The selectedDataType variable is used to store the selected data type.
  String _selectedDataType = 'Text';
  String get selectedDataType => _selectedDataType;

  // The setSelectedDataType method is used to update the selectedDataType variable.
  Future<void> setSelectedDataType(String value) async {
    await toggleTarget();
    _selectedDataType = value;
    notifyListeners();
  }

  // Selected DataType icon
  IconData get selectedDataTypeIcon {
    switch (_selectedDataType) {
      case 'URL':
        return SFIcons.sf_link;
      case 'Text':
        return SFIcons.sf_character_cursor_ibeam;
      case 'Email':
        return SFIcons.sf_mail;
      case 'WiFi':
        return SFIcons.sf_wifi;
      default:
        return CupertinoIcons.link;
    }
  }

  // bool variable to show password field for wifi qr code.
  bool _showPassword = false;
  bool get showPassword => _showPassword;
  // The setShowPassword method is used to update the showPassword variable.
  void setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  // String variable to store the password for wifi qr code.
  String _password = '';
  String get password => _password;
  // The setPassword method is used to update the password variable.
  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  // Encryption type for wifi qr code.
  String _encryptionType = 'WPA';
  String get encryptionType => _encryptionType;
  // The setEncryptionType method is used to update the encryptionType variable.
  void setEncryptionType(String value) {
    toggleTarget();
    _encryptionType = value;
    notifyListeners();
  }

  // Slider value for border radius.
  double _borderRadius = 20;
  double get borderRadius => _borderRadius;
  // The setBorderRadius method is used to update the borderRadius variable.
  void setBorderRadius(double value) {
    _borderRadius = value;
    notifyListeners();
  }

  // Selected Image for the QR code.
  ImageProvider _selectedImage = const AssetImage('assets/logo.png');
  ImageProvider get selectedImage => _selectedImage;
  // The setSelectedImage method is used to update the selectedImage variable.
  void setSelectedImage(ImageProvider value) {
    toggleTarget();
    _selectedImage = value;
    notifyListeners();
  }

  // This method is used to delete the selected image.
  void deleteImage() {
    toggleTarget();
    _selectedImage = const AssetImage('assets/logo.png');
    notifyListeners();
  }

  // Image size variable for the QR code.
  double _imageSize = 50;
  double get imageSize => _imageSize;
  // The setImageSize method is used to update the imageSize variable.
  void setImageSize(double value) {
    _imageSize = value;
    notifyListeners();
  }

  // Corner radius for the QR code.
  double _cornerRadius = 20;
  double get cornerRadius => _cornerRadius;
  // The setCornerRadius method is used to update the cornerRadius variable.
  void setCornerRadius(double value) {
    _cornerRadius = value;
    notifyListeners();
  }

  // Eye style for the QR code.
  QrEyeShape _eyeStyle = QrEyeShape.square;
  QrEyeShape get eyeStyle => _eyeStyle;
  // The setEyeStyle method is used to update the eyeStyle variable.
  void setEyeStyle(QrEyeShape value) {
    toggleTarget();
    _eyeStyle = value;

    notifyListeners();
  }

  // Screenshot controller for the QR code.
  final ScreenshotController _screenshotController = ScreenshotController();
  ScreenshotController get screenshotController => _screenshotController;

  // This method is used to take a screenshot of the QR code.
  void takeScreenshot() {
    _isLoading = true;
    notifyListeners();
    _screenshotController.capture().then((image) async {
      final directory = await getApplicationDocumentsDirectory();
      final file = io.File(
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(image!);
      Share.shareXFiles([XFile(file.path)]);
    });
    _isLoading = false;
    notifyListeners();
  }

  // Hint text for the data field.
  String get hintText {
    switch (_selectedDataType) {
      case 'URL':
        return 'https://www.osmanseferoglu.com';
      case 'Text':
        return 'Hello, World!';
      case 'Email':
        return 'JohnDoe@Mail.com';
      case 'WiFi':
        return 'Network Name';
    }
    return '';
  }

  String get qrData {
    switch (_selectedDataType) {
      case 'URL':
        return data;
      case 'Text':
        return data;
      case 'Email':
        return data;
      case 'WiFi':
        return 'WIFI:S:$data;T:$encryptionType;P:$password;;';
    }
    return '';
  }

  // Loading state variable.
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // The setLoading method is used to update the isLoading variable.
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // bool variable to show description for the QR code.
  bool _showDescription = false;
  bool get showDescription => _showDescription;
  // The setShowDescription method is used to update the showDescription variable.
  void setShowDescription(bool value) {
    _showDescription = value;
    notifyListeners();
  }

  bool _target = false;
  bool get target => _target;
  Future<void> toggleTarget() async {
    _target = !_target;
    notifyListeners();
  }
}
