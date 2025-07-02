import 'package:flutter/material.dart';

class TMAState extends ChangeNotifier {
  final ValueNotifier<double> height = ValueNotifier(0);

  double toHeight(double value) {
    return value / 100.0 * height.value;
  }

  change(double div) {
    height.value += div;
  }

  final ValueNotifier<bool> isLoading = ValueNotifier(true);
}
