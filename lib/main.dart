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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable & DragTarget'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Draggable(
                  child: ColorSquare(color: Colors.orange),
                  feedback: ColorSquare(color: Colors.orange),
                  data: Colors.orange),
              SizedBox(height: 20, width: 20),
              Draggable(
                  child: ColorSquare(color: Colors.lightGreen),
                  feedback: ColorSquare(color: Colors.lightGreen),
                  data: Colors.lightGreen),
            ],
          ),
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
