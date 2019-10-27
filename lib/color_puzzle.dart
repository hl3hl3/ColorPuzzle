import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/color_puzzle/draggable_item.dart';
import 'package:flutter_game/color_puzzle/target_item.dart';
import 'package:flutter_game/color_puzzle/utils.dart';
import 'package:flutter_game/color_puzzle/color_puzzle_data.dart';

void main() => runApp(DraggableColorPuzzle());

class DraggableColorPuzzle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable Color Puzzle',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        buttonColor: Colors.pink,
      ),
      home: ColorPuzzlePage(),
    );
  }
}

const double HORIZONTAL_PAGE_PADDING = 16;
const double HORIZONTAL_ITEM_PADDING = 4;

class ColorPuzzlePage extends StatefulWidget {
  ColorPuzzlePage() {}

  @override
  _ColorPuzzlePageState createState() => _ColorPuzzlePageState();
}

class _ColorPuzzlePageState extends State<ColorPuzzlePage> {
  final List<int> LEVEL = [6, 12, 24, 32, 48, 64];
  final List<int> COLUMN = [6, 6, 6, 8, 8, 8];

  bool isGameDone = false;
  int nowLevel = 0;
  int columnCount = 3;

  List<PuzzleData> targetData;

  List<PuzzleData> fromData;

  final Function accepted = (PuzzleData dragged, PuzzleData target) {
    return dragged.color.value == target.color.value;
  };

  @override
  void initState() {
    super.initState();

    newPuzzle();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width < screenSize.height
        ? screenSize.width
        : screenSize.height;
    columnCount = COLUMN[nowLevel];
    double size = (width -
            (HORIZONTAL_PAGE_PADDING * 2) -
            (columnCount - 1) * HORIZONTAL_ITEM_PADDING) /
        columnCount;
    debugPrint('screen width = $width, size=$size');

    List<Widget> targetItems = targetData.map((data) {
      var defaultColor =
          ShowColor(data.isCorrect ? data.color : Colors.white, defaultBorder);
      return TargetColor(data, defaultColor, accepted, size, _onDragFinish);
    }).toList();
    List<Widget> fromItems =
        fromData.map((data) => DraggableColor(data, size)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Color Puzzle'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _mainButton('新顏色', () {
                  setState(() {
                    newPuzzle();
                  });
                }),
                _mainButton('重設', () {
                  setState(() {
                    resetPuzzle();
                  });
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _levelButton('6色', 0),
                _levelButton('12色', 1),
                _levelButton('24色', 2),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _levelButton('32色', 3),
                _levelButton('48色', 4),
                _levelButton('64色', 5),
              ],
            ),
            isGameDone
                ? Text(
                    '完成！',
                    style: TextStyle(color: Colors.green, fontSize: 24),
                  )
                : Text(''),
            ColorGrid(columnCount, targetItems, '填滿這些顏色！'),
            ColorGrid(columnCount, fromItems, '可拖曳的顏色'),
          ],
        ),
      ),
    );
  }

  _onDragFinish() {
    bool hasNotCorrectItem = targetData.any((data) {
      return data.isCorrect == false;
    });

    if (!hasNotCorrectItem) {
      setState(() {
        isGameDone = true;
      });
    }
  }

  _levelButton(String text, int level) {
    return _mainButton(text, () {
      setState(() {
        nowLevel = level;
        initiatePuzzle(getColorsFromSingleColor(_nowColor, LEVEL[nowLevel]));
      });
    });
  }

  _mainButton(String text, var callback) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: RaisedButton(
        child: Text(text),
        textColor: Colors.white,
        onPressed: callback,
      ),
    );
  }

  Color _nowColor;

  void newPuzzle() {
    _nowColor = randomColor();
    var data = getColorsFromSingleColor(randomColor(), LEVEL[nowLevel]);
    initiatePuzzle(data);
  }

  void showRowHint(int row, int columnCount) {
    targetData[row * columnCount].isCorrect = true;
    targetData[(columnCount - 1) + row * columnCount].isCorrect = true;
  }

  void initiatePuzzle(List<Color> colors) {
    targetData = colors.map((color) => PuzzleData(color)).toList();
    colors.shuffle();
    fromData = colors.map((color) => PuzzleData(color)).toList();

    showHint();
    isGameDone = false;
  }

  void resetPuzzle() {
    targetData =
        targetData.map((puzzleData) => PuzzleData(puzzleData.color)).toList();
    fromData =
        fromData.map((puzzleData) => PuzzleData(puzzleData.color)).toList();

    showHint();
    isGameDone = false;
  }

  void showHint() {
    // hint
    int level = LEVEL[nowLevel];
    int column = COLUMN[nowLevel];
    int rows = level ~/ column;

    showRowHint(0, column); // first row
    showRowHint(rows - 1, column); // last row
  }
}

class ColorGrid extends StatelessWidget {
  final int columnCount;
  final List<Widget> list;
  final String title;

  ColorGrid(this.columnCount, this.list, this.title);

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.black45,
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: decoration,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(HORIZONTAL_PAGE_PADDING),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: columnCount,
              children: list,
              crossAxisSpacing: HORIZONTAL_ITEM_PADDING,
              mainAxisSpacing: HORIZONTAL_ITEM_PADDING,
            ),
          ),
        ],
      ),
    );
  }
}
