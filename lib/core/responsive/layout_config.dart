import 'package:flutter/material.dart';
import 'device_type.dart';

class LayoutConfig extends ResponsiveConfig {
  final double columnWidth;
  final double cardHeight;
  final double listHeight;
  final int cardsPerColumn;
  final int gridColumns;
  final double cardAspectRatio;
  final double horizontalPadding;
  final double columnSpacing;
  final double dividerLeftMargin;
  final double thumbnailWidth;
  final double thumbnailHeight;
  final EdgeInsets cardPadding;
  final double contentSpacing;
  final double cardVerticalSpacing;
  final double headerPadding;
  final double headerVerticalPadding;
  final double iconContainerSize;
  final double categoryTabHeight;
  final double dateCalendarHeight;
  final bool isTablet;

  const LayoutConfig({
    required this.columnWidth,
    required this.cardHeight,
    required this.listHeight,
    required this.cardsPerColumn,
    required this.gridColumns,
    required this.cardAspectRatio,
    required this.horizontalPadding,
    required this.columnSpacing,
    required this.dividerLeftMargin,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.cardPadding,
    required this.contentSpacing,
    required this.cardVerticalSpacing,
    required this.headerPadding,
    required this.headerVerticalPadding,
    required this.iconContainerSize,
    required this.categoryTabHeight,
    required this.dateCalendarHeight,
    required this.isTablet,
  });

  factory LayoutConfig.fromScreenSize(
    ScreenSize screenSize,
    double screenWidth,
  ) {
    switch (screenSize) {
      case ScreenSize.desktop:
        return LayoutConfig(
          columnWidth: screenWidth * 0.45,
          cardHeight: 100,
          listHeight: 420,
          cardsPerColumn: 4,
          gridColumns: 2,
          cardAspectRatio: 4.0,
          horizontalPadding: 24.0,
          columnSpacing: 24.0,
          dividerLeftMargin: 172,
          thumbnailWidth: 140,
          thumbnailHeight: 85,
          cardPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          contentSpacing: 18.0,
          cardVerticalSpacing: 12.0,
          headerPadding: 24.0,
          headerVerticalPadding: 16.0,
          iconContainerSize: 38.0,
          categoryTabHeight: 18.0,
          dateCalendarHeight: 110.0,
          isTablet: true,
        );
      case ScreenSize.tablet:
        return LayoutConfig(
          columnWidth: screenWidth * 0.75,
          cardHeight: 95,
          listHeight: 380,
          cardsPerColumn: 4,
          gridColumns: 1,
          cardAspectRatio: 3.5,
          horizontalPadding: 18.0,
          columnSpacing: 20.0,
          dividerLeftMargin: 162,
          thumbnailWidth: 130,
          thumbnailHeight: 82,
          cardPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          contentSpacing: 16.0,
          cardVerticalSpacing: 10.0,
          headerPadding: 20.0,
          headerVerticalPadding: 14.0,
          iconContainerSize: 36.0,
          categoryTabHeight: 15.0,
          dateCalendarHeight: 105.0,
          isTablet: false,
        );
      case ScreenSize.extraLarge:
        return LayoutConfig(
          columnWidth: screenWidth * 0.85,
          cardHeight: 92,
          listHeight: 350,
          cardsPerColumn: 3,
          gridColumns: 1,
          cardAspectRatio: 3.2,
          horizontalPadding: 18.0,
          columnSpacing: 20.0,
          dividerLeftMargin: 156,
          thumbnailWidth: 125,
          thumbnailHeight: 82,
          cardPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          contentSpacing: 15.0,
          cardVerticalSpacing: 9.0,
          headerPadding: 16.0,
          headerVerticalPadding: 12.0,
          iconContainerSize: 35.0,
          categoryTabHeight: 14.0,
          dateCalendarHeight: 70.0,
          isTablet: false,
        );
      case ScreenSize.large:
        return LayoutConfig(
          columnWidth: screenWidth * 0.84,
          cardHeight: 90,
          listHeight: 345,
          cardsPerColumn: 3,
          gridColumns: 1,
          cardAspectRatio: 3.1,
          horizontalPadding: 17.0,
          columnSpacing: 19.0,
          dividerLeftMargin: 154,
          thumbnailWidth: 123,
          thumbnailHeight: 81,
          cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          contentSpacing: 14.5,
          cardVerticalSpacing: 8.5,
          headerPadding: 15.0,
          headerVerticalPadding: 11.0,
          iconContainerSize: 34.0,
          categoryTabHeight: 12.0,
          dateCalendarHeight: 68.0,
          isTablet: false,
        );
      case ScreenSize.medium:
        return LayoutConfig(
          columnWidth: screenWidth * 0.83,
          cardHeight: 88,
          listHeight: 340,
          cardsPerColumn: 3,
          gridColumns: 1,
          cardAspectRatio: 3.0,
          horizontalPadding: 16.0,
          columnSpacing: 18.0,
          dividerLeftMargin: 152,
          thumbnailWidth: 120,
          thumbnailHeight: 80,
          cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          contentSpacing: 14.0,
          cardVerticalSpacing: 8.0,
          headerPadding: 13.0,
          headerVerticalPadding: 10.0,
          iconContainerSize: 32.0,
          categoryTabHeight: 10.0,
          dateCalendarHeight: 65.0,
          isTablet: false,
        );
      case ScreenSize.small:
        return LayoutConfig(
          columnWidth: screenWidth * 0.85,
          cardHeight: 82,
          listHeight: 320,
          cardsPerColumn: 3,
          gridColumns: 1,
          cardAspectRatio: 2.8,
          horizontalPadding: 14.0,
          columnSpacing: 16.0,
          dividerLeftMargin: 140,
          thumbnailWidth: 110,
          thumbnailHeight: 75,
          cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          contentSpacing: 12.0,
          cardVerticalSpacing: 6.0,
          headerPadding: 13.0,
          headerVerticalPadding: 8.0,
          iconContainerSize: 30.0,
          categoryTabHeight: 8.0,
          dateCalendarHeight: 60.0,
          isTablet: false,
        );
    }
  }

  double get subtitleMaxWidth => columnWidth * 0.65;
}
