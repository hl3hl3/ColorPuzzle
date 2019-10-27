
import 'package:flutter/material.dart';
import 'package:flutter_game/color_puzzle/target_item.dart';
import 'package:flutter_game/color_puzzle/color_puzzle_data.dart';

class DraggableColor<T extends PuzzleData> extends StatefulWidget {
  final PuzzleData _data;
  final double size;

  DraggableColor(this._data, this.size);

  @override
  _DraggableColorState<T> createState() => _DraggableColorState<T>();
}

class _DraggableColorState<T extends PuzzleData> extends State<DraggableColor> {
  @override
  Widget build(BuildContext context) {
    debugPrint('size=${widget.size}');
    ColorSquare showSquare = ColorSquare(
      color: widget._data.color,
      size: widget.size,
      borderColor: Colors.white,
    );

    ColorSquare feedbackSquare = ColorSquare(
      color: widget._data.color,
      size: widget.size,
      borderColor: Colors.white,
    );

    return Container(
      child: widget._data.isCorrect
          ? Stack(
        children: <Widget>[
          showSquare,
          Center(
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: widget.size / 2,
            ),
          )
        ],
      )
          : Draggable(
        child: showSquare,
        feedback: feedbackSquare,
        childWhenDragging: Opacity(
          child: showSquare,
          opacity: 0,
        ),
        data: widget._data,
        onDragCompleted: () {
          setState(() {
            widget._data.isCorrect = true;
          });
        },
      ),
    );
  }
}
