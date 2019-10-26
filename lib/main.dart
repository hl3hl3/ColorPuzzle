import 'package:flutter/material.dart';

void main() => runApp(DragGameApp());

class DragGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyGame',
      theme: ThemeData(primarySwatch: Colors.green),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MaterialColor _acceptedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable & DragTarget'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Draggable(
                      child: ColorSquare(color: Colors.orange),
                      feedback: ColorSquare(color: Colors.orange),
                      childWhenDragging: ColorSquare(color: Colors.deepOrange),
                      data: Colors.orange),
                  SizedBox(height: 20, width: 20),
                  Draggable(
                    child: ColorSquare(color: Colors.lightGreen),
                    feedback: ColorSquare(color: Colors.lightGreen),
                    childWhenDragging: ColorSquare(color: Colors.green),
                    data: Colors.lightGreen,
                    onDragStarted: () {
                      debugPrint('onDragStarted(), 開始拖動');
                    },
                    onDraggableCanceled: (Velocity velocity, Offset offset) {
                      debugPrint('onDraggableCanceled(), 被放掉＋沒被接受');
                    },
                    onDragCompleted: () {
                      debugPrint('onDragCompleted(), 被放掉＋接受');
                    },
                    onDragEnd: (DraggableDetails details) {
                      debugPrint('onDragEnd(), 被放掉');
                    },
                  ),
                ],
              ),
            ),
            DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 200,
                  height: 200,
                  color: _acceptedColor,
                );
              },
              onWillAccept: (MaterialColor data) {
                debugPrint('onWillAccept()');
                return true;
              },
              onAccept: (MaterialColor data) {
                debugPrint('onAccept()');
                setState(() {
                  _acceptedColor = data;
                });
              },
              onLeave: (MaterialColor data) {
                debugPrint('onLeave()');
                setState(() {
                  _acceptedColor = Colors.grey;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

const double squareWidth = 100;

class ColorSquare extends StatelessWidget {
  final Color color;

  const ColorSquare({
    Key key,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: squareWidth,
      height: squareWidth,
      color: color,
    );
  }
}
