import 'package:flutter/material.dart';

/// Utility class for color manipulation and conversion operations.
class ColorUtils {
  /// Converts a list of [Color] objects to a list of int values for serialization.
  ///
  /// Useful for storing colors in JSON or other serialization formats.
  static List<int> colorsToInts(List<Color> colors) {
    return colors.map((color) => color.toARGB32()).toList();
  }

  /// Converts a list of int values to a list of [Color] objects.
  ///
  /// Useful for deserializing colors from JSON or other formats.
  static List<Color> intsToColors(List<int> intValues) {
    return intValues.map((value) => Color(value)).toList();
  }

  /// Creates a [LinearGradient] from a list of int color values.
  ///
  /// The [begin] and [end] parameters control the gradient direction.
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
