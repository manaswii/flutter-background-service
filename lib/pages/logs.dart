import 'package:flutter/material.dart';
import 'package:pinger/utils/function.dart';

class Logs extends StatefulWidget {
  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.indigo,
          body: Column(children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                height: 500,
                width: 400,
                color: Colors.indigo,
                padding: EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder<String>(
                      future: Ping().readCounter(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          var text = snapshot.data;
                          if (text != null) {
                            return Text(text);
                          }
                        }
                        return Text('Loading');
                      }),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Ping().clearCounter();
                  setState(() {});
                },
                child: Text('Clear LOGS')),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Update')),
          ])),
    );
  }
}
