import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:async';
import 'package:pinger/utils/function.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SLAC pinger"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var time = const Duration(seconds: 10);
            var x = 1;
            Timer.periodic(time, (timer) {
              x += 1;
              Ping().writeCounter(x);
              Ping().readCounter();
            });
          },
          child: const Text(
            "Ping",
            style: TextStyle(fontSize: 19),
          ),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 100),
            shape: const CircleBorder(
                side: BorderSide(
              color: Colors.deepOrange,
              width: 1,
            )),
          ),
        ),
      ),
    );
  }
}
