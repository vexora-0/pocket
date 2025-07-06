enum DeviceType {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == DeviceType.mobile;
  bool get isTablet => this == DeviceType.tablet;
  bool get isDesktop => this == DeviceType.desktop;
}

enum ScreenSize {
  small, // < 350px
  medium, // 350-389px
  large, // 390-429px
  extraLarge, // 430-599px
  tablet, // 600-899px
  desktop; // >= 900px

  static ScreenSize fromWidth(double width) {
    if (width >= 900) return ScreenSize.desktop;
    if (width >= 600) return ScreenSize.tablet;
    if (width >= 430) return ScreenSize.extraLarge;
    if (width >= 390) return ScreenSize.large;
    if (width >= 350) return ScreenSize.medium;
    return ScreenSize.small;
  }

  DeviceType get deviceType {
    switch (this) {
      case ScreenSize.small:
      case ScreenSize.medium:
      case ScreenSize.large:
      case ScreenSize.extraLarge:
        return DeviceType.mobile;
      case ScreenSize.tablet:
        return DeviceType.tablet;
      case ScreenSize.desktop:
        return DeviceType.desktop;
    }
  }
}

abstract class ResponsiveConfig {
  const ResponsiveConfig();
}
