import 'package:flutter/material.dart';

import 'package:flutter_drag_to_pop/flutter_drag_to_pop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tap image and drag around'),
        ),
        body: Center(
          child: DragToPop(
            closeWidget: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.network(
                'https://th.bing.com/th/id/OIP.eGeQuTMPlWngOAWRCV-LjQHaE8?pid=Api&rs=1',
              ),
            ),
            openWidget: Image.network(
              'https://th.bing.com/th/id/OIP.eGeQuTMPlWngOAWRCV-LjQHaE8?pid=Api&rs=1',
            ),
            openOverlayWidget: Column(
              children: [
                AppBar(
                  leading: CloseButton(),
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                )
              ],
            ),
            openBackgroundColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
