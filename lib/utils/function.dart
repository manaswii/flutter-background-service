import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Ping {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeDateInBackground() async {
    final file = await _localFile;
    print('printing in background');
    // Write the file
    return file.writeAsString(
        '${DateTime.now().toIso8601String()} background\n',
        mode: FileMode.append);
  }

  Future<File> writeDateInForeground() async {
    final file = await _localFile;
    // Write the file
    print('printing in foreground');
    return file.writeAsString(
        '${DateTime.now().toIso8601String()} foreground\n',
        mode: FileMode.append);
  }

  Future<File> writeAsString(var string) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(
        '$string at ${DateTime.now().toIso8601String()} \n',
        mode: FileMode.append);
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'error';
    }
  }

  Future<File> clearCounter() async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(
      ' ',
    );
  }

  Future func() async {
    await Future.delayed(const Duration(seconds: 20));
    return 'hello';
  }
}
