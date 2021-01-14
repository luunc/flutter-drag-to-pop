import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import 'package:flutter_drag_to_pop/flutter_drag_to_pop.dart';

RandomColor _randomColor = RandomColor();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Drag to pop examples'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) => RaisedButton(
                    child: Text('Image Example'),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ImageExampleScreen()),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => RaisedButton(
                    child: Text('Grid Example'),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => GridExampleScreen()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

/////////////////////////////////////////////////////////////////////////////

class ImageExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

/////////////////////////////////////////////////////////////////////////////

class GridExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap grid item and drag around'),
      ),
      body: GridView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => DragToPop(
          closeWidget: ContainerItem(index: index),
          openWidget: FullScreen(index: index),
          minOverlayOpacity: 0.25,
          maxOverlayOpacity: 0.65,
          verticalOpacityDragRate: 8,
          horizontalOpacityDragRate: 6,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

class ContainerItem extends StatelessWidget {
  final int index;
  final color =
      _randomColor.randomColor(colorBrightness: ColorBrightness.veryLight);

  ContainerItem({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          color: color,
          child: Text('$index'),
        ),
      );
}

class FullScreen extends StatelessWidget {
  final int index;

  const FullScreen({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Full screen $index'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: RaisedButton(
            child: Text('$index'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => GridExampleScreen()),
            ),
          ),
        ),
      ),
    );
  }
}
