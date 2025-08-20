import 'package:flutter/material.dart';

class GridProvider extends ChangeNotifier {
  static const int gridCount = 10;
  static const int totalCells = gridCount * gridCount;

  int activeIndex = 0;
  void moveUp() {
    if (activeIndex >= gridCount) {
      activeIndex -= gridCount;
      notifyListeners();
    }
  }

  void moveDown() {
    if (activeIndex < totalCells - gridCount) {
      activeIndex += gridCount;
      notifyListeners();
    }
  }

  void moveRight() {
    if (activeIndex % gridCount != gridCount - 1) {
      activeIndex += 1;
      notifyListeners();
    }
  }

  void moveLeft() {
    if (activeIndex % gridCount != 0) {
      activeIndex -= 1;
      notifyListeners();
    }
  }
}
