import 'device_type.dart';

class TypographyConfig extends ResponsiveConfig {
  final double iconSize;
  final double titleFontSize;
  final double greetingFontSize;
  final double miniPlayerTitleFontSize;
  final double miniPlayerStatusFontSize;
  final double miniPlayerRecordButtonFontSize;
  final double olderConversationTitleFontSize;
  final double olderConversationSubtitleFontSize;
  final double olderConversationSelectedDateFontSize;
  final double olderConversationConversationCountFontSize;

  const TypographyConfig({
    required this.iconSize,
    required this.titleFontSize,
    required this.greetingFontSize,
    required this.miniPlayerTitleFontSize,
    required this.miniPlayerStatusFontSize,
    required this.miniPlayerRecordButtonFontSize,
    required this.olderConversationTitleFontSize,
    required this.olderConversationSubtitleFontSize,
    required this.olderConversationSelectedDateFontSize,
    required this.olderConversationConversationCountFontSize,
  });

  factory TypographyConfig.fromScreenSize(ScreenSize screenSize) {
    switch (screenSize) {
      case ScreenSize.desktop:
        return const TypographyConfig(
          iconSize: 20.0,
          titleFontSize: 28.0,
          greetingFontSize: 16.0,
          miniPlayerTitleFontSize: 16.0,
          miniPlayerStatusFontSize: 14.0,
          miniPlayerRecordButtonFontSize: 16.0,
          olderConversationTitleFontSize: 16.0,
          olderConversationSubtitleFontSize: 13.0,
          olderConversationSelectedDateFontSize: 16.0,
          olderConversationConversationCountFontSize: 14.0,
        );
      case ScreenSize.tablet:
        return const TypographyConfig(
          iconSize: 18.0,
          titleFontSize: 26.0,
          greetingFontSize: 15.0,
          miniPlayerTitleFontSize: 15.0,
          miniPlayerStatusFontSize: 13.0,
          miniPlayerRecordButtonFontSize: 15.0,
          olderConversationTitleFontSize: 15.0,
          olderConversationSubtitleFontSize: 12.0,
          olderConversationSelectedDateFontSize: 15.0,
          olderConversationConversationCountFontSize: 13.0,
        );
      case ScreenSize.extraLarge:
        return const TypographyConfig(
          iconSize: 18.0,
          titleFontSize: 26.0,
          greetingFontSize: 15.0,
          miniPlayerTitleFontSize: 16.0,
          miniPlayerStatusFontSize: 14.0,
          miniPlayerRecordButtonFontSize: 16.0,
          olderConversationTitleFontSize: 13.0,
          olderConversationSubtitleFontSize: 12.0,
          olderConversationSelectedDateFontSize: 15.0,
          olderConversationConversationCountFontSize: 13.0,
        );
      case ScreenSize.large:
        return const TypographyConfig(
          iconSize: 17.0,
          titleFontSize: 25.0,
          greetingFontSize: 14.5,
          miniPlayerTitleFontSize: 14.0,
          miniPlayerStatusFontSize: 12.0,
          miniPlayerRecordButtonFontSize: 14.0,
          olderConversationTitleFontSize: 12.0,
          olderConversationSubtitleFontSize: 11.0,
          olderConversationSelectedDateFontSize: 14.0,
          olderConversationConversationCountFontSize: 12.0,
        );
      case ScreenSize.medium:
        return const TypographyConfig(
          iconSize: 16.0,
          titleFontSize: 24.0,
          greetingFontSize: 14.0,
          miniPlayerTitleFontSize: 14.0,
          miniPlayerStatusFontSize: 12.0,
          miniPlayerRecordButtonFontSize: 14.0,
          olderConversationTitleFontSize: 11.5,
          olderConversationSubtitleFontSize: 10.5,
          olderConversationSelectedDateFontSize: 13.5,
          olderConversationConversationCountFontSize: 11.5,
        );
      case ScreenSize.small:
        return const TypographyConfig(
          iconSize: 15.0,
          titleFontSize: 22.0,
          greetingFontSize: 13.0,
          miniPlayerTitleFontSize: 13.0,
          miniPlayerStatusFontSize: 11.0,
          miniPlayerRecordButtonFontSize: 13.0,
          olderConversationTitleFontSize: 11.0,
          olderConversationSubtitleFontSize: 10.0,
          olderConversationSelectedDateFontSize: 13.0,
          olderConversationConversationCountFontSize: 11.0,
        );
    }
  }
}
