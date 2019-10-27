
import 'dart:ui';

import 'package:flutter/material.dart';

const Color defaultBorder = Color(0xffffffff);

class ShowColor {
  Color color;
  Color borderColor = defaultBorder;

  ShowColor(this.color, this.borderColor);
}

class PuzzleData {
  Color color;
  bool isCorrect;
  Color borderColor;

  PuzzleData(
      this.color, {
        this.isCorrect = false,
        this.borderColor = defaultBorder,
      });
}
