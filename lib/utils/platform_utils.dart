import 'package:flutter/material.dart';

/// Utility functions for platform-specific behavior
class PlatformUtils {
  static bool isIOS(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }
}
