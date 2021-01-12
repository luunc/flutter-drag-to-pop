# flutter_drag_to_pop

Tap a widget for fullscreen display and drag around to pop

![Demo](https://media.giphy.com/media/jBPORftNtq77Q2Lalg/giphy.gif)

## Getting Started
1) include the package to your project as dependency:

```
dependencies:
  	flutter_drag_to_pop: <latest version>
```

2) Use the widget

```dart
    DragToPop(
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
    );
```
