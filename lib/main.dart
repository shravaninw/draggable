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

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> c = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
  ];
  List s = ['Hi', 'Hello', 'Good'];
  List list = [];
  var height = 350.0;
  List st = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(children: [
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(c.length, (index) {
                return Draggable(
                  feedback: Container(
                    height: 80,
                    width: 80,
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
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(s.length, (index) {
                return Container(
                  height: 80,
                  width: 80,
                  child: Draggable(
                    feedback: Center(
                        child: Text(
                      s[index],
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    )),
                    child: Center(child: Text(s[index])),
                    data: s[index],
                  ),
                );
              })),
          SizedBox(
            height: 20,
          ),
          DragTarget<Color>(
            builder: (BuildContext context, List<Object?> candidateData,
                List<dynamic> rejectedData) {
              return Container(
                color: Colors.brown,
                height: height,
                child: ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DragTarget(
                          builder: (BuildContext context,
                              List<Object?> candidateData,
                              List<dynamic> rejectedData) {
                            return Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              color: list[i],
                              child: Text(
                                st[i],
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                          onAccept: (String data) {
                            setState(() {
                              st[i] = data;
                              print(data);
                              print(st);
                            });
                          },
                        ),
                      );
                    }),
              );
            },
            onAccept: (data) {
              setState(() {
                list.add(data);
                print('Drpped');
                height += 50;
                st.add('');
                print(st);
              });
            },
          )
        ]),
      ]),
    );
  }
}
