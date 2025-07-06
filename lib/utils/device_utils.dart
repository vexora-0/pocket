import 'package:flutter/material.dart';

// DeviceInfo class for responsive configuration
class DeviceInfo {
  final bool isTablet;
  final double columnWidth;
  final double cardHeight;
  final double listHeight;
  final int cardsPerColumn;
  final int gridColumns;
  final double cardAspectRatio;
  final double subtitleMaxWidth;
  final double horizontalPadding;
  final double columnSpacing;
  final double dividerLeftMargin;
  final double dividerSpacing;
  final double thumbnailWidth;
  final double thumbnailHeight;
  final EdgeInsets cardPadding;
  final double contentSpacing;
  final double titleSubtitleSpacing;
  final double cardVerticalSpacing;
  // New responsive properties
  final double headerPadding;
  final double headerVerticalPadding;
  final double iconSize;
  final double iconContainerSize;
  final double titleFontSize;
  final double greetingFontSize;
  final double topSafeAreaPadding;
  final double categoryTabHeight;
  final double categoryTabPadding;
  final double dateCalendarHeight;
  // New vertical spacing parameters
  final double headerToCategoryTabsSpacing;
  final double categoryTabsToDividerSpacing;
  final double dividerToDateCalendarSpacing;
  final double dateCalendarHeaderToScrollerSpacing;
  final double dateCalendarScrollerToSelectedInfoSpacing;
  final double dateCalendarToConversationsSpacing;
  // Category tab icon specific parameters
  final double categoryTabIconWidth;
  final double categoryTabIconHeight;

  const DeviceInfo({
    required this.isTablet,
    required this.columnWidth,
    required this.cardHeight,
    required this.listHeight,
    required this.cardsPerColumn,
    required this.gridColumns,
    required this.cardAspectRatio,
    required this.subtitleMaxWidth,
    required this.horizontalPadding,
    required this.columnSpacing,
    required this.dividerLeftMargin,
    required this.dividerSpacing,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.cardPadding,
    required this.contentSpacing,
    required this.titleSubtitleSpacing,
    required this.cardVerticalSpacing,
    required this.headerPadding,
    required this.headerVerticalPadding,
    required this.iconSize,
    required this.iconContainerSize,
    required this.titleFontSize,
    required this.greetingFontSize,
    required this.topSafeAreaPadding,
    required this.categoryTabHeight,
    required this.categoryTabPadding,
    required this.dateCalendarHeight,
    required this.headerToCategoryTabsSpacing,
    required this.categoryTabsToDividerSpacing,
    required this.dividerToDateCalendarSpacing,
    required this.dateCalendarHeaderToScrollerSpacing,
    required this.dateCalendarScrollerToSelectedInfoSpacing,
    required this.dateCalendarToConversationsSpacing,
    required this.categoryTabIconWidth,
    required this.categoryTabIconHeight,
  });
}

