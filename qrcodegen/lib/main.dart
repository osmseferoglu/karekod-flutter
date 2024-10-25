import 'package:flutter/material.dart';
import 'package:karekod/Constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:karekod/Providers/provider.dart';
import 'package:karekod/Views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QrProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.black),
          filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
