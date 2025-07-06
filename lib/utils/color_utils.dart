import 'package:flutter/material.dart';

class ColorUtils {
  /// Converts a list of Color objects to a list of int values for serialization
  static List<int> colorsToInts(List<Color> colors) {
    return colors.map((color) => color.toARGB32()).toList();
  }

  /// Converts a list of int values to a list of Color objects
  static List<Color> intsToColors(List<int> intValues) {
    return intValues.map((value) => Color(value)).toList();
  }

  /// Creates a LinearGradient from int values
  static LinearGradient createGradientFromInts(
    List<int> colorValues, {
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      colors: intsToColors(colorValues),
      begin: begin,
      end: end,
    );
  }
}
