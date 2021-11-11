import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List colors() {
  List c = [];
  for (int i = 0; i < 12; i++) {
    c.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
  }
  return c;
}

class _MyHomePageState extends State<MyHomePage> {
  List c = colors();
  List list = [];
  var height = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(children: [
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: List.generate(c.length, (index) {
                return Draggable(
                  feedback: Container(
                    height: 100,
                    width: 100,
                    color: c[index],
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: c[index],
                  ),
                  data: c[index],
                );
              })),
          SizedBox(
            height: 40,
          ),
          DragTarget<Color>(
            builder: (BuildContext context, List<Object?> candidateData,
                List<dynamic> rejectedData) {
              return Container(
                height: height,
                child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: list[index],
                      );
                    }),
              );
            },
            onAccept: (data) {
              setState(() {
                list.add(data);
                print('Drpped');
                height += 50;
              });
            },
          )
        ]),
      ]),
    );
  }
}
