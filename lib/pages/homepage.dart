import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:async';
import 'package:pinger/utils/function.dart';
import 'package:pinger/utils/service.dart';

var string1 = '';

void setstring() {
  int flag = Service().getFlagValue();
  if (flag == 0) {
    string1 = 'Service disabled';
  } else if (flag == 1) {
    string1 = 'In foreground';
  } else if (flag == 2) {
    string1 = 'In Background';
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String text = "Stop Service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SLAC Pinger'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.indigo,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Logs",
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/logs");
                },
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          ElevatedButton(
            onPressed: () async {
              FlutterBackgroundService()
                  .sendData({"action": "setAsBackground"});
              Service().setFlagValue(2);
              setState(() {
                setstring();
              });
            },
            child: const Text(
              "Ping in background",
              style: TextStyle(fontSize: 19),
            ),
            // style: ElevatedButton.styleFrom(
            //   fixedSize: const Size(100, 100),
            //   shape: const CircleBorder(
            //       side: BorderSide(
            //     color: Colors.deepOrange,
            //     width: 1,
            //   )),
            // ),
          ),
          ElevatedButton(
            onPressed: () async {
              FlutterBackgroundService()
                  .sendData({"action": "setAsForeground"});
              Service().setFlagValue(1);
              setState(() {
                setstring();
              });
            },
            child: const Text(
              "Ping in foreground",
              style: TextStyle(fontSize: 19),
            ),
          ),
          ElevatedButton(
            child: Text(text),
            onPressed: () async {
              final service = FlutterBackgroundService();
              var isRunning = await service.isServiceRunning();
              if (isRunning) {
                service.sendData(
                  {"action": "stopService"},
                );
              } else {
                service.start();
              }

              if (!isRunning) {
                text = 'Stop Service';
              } else {
                text = 'Start Service';
              }
              setState(() {});
            },
          ),
          Text('current mode: $string1'),
        ]),
      ),
    );
  }
}
