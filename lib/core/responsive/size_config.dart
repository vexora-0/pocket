import 'device_type.dart';

class SizeConfig extends ResponsiveConfig {
  final double categoryTabIconWidth;
  final double categoryTabIconHeight;
  final double miniPlayerSvgInitialSize;
  final double miniPlayerContentHeight;
  final double olderConversationCardWidth;
  final double olderConversationCardHeight;
  final double olderConversationIconSize;

  const SizeConfig({
    required this.categoryTabIconWidth,
    required this.categoryTabIconHeight,
    required this.miniPlayerSvgInitialSize,
    required this.miniPlayerContentHeight,
    required this.olderConversationCardWidth,
    required this.olderConversationCardHeight,
    required this.olderConversationIconSize,
  });

  factory SizeConfig.fromScreenSize(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.desktop:
        return const SizeConfig(
          categoryTabIconWidth: 46.0,
          categoryTabIconHeight: 33.0,
          miniPlayerSvgInitialSize: 55.0,
          miniPlayerContentHeight: 70.0,
          olderConversationCardWidth: 160.0,
          olderConversationCardHeight: 120.0,
          olderConversationIconSize: 18.0,
        );
      case ScreenSize.tablet:
        return const SizeConfig(
          categoryTabIconWidth: 44.0,
          categoryTabIconHeight: 31.0,
          miniPlayerSvgInitialSize: 55.0,
          miniPlayerContentHeight: 68.0,
          olderConversationCardWidth: 150.0,
          olderConversationCardHeight: 115.0,
          olderConversationIconSize: 17.0,
        );
      case ScreenSize.extraLarge:
        return const SizeConfig(
          categoryTabIconWidth: 60.0,
          categoryTabIconHeight: 40.0,
          miniPlayerSvgInitialSize: 55.0,
          miniPlayerContentHeight: 70.0,
          olderConversationCardWidth: 165.0,
          olderConversationCardHeight: 180.0,
          olderConversationIconSize: 16.0,
        );
      case ScreenSize.large:
        return const SizeConfig(
          categoryTabIconWidth: 42.0,
          categoryTabIconHeight: 29.0,
          miniPlayerSvgInitialSize: 50.0,
          miniPlayerContentHeight: 62.0,
          olderConversationCardWidth: 155.0,
          olderConversationCardHeight: 170.0,
          olderConversationIconSize: 15.0,
        );
      case ScreenSize.medium:
        return const SizeConfig(
          categoryTabIconWidth: 50.0,
          categoryTabIconHeight: 35.0,
          miniPlayerSvgInitialSize: 50.0,
          miniPlayerContentHeight: 62.0,
          olderConversationCardWidth: 150.0,
          olderConversationCardHeight: 170.0,
          olderConversationIconSize: 12.0,
        );
      case ScreenSize.small:
        return const SizeConfig(
          categoryTabIconWidth: 38.0,
          categoryTabIconHeight: 26.0,
          miniPlayerSvgInitialSize: 42.0,
          miniPlayerContentHeight: 58.0,
          olderConversationCardWidth: 145.0,
          olderConversationCardHeight: 160.0,
          olderConversationIconSize: 13.0,
        );
    }
  }
}
