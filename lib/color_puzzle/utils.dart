

import 'dart:math';

import 'package:flutter/material.dart';

Color randomColor() {
  Random random = Random();
  return Color.fromARGB(180 + random.nextInt(76), random.nextInt(256),
      random.nextInt(256), random.nextInt(256));
}

List<Color> getColorsFromSingleColor(Color color, int count) {
  int alphaStart = 40;
  int diff = (color.alpha - alphaStart) ~/ count;
  List<Color> resultList = [];
  for (int i = 0; i < count; i++) {
    resultList.add(color.withAlpha(alphaStart + diff * i));
  }
  return resultList;
}