import 'package:flutter/material.dart';
import 'device_type.dart';
import 'responsive_config.dart';
import 'responsive_service.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  /// Get responsive configuration for the current context
  static ResponsiveConfiguration getConfig(BuildContext context) {
    return ResponsiveService.instance.getConfig(context);
  }

  /// Legacy method for backward compatibility
  static ResponsiveConfiguration getDeviceInfo(
    double screenWidth,
    double screenHeight,
  ) {
    return ResponsiveService.instance.getConfigForSize(
      screenWidth,
      screenHeight,
    );
  }

  /// Check if device is tablet based on screen size
  static bool isTablet(BuildContext context) {
    return context.responsive.isTablet;
  }

  /// Get screen size category
  static String getScreenSizeCategory(BuildContext context) {
    final config = context.responsive;
    return config.screenSize.toString().split('.').last;
  }

  /// Get device type as string
  static String getDeviceType(BuildContext context) {
    final config = context.responsive;
    return config.deviceType.toString().split('.').last;
  }

  /// Helper method to get responsive value based on screen size
  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final config = context.responsive;

    switch (config.deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  /// Get font size based on screen size with fallback
  static double getFontSize(
    BuildContext context, {
    required double base,
    double? tablet,
    double? desktop,
  }) {
    return getResponsiveValue(
      context,
      mobile: base,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Get padding based on screen size
  static EdgeInsets getPadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    return getResponsiveValue(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

/// Widget that rebuilds when screen size changes
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveConfiguration config)
  builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, context.responsive);
  }
}
