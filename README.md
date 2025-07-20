# Karekod - QR Code Generator

A modern, feature-rich Flutter application for generating customizable QR codes with a beautiful Material Design 3 interface.

![Karekod QR Code Generator](https://img.shields.io/badge/Flutter-3.5.2+-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.1-green.svg)
![License](https://img.shields.io/badge/license-MIT-yellow.svg)

## App Store Listing Images

<div align="start">
  <img src="https://github.com/osmseferoglu/karekod-flutter/blob/main/images/01.png?raw=true" width="200" alt="App Screenshot 1"/>
  <img src="https://github.com/osmseferoglu/karekod-flutter/blob/main/images/02.png?raw=true" width="200" alt="App Screenshot 2"/>
  <img src="https://github.com/osmseferoglu/karekod-flutter/blob/main/images/03.png?raw=true" width="200" alt="App Screenshot 3"/>
  <!-- Add more images as needed -->
</div>

## 📱 Features

### 🎨 **Customizable QR Codes**
- **Multiple Data Types**: URL, Text, Email, Phone, WiFi
- **Color Customization**: 14 predefined colors with random color shuffle
- **Border Styling**: Customizable border width and style
- **Corner Styling**: Adjustable corner radius and style
- **Eye Styling**: Customizable QR code eye patterns
- **Background Images**: Add custom images to QR codes

### 🛠 **Advanced Functionality**
- **Real-time Preview**: See QR code changes instantly
- **Screenshot & Share**: Capture and share QR codes
- **Haptic Feedback**: Tactile response for better UX
- **Dark/Light Theme**: Automatic theme switching
- **Responsive Design**: Works on all screen sizes

### 📱 **Platform Support**
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.5.2 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)
- Android Emulator (for Android development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/osmseferoglu/karekod-flutter.git
   cd karekod-flutter/qrcodegen
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📦 Dependencies

The project uses the following key dependencies:

- **`qr_flutter`** - QR code generation
- **`provider`** - State management
- **`image_picker`** - Image selection
- **`screenshot`** - QR code capture
- **`share_plus`** - Share functionality
- **`haptic_feedback`** - Tactile feedback
- **`flutter_animate`** - Smooth animations
- **`url_launcher`** - URL handling
- **`rate_my_app`** - App rating prompts

## 🏗 Project Structure

```
lib/
├── Components/          # Reusable UI components
│   ├── bottomsheet.dart
│   ├── filledbutton.dart
│   └── textfield.dart
├── Constants/           # App constants
│   └── constants.dart
├── Providers/           # State management
│   └── provider.dart
├── Utilities/           # Utility functions
│   └── image_picker.dart
├── Views/               # UI screens
│   ├── home.dart        # Main screen
│   └── sheets/          # Bottom sheet components
│       ├── border_sheet.dart
│       ├── color_sheet.dart
│       ├── corner_sheet.dart
│       ├── data_type_sheet.dart
│       ├── eye_sheet.dart
│       ├── image_sheets.dart
│       └── settings_sheet.dart
└── main.dart           # App entry point
```

## 🎯 Usage

### Basic QR Code Generation
1. Open the app
2. Enter your text, URL, email, or phone number
3. Select the appropriate data type
4. Customize colors, borders, and styling as needed
5. Use the share button to save or share your QR code

### Advanced Customization
- **Colors**: Tap the shuffle button for random colors or use the color picker
- **Borders**: Adjust border width and style in the border settings
- **Corners**: Customize corner radius and appearance
- **Eyes**: Modify the QR code eye patterns
- **Background**: Add custom images to your QR codes

## 🔧 Configuration

### App Constants
Edit `lib/Constants/constants.dart` to modify:
- App name
- GitHub URL
- Privacy policy
- App store identifiers

### Theme Customization
The app uses Material Design 3 with:
- Dark/light theme support
- Custom color schemes
- Responsive design

## 📱 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Osman Seferoğlu**
- GitHub: [@osmseferoglu](https://github.com/osmseferoglu)
- Project: [Karekod Flutter](https://github.com/osmseferoglu/karekod-flutter)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- QR Flutter package maintainers
- All contributors and users

## 📞 Support

If you encounter any issues or have questions:
- Create an issue on GitHub
- Check the existing issues for solutions
- Review the documentation

---

⭐ **Star this repository if you find it helpful!**




### Download on the App Store
[![Download on the App Store](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Download_on_the_App_Store_Badge.svg/144px-Download_on_the_App_Store_Badge.svg.png?20170219160111)](https://apps.apple.com/app/karekod-qr-code-generator/id6737271009)
