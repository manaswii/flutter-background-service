import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pinger/pages/homepage.dart';
import 'package:pinger/pages/logs.dart';
import 'package:pinger/widgets/themes.dart';
import 'dart:async';

import 'utils/service.dart';

void main() {
  Service().run();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const Homepage(),
        "/logs": (context) => Logs(),
      },
    );
  }
}
