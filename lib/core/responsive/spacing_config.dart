import 'device_type.dart';

class SpacingConfig extends ResponsiveConfig {
  final double topSafeAreaPadding;
  final double categoryTabPadding;
  final double titleSubtitleSpacing;
  final double headerToCategoryTabsSpacing;
  final double categoryTabsToDividerSpacing;
  final double dividerToDateCalendarSpacing;
  final double dateCalendarHeaderToScrollerSpacing;
  final double dateCalendarScrollerToSelectedInfoSpacing;
  final double dateCalendarToConversationsSpacing;
  final double miniPlayerTextLeftPadding;
  final double miniPlayerTextVerticalPadding;
  final double miniPlayerTextSpacing;
  final double miniPlayerStatusSpacing;
  final double miniPlayerRecordButtonPadding;
  final double olderConversationCardSpacing;
  final double olderConversationTitleIconSpacing;
  final double olderConversationTitleSubtitleSpacing;
  final double olderConversationGradientToContentSpacing;
  final double olderConversationSectionSpacing;

  const SpacingConfig({
    required this.topSafeAreaPadding,
    required this.categoryTabPadding,
    required this.titleSubtitleSpacing,
    required this.headerToCategoryTabsSpacing,
    required this.categoryTabsToDividerSpacing,
    required this.dividerToDateCalendarSpacing,
    required this.dateCalendarHeaderToScrollerSpacing,
    required this.dateCalendarScrollerToSelectedInfoSpacing,
    required this.dateCalendarToConversationsSpacing,
    required this.miniPlayerTextLeftPadding,
    required this.miniPlayerTextVerticalPadding,
    required this.miniPlayerTextSpacing,
    required this.miniPlayerStatusSpacing,
    required this.miniPlayerRecordButtonPadding,
    required this.olderConversationCardSpacing,
    required this.olderConversationTitleIconSpacing,
    required this.olderConversationTitleSubtitleSpacing,
    required this.olderConversationGradientToContentSpacing,
    required this.olderConversationSectionSpacing,
  });

