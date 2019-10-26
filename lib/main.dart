import 'package:flutter/material.dart';

void main() => runApp(DragGameApp());

class DragGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyGame',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Draggable(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                feedback: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Draggable(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
                feedback: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
