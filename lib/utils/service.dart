import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pinger/utils/function.dart';

int flag = 0;

//1 = foreground, 2 = background, 0 = disabled;

class Service {
  run() {
    WidgetsFlutterBinding.ensureInitialized();
    initializeService();
  }

  int getFlagValue() {
    return flag;
  }

  void setFlagValue(int x) {
    flag = x;
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event!["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      flag = 1;
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
      flag = 2;
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
      Ping().writeAsString('service stopped');
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(Duration(seconds: 15), (timer) async {
    if (!(await service.isServiceRunning())) {
      print('service closed');
      timer.cancel();
    }

    service.setNotificationInfo(
      title: "My App Service runninnn",
      content: "Updated at ${DateTime.now()}",
    );
    printDate('hello');
    print('\nvalue of flag is : $flag\n');
    if (flag == 1) {
      Ping().writeDateInForeground();
    }
    if (flag == 2) {
      Ping().writeDateInBackground();
    }

    // service.sendData(
    //   {"current_date": DateTime.now().toIso8601String()},
    // );
  });
}

void printDate(var string) {
  print('$string it is today my dudes\n');
}
