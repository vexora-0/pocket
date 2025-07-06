import 'package:flutter/material.dart';
import 'responsive_config.dart';

class ResponsiveService {
  static ResponsiveService? _instance;
  ResponsiveConfiguration? _cachedConfig;
  Size? _cachedSize;

  ResponsiveService._internal();

  static ResponsiveService get instance {
    _instance ??= ResponsiveService._internal();
    return _instance!;
  }

  /// Get responsive configuration for the current context
  ResponsiveConfiguration getConfig(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Return cached config if size hasn't changed
    if (_cachedConfig != null && _cachedSize == size) {
      return _cachedConfig!;
    }

    // Create new config and cache it
    _cachedSize = size;
    _cachedConfig = ResponsiveConfiguration.fromScreenSize(
      size.width,
      size.height,
    );

    return _cachedConfig!;
  }

  /// Get responsive configuration for specific dimensions
  ResponsiveConfiguration getConfigForSize(double width, double height) {
    return ResponsiveConfiguration.fromScreenSize(width, height);
  }

  /// Clear cache (useful for testing or when orientation changes)
  void clearCache() {
    _cachedConfig = null;
    _cachedSize = null;
  }
}

/// Extension to make it easier to access responsive config from BuildContext
extension ResponsiveContext on BuildContext {
  ResponsiveConfiguration get responsive =>
      ResponsiveService.instance.getConfig(this);
}
