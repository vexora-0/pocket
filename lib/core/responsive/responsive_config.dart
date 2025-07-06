import 'package:flutter/material.dart';
import 'device_type.dart';
import 'layout_config.dart';
import 'typography_config.dart';
import 'spacing_config.dart';
import 'size_config.dart';

class ResponsiveConfiguration {
  final DeviceType deviceType;
  final ScreenSize screenSize;
  final LayoutConfig layout;
  final TypographyConfig typography;
  final SpacingConfig spacing;
  final SizeConfig size;

  const ResponsiveConfiguration({
    required this.deviceType,
    required this.screenSize,
    required this.layout,
    required this.typography,
    required this.spacing,
    required this.size,
  });

  factory ResponsiveConfiguration.fromScreenSize(
    double screenWidth,
    double screenHeight,
  ) {
    final screenSize = ScreenSize.fromWidth(screenWidth);
    final deviceType = screenSize.deviceType;

    return ResponsiveConfiguration(
      deviceType: deviceType,
      screenSize: screenSize,
      layout: LayoutConfig.fromScreenSize(screenSize, screenWidth),
      typography: TypographyConfig.fromScreenSize(screenSize),
      spacing: SpacingConfig.fromScreenSize(screenSize),
      size: SizeConfig.fromScreenSize(screenSize),
    );
  }

  // Legacy compatibility methods for easier migration
  bool get isTablet => layout.isTablet;
  double get columnWidth => layout.columnWidth;
  double get cardHeight => layout.cardHeight;
  double get listHeight => layout.listHeight;
  int get cardsPerColumn => layout.cardsPerColumn;
  int get gridColumns => layout.gridColumns;
  double get cardAspectRatio => layout.cardAspectRatio;
  double get subtitleMaxWidth => layout.subtitleMaxWidth;
  double get horizontalPadding => layout.horizontalPadding;
  double get columnSpacing => layout.columnSpacing;
  double get dividerLeftMargin => layout.dividerLeftMargin;
  double get thumbnailWidth => layout.thumbnailWidth;
  double get thumbnailHeight => layout.thumbnailHeight;
  EdgeInsets get cardPadding => layout.cardPadding;
  double get contentSpacing => layout.contentSpacing;
  double get titleSubtitleSpacing => spacing.titleSubtitleSpacing;
  double get cardVerticalSpacing => layout.cardVerticalSpacing;
  double get headerPadding => layout.headerPadding;
  double get headerVerticalPadding => layout.headerVerticalPadding;
  double get iconSize => typography.iconSize;
  double get iconContainerSize => layout.iconContainerSize;
  double get titleFontSize => typography.titleFontSize;
  double get greetingFontSize => typography.greetingFontSize;
  double get topSafeAreaPadding => spacing.topSafeAreaPadding;
  double get categoryTabHeight => layout.categoryTabHeight;
  double get categoryTabPadding => spacing.categoryTabPadding;
  double get dateCalendarHeight => layout.dateCalendarHeight;
  double get headerToCategoryTabsSpacing => spacing.headerToCategoryTabsSpacing;
  double get categoryTabsToDividerSpacing =>
      spacing.categoryTabsToDividerSpacing;
  double get dividerToDateCalendarSpacing =>
      spacing.dividerToDateCalendarSpacing;
  double get dateCalendarHeaderToScrollerSpacing =>
      spacing.dateCalendarHeaderToScrollerSpacing;
  double get dateCalendarScrollerToSelectedInfoSpacing =>
      spacing.dateCalendarScrollerToSelectedInfoSpacing;
  double get dateCalendarToConversationsSpacing =>
      spacing.dateCalendarToConversationsSpacing;
  double get categoryTabIconWidth => size.categoryTabIconWidth;
  double get categoryTabIconHeight => size.categoryTabIconHeight;
  double get miniPlayerSvgInitialSize => size.miniPlayerSvgInitialSize;
  double get miniPlayerTextLeftPadding => spacing.miniPlayerTextLeftPadding;
  double get miniPlayerTextVerticalPadding =>
      spacing.miniPlayerTextVerticalPadding;
  double get miniPlayerTitleFontSize => typography.miniPlayerTitleFontSize;
  double get miniPlayerStatusFontSize => typography.miniPlayerStatusFontSize;
  double get miniPlayerTextSpacing => spacing.miniPlayerTextSpacing;
  double get miniPlayerStatusSpacing => spacing.miniPlayerStatusSpacing;
  double get miniPlayerRecordButtonPadding =>
      spacing.miniPlayerRecordButtonPadding;
  double get miniPlayerRecordButtonFontSize =>
      typography.miniPlayerRecordButtonFontSize;
  double get miniPlayerContentHeight => size.miniPlayerContentHeight;
  double get olderConversationCardWidth => size.olderConversationCardWidth;
  double get olderConversationCardHeight => size.olderConversationCardHeight;
  double get olderConversationCardSpacing =>
      spacing.olderConversationCardSpacing;
  double get olderConversationTitleFontSize =>
      typography.olderConversationTitleFontSize;
  double get olderConversationSubtitleFontSize =>
      typography.olderConversationSubtitleFontSize;
  double get olderConversationIconSize => size.olderConversationIconSize;
  double get olderConversationTitleIconSpacing =>
      spacing.olderConversationTitleIconSpacing;
  double get olderConversationTitleSubtitleSpacing =>
      spacing.olderConversationTitleSubtitleSpacing;
  double get olderConversationGradientToContentSpacing =>
      spacing.olderConversationGradientToContentSpacing;
  double get olderConversationSectionSpacing =>
      spacing.olderConversationSectionSpacing;
  double get olderConversationSelectedDateFontSize =>
      typography.olderConversationSelectedDateFontSize;
  double get olderConversationConversationCountFontSize =>
      typography.olderConversationConversationCountFontSize;
}