  factory SpacingConfig.fromScreenSize(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.desktop:
        return const SpacingConfig(
          topSafeAreaPadding: 20.0,
          categoryTabPadding: 18.0,
          titleSubtitleSpacing: 8.0,
          headerToCategoryTabsSpacing: 16.0,
          categoryTabsToDividerSpacing: 18.0,
          dividerToDateCalendarSpacing: 8.0,
          dateCalendarHeaderToScrollerSpacing: 16.0,
          dateCalendarScrollerToSelectedInfoSpacing: 16.0,
          dateCalendarToConversationsSpacing: 24.0,
          miniPlayerTextLeftPadding: 45.0,
          miniPlayerTextVerticalPadding: 12.0,
          miniPlayerTextSpacing: 3.0,
          miniPlayerStatusSpacing: 8.0,
          miniPlayerRecordButtonPadding: 18.0,
          olderConversationCardSpacing: 20.0,
          olderConversationTitleIconSpacing: 10.0,
          olderConversationTitleSubtitleSpacing: 10.0,
          olderConversationGradientToContentSpacing: 16.0,
          olderConversationSectionSpacing: 28.0,
        );
      case ScreenSize.tablet:
        return const SpacingConfig(
          topSafeAreaPadding: 20.0,
          categoryTabPadding: 16.0,
          titleSubtitleSpacing: 7.0,
          headerToCategoryTabsSpacing: 14.0,
          categoryTabsToDividerSpacing: 16.0,
          dividerToDateCalendarSpacing: 7.0,
          dateCalendarHeaderToScrollerSpacing: 16.0,
          dateCalendarScrollerToSelectedInfoSpacing: 16.0,
          dateCalendarToConversationsSpacing: 20.0,
          miniPlayerTextLeftPadding: 45.0,
          miniPlayerTextVerticalPadding: 11.0,
          miniPlayerTextSpacing: 3.0,
          miniPlayerStatusSpacing: 7.0,
          miniPlayerRecordButtonPadding: 16.0,
          olderConversationCardSpacing: 18.0,
          olderConversationTitleIconSpacing: 9.0,
          olderConversationTitleSubtitleSpacing: 9.0,
          olderConversationGradientToContentSpacing: 15.0,
          olderConversationSectionSpacing: 26.0,
        );
      case ScreenSize.extraLarge:
        return const SpacingConfig(
          topSafeAreaPadding: 30.0,
          categoryTabPadding: 15.0,
          titleSubtitleSpacing: 7.0,
          headerToCategoryTabsSpacing: 20.0,
          categoryTabsToDividerSpacing: 20.0,
          dividerToDateCalendarSpacing: 40.0,
          dateCalendarHeaderToScrollerSpacing: 20.0,
          dateCalendarScrollerToSelectedInfoSpacing: 40.0,
          dateCalendarToConversationsSpacing: 15.0,
          miniPlayerTextLeftPadding: 45.0,
          miniPlayerTextVerticalPadding: 12.0,
          miniPlayerTextSpacing: 3.0,
          miniPlayerStatusSpacing: 8.0,
          miniPlayerRecordButtonPadding: 18.0,
          olderConversationCardSpacing: 18.0,
          olderConversationTitleIconSpacing: 8.0,
          olderConversationTitleSubtitleSpacing: 8.0,
          olderConversationGradientToContentSpacing: 14.0,
          olderConversationSectionSpacing: 24.0,
        );
      case ScreenSize.large:
        return const SpacingConfig(
          topSafeAreaPadding: 11.0,
          categoryTabPadding: 14.0,
          titleSubtitleSpacing: 6.5,
          headerToCategoryTabsSpacing: 11.0,
          categoryTabsToDividerSpacing: 16.0,
          dividerToDateCalendarSpacing: 35.0,
          dateCalendarHeaderToScrollerSpacing: 16.0,
          dateCalendarScrollerToSelectedInfoSpacing: 35.0,
          dateCalendarToConversationsSpacing: 15.0,
          miniPlayerTextLeftPadding: 40.0,
          miniPlayerTextVerticalPadding: 10.0,
          miniPlayerTextSpacing: 2.0,
          miniPlayerStatusSpacing: 6.0,
          miniPlayerRecordButtonPadding: 14.0,
          olderConversationCardSpacing: 16.0,
          olderConversationTitleIconSpacing: 7.0,
          olderConversationTitleSubtitleSpacing: 7.0,
          olderConversationGradientToContentSpacing: 13.0,
          olderConversationSectionSpacing: 20.0,
        );
      case ScreenSize.medium:
        return const SpacingConfig(
          topSafeAreaPadding: 8.0,
          categoryTabPadding: 12.0,
          titleSubtitleSpacing: 6.0,
          headerToCategoryTabsSpacing: 12.0,
          categoryTabsToDividerSpacing: 12.0,
          dividerToDateCalendarSpacing: 16.0,
          dateCalendarHeaderToScrollerSpacing: 16.0,
          dateCalendarScrollerToSelectedInfoSpacing: 16.0,
          dateCalendarToConversationsSpacing: 16.0,
          miniPlayerTextLeftPadding: 40.0,
          miniPlayerTextVerticalPadding: 10.0,
          miniPlayerTextSpacing: 2.0,
          miniPlayerStatusSpacing: 6.0,
          miniPlayerRecordButtonPadding: 14.0,
          olderConversationCardSpacing: 15.0,
          olderConversationTitleIconSpacing: 6.5,
          olderConversationTitleSubtitleSpacing: 6.5,
          olderConversationGradientToContentSpacing: 12.0,
          olderConversationSectionSpacing: 18.0,
        );
      case ScreenSize.small:
        return const SpacingConfig(
          topSafeAreaPadding: 8.0,
          categoryTabPadding: 10.0,
          titleSubtitleSpacing: 5.0,
          headerToCategoryTabsSpacing: 10.0,
          categoryTabsToDividerSpacing: 12.0,
          dividerToDateCalendarSpacing: 5.0,
          dateCalendarHeaderToScrollerSpacing: 16.0,
          dateCalendarScrollerToSelectedInfoSpacing: 16.0,
          dateCalendarToConversationsSpacing: 16.0,
          miniPlayerTextLeftPadding: 32.0,
          miniPlayerTextVerticalPadding: 9.0,
          miniPlayerTextSpacing: 2.0,
          miniPlayerStatusSpacing: 5.0,
          miniPlayerRecordButtonPadding: 12.0,
          olderConversationCardSpacing: 14.0,
          olderConversationTitleIconSpacing: 6.0,
          olderConversationTitleSubtitleSpacing: 6.0,
          olderConversationGradientToContentSpacing: 11.0,
          olderConversationSectionSpacing: 16.0,
        );
    }
  }
}
