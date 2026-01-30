import 'package:flutter/material.dart';
import 'package:flutter_two/presentation/splash/pages/splash.dart';

import 'core/configs/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:AppTheme.lightTheme,
      home: SplashPage(),
    );
  }
}
