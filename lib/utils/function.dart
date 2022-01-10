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

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter ', mode: FileMode.append);
  }

  Future readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      print('hi');
      print(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future func() async {
    await Future.delayed(const Duration(seconds: 20));
    return 'hello';
  }
}