class DeviceUtils {
  static DeviceInfo getDeviceInfo(double screenWidth, double screenHeight) {
    // Define breakpoints - Updated to better handle iPhone sizes
    if (screenWidth >= 900) {
      // Large tablets and desktops
      return DeviceInfo(
        isTablet: true,
        columnWidth: screenWidth * 0.45,
        cardHeight: 100,
        listHeight: 420,
        cardsPerColumn: 4,
        gridColumns: 2,
        cardAspectRatio: 4.0,
        subtitleMaxWidth: 200,
        horizontalPadding: 24.0,
        columnSpacing: 24.0,
        dividerLeftMargin: 172,
        dividerSpacing: 8,
        thumbnailWidth: 140,
        thumbnailHeight: 85,
        cardPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        contentSpacing: 18.0,
        titleSubtitleSpacing: 8.0,
        cardVerticalSpacing: 12.0,
        headerPadding: 24.0,
        headerVerticalPadding: 16.0,
        iconSize: 20.0,
        iconContainerSize: 38.0,
        titleFontSize: 28.0,
        greetingFontSize: 16.0,
        topSafeAreaPadding: 20.0,
        categoryTabHeight: 18.0,
        categoryTabPadding: 18.0,
        dateCalendarHeight: 110.0,
        headerToCategoryTabsSpacing: 16.0,
        categoryTabsToDividerSpacing: 18.0,
        dividerToDateCalendarSpacing: 8.0,
        dateCalendarHeaderToScrollerSpacing: 16.0,
        dateCalendarScrollerToSelectedInfoSpacing: 16.0,
        dateCalendarToConversationsSpacing: 24.0,
        categoryTabIconWidth: 46.0,
        categoryTabIconHeight: 33.0,
      );
    } else if (screenWidth >= 600) {
      // Small tablets and large phones (landscape)
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.75,
        cardHeight: 95,
        listHeight: 380,
        cardsPerColumn: 4,
        gridColumns: 1,
        cardAspectRatio: 3.5,
        subtitleMaxWidth: 180,
        horizontalPadding: 18.0,
        columnSpacing: 20.0,
        dividerLeftMargin: 162,
        dividerSpacing: 7,
        thumbnailWidth: 130,
        thumbnailHeight: 82,
        cardPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        contentSpacing: 16.0,
        titleSubtitleSpacing: 7.0,
        cardVerticalSpacing: 10.0,
        headerPadding: 20.0,
        headerVerticalPadding: 14.0,
        iconSize: 18.0,
        iconContainerSize: 36.0,
        titleFontSize: 26.0,
        greetingFontSize: 15.0,
        topSafeAreaPadding: 20.0,
        categoryTabHeight: 15.0,
        categoryTabPadding: 16.0,
        dateCalendarHeight: 105.0,
        headerToCategoryTabsSpacing: 14.0,
        categoryTabsToDividerSpacing: 16.0,
        dividerToDateCalendarSpacing: 7.0,
        dateCalendarHeaderToScrollerSpacing: 16.0,
        dateCalendarScrollerToSelectedInfoSpacing: 16.0,
        dateCalendarToConversationsSpacing: 20.0,
        categoryTabIconWidth: 44.0,
        categoryTabIconHeight: 31.0,
      );
    } else if (screenWidth >= 430) {
      // iPhone 14 Pro Max and similar large phones (428px logical width)
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.85,
        cardHeight: 92,
        listHeight: 350,
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 3.2,
        subtitleMaxWidth: 160,
        horizontalPadding: 18.0,
        columnSpacing: 20.0,
        dividerLeftMargin: 156,
        dividerSpacing: 7,
        thumbnailWidth: 125,
        thumbnailHeight: 82,
        cardPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        contentSpacing: 15.0,
        titleSubtitleSpacing: 7.0,
        cardVerticalSpacing: 9.0,
        headerPadding: 16.0,
        headerVerticalPadding: 12.0,
        iconSize: 18.0,
        iconContainerSize: 35.0,
        titleFontSize: 26.0,
        greetingFontSize: 15.0,
        topSafeAreaPadding: 30.0,
        categoryTabHeight: 14.0,
        categoryTabPadding: 15.0,
        dateCalendarHeight: 70.0,
        headerToCategoryTabsSpacing: 20.0,
        categoryTabsToDividerSpacing: 20.0,
        dividerToDateCalendarSpacing: 40.0,
        dateCalendarHeaderToScrollerSpacing: 20.0,
        dateCalendarScrollerToSelectedInfoSpacing: 40.0,
        dateCalendarToConversationsSpacing: 15.0,
        categoryTabIconWidth: 50.0,
        categoryTabIconHeight: 35.0,
      );
    } else if (screenWidth >= 410) {
      // iPhone XR and similar (414px logical width)
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.84,
        cardHeight: 91,
        listHeight: 348,
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 3.15,
        subtitleMaxWidth: 158,
        horizontalPadding: 17.0,
        columnSpacing: 19.0,
        dividerLeftMargin: 155,
        dividerSpacing: 6,
        thumbnailWidth: 124,
        thumbnailHeight: 81,
        cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        contentSpacing: 14.8,
        titleSubtitleSpacing: 6.8,
        cardVerticalSpacing: 8.8,
        headerPadding: 15.5,
        headerVerticalPadding: 11.5,
        iconSize: 17.5,
        iconContainerSize: 34.5,
        titleFontSize: 25.5,
        greetingFontSize: 14.8,
        topSafeAreaPadding: 20.0,
        categoryTabHeight: 13.0,
        categoryTabPadding: 14.5,
        dateCalendarHeight: 69.0,
        headerToCategoryTabsSpacing: 16.0,
        categoryTabsToDividerSpacing: 18.0,
        dividerToDateCalendarSpacing: 37.0,
        dateCalendarHeaderToScrollerSpacing: 18.0,
        dateCalendarScrollerToSelectedInfoSpacing: 37.0,
        dateCalendarToConversationsSpacing: 15.0,
        categoryTabIconWidth: 46.0,
        categoryTabIconHeight: 32.0,
      );
    } else if (screenWidth >= 390) {
      // iPhone 14, iPhone 13 Pro and similar (390px logical width)
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.84,
        cardHeight: 90,
        listHeight: 345,
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 3.1,
        subtitleMaxWidth: 155,
        horizontalPadding: 17.0,
        columnSpacing: 19.0,
        dividerLeftMargin: 154,
        dividerSpacing: 6,
        thumbnailWidth: 123,
        thumbnailHeight: 81,
        cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        contentSpacing: 14.5,
        titleSubtitleSpacing: 6.5,
        cardVerticalSpacing: 8.5,
        headerPadding: 15.0,
        headerVerticalPadding: 11.0,
        iconSize: 17.0,
        iconContainerSize: 34.0,
        titleFontSize: 25.0,
        greetingFontSize: 14.5,
        topSafeAreaPadding: 11.0,
        categoryTabHeight: 12.0,
        categoryTabPadding: 14.0,
        dateCalendarHeight: 68.0,
        headerToCategoryTabsSpacing: 11.0,
        categoryTabsToDividerSpacing: 16.0,
        dividerToDateCalendarSpacing: 35.0,
        dateCalendarHeaderToScrollerSpacing: 16.0,
        dateCalendarScrollerToSelectedInfoSpacing: 35.0,
        dateCalendarToConversationsSpacing: 15.0,
        categoryTabIconWidth: 42.0,
        categoryTabIconHeight: 29.0,
      );
    } else if (screenWidth >= 350) {
      // Regular phones including OnePlus 11R baseline (375px logical width)
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.82,
        cardHeight: 88,
        listHeight: 340,
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 3.0,
        subtitleMaxWidth: 150,
        horizontalPadding: 16.0,
        columnSpacing: 18.0,
        dividerLeftMargin: 152,
        dividerSpacing: 6,
        thumbnailWidth: 120,
        thumbnailHeight: 80,
        cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        contentSpacing: 14.0,
        titleSubtitleSpacing: 6.0,
        cardVerticalSpacing: 8.0,
        headerPadding: 13.0,
        headerVerticalPadding: 10.0,
        iconSize: 16.0,
        iconContainerSize: 32.0,
        titleFontSize: 24.0,
        greetingFontSize: 14.0,
        topSafeAreaPadding: 8.0,
        categoryTabHeight: 10.0,
        categoryTabPadding: 12.0,
        dateCalendarHeight: 65.0,
        headerToCategoryTabsSpacing: 12.0,
        categoryTabsToDividerSpacing: 12.0,
        dividerToDateCalendarSpacing: 16.0,
        dateCalendarHeaderToScrollerSpacing: 16.0,
        dateCalendarScrollerToSelectedInfoSpacing: 16.0,
        dateCalendarToConversationsSpacing: 16.0,
        categoryTabIconWidth: 50.0,
        categoryTabIconHeight: 35.0,
      );
    } else {
      // Small phones
      return DeviceInfo(
        isTablet: false,
        columnWidth: screenWidth * 0.85,
        cardHeight: 82,
        listHeight: 320,
        cardsPerColumn: 3,
        gridColumns: 1,
        cardAspectRatio: 2.8,
        subtitleMaxWidth: 120,
        horizontalPadding: 14.0,
        columnSpacing: 16.0,
        dividerLeftMargin: 140,
        dividerSpacing: 5,
        thumbnailWidth: 110,
        thumbnailHeight: 75,
        cardPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        contentSpacing: 12.0,
        titleSubtitleSpacing: 5.0,
        cardVerticalSpacing: 6.0,
        headerPadding: 13.0,
        headerVerticalPadding: 8.0,
        iconSize: 15.0,
        iconContainerSize: 30.0,
        titleFontSize: 22.0,
        greetingFontSize: 13.0,
        topSafeAreaPadding: 8.0,
        categoryTabHeight: 8.0,
        categoryTabPadding: 10.0,
        dateCalendarHeight: 60.0,
        headerToCategoryTabsSpacing: 10.0,
        categoryTabsToDividerSpacing: 12.0,
        dividerToDateCalendarSpacing: 5.0,
        dateCalendarHeaderToScrollerSpacing: 16.0,
        dateCalendarScrollerToSelectedInfoSpacing: 16.0,
        dateCalendarToConversationsSpacing: 16.0,
        categoryTabIconWidth: 38.0,
        categoryTabIconHeight: 26.0,
      );
    }
  }
}
