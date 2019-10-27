import 'package:flutter/material.dart';
import 'package:flutter_game/color_puzzle/color_puzzle_data.dart';

typedef IsAccepted<T extends PuzzleData> = bool Function(T fromData, T toData);

class TargetColor extends StatefulWidget {
  final PuzzleData acceptedData;
  final ShowColor showColor;
  final IsAccepted<PuzzleData> callback;
  final double size;
  final VoidCallback dragFinishCallback;

  TargetColor(this.acceptedData, this.showColor, this.callback, this.size,
      this.dragFinishCallback);

  @override
  _TargetColorState createState() => _TargetColorState();
}

class _TargetColorState extends State<TargetColor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DragTarget<PuzzleData>(
        builder: (context, candidateData, rejectedData) {
          return ColorSquare(
            color: widget.showColor.color,
            size: widget.size,
            borderColor: widget.showColor.borderColor,
          );
        },
        onWillAccept: (PuzzleData fromData) {
          debugPrint('onWillAccept()');
          if (widget.acceptedData.isCorrect) return false;
          bool isAccepted = widget.callback(fromData, widget.acceptedData);
          Color hintColor = isAccepted ? Colors.green : Colors.pinkAccent;
          setState(() {
            widget.showColor.borderColor = hintColor;
          });
          return isAccepted;
        },
        onAccept: (PuzzleData fromData) {
          debugPrint('onAccept()');
          bool isAccepted = widget.callback(fromData, widget.acceptedData);
          if (isAccepted) {
            setState(() {
              widget.showColor.borderColor = Colors.white;
              widget.showColor.color = fromData.color;
              widget.acceptedData.isCorrect = true;
            });
          }

          widget.dragFinishCallback();
        },
        onLeave: (PuzzleData fromData) {
          debugPrint('onLeave()');
          setState(() {
            widget.showColor.borderColor = defaultBorder;
          });
        },
      ),
    );
  }
}

class ColorSquare extends StatelessWidget {
  final Color color;
  final double size;
  final Color borderColor;

  const ColorSquare({
    Key key,
    @required this.color,
    @required this.size,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(size / 6);
    final Color background = Colors.white;
    final Border border = Border.all(
      color: borderColor,
      width: 2,
    );
    return Container(
      decoration: BoxDecoration(borderRadius: radius, color: background),
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: radius, border: border, color: color)),
    );
  }
}
