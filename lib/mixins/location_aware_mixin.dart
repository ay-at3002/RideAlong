import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../screens/home_screen.dart';

/// A mixin that adds location monitoring capabilities to any StatefulWidget's State
/// 
/// Usage:
/// ```dart
/// class _MyScreenState extends State<MyScreen> with LocationAwareMixin {
///   @override
///   Widget build(BuildContext context) {
///     // Your UI code here
///   }
/// }
/// ```
mixin LocationAwareMixin<T extends StatefulWidget> on State<T> implements WidgetsBindingObserver {
  final LocationService _locationService = LocationService();
  bool _isObserverRegistered = false;

  @override
  void initState() {
    super.initState();
    _isObserverRegistered = true;
    WidgetsBinding.instance.addObserver(this);
    _checkLocationStatus();
  }

  @override
  void dispose() {
    if (_isObserverRegistered) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkLocationStatus();
    }
  }

  // ===== Stub implementations to satisfy WidgetsBindingObserver =====
  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeLocales(List<Locale>? locale) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  void didChangeTextScaleFactor() {}

  // ===================================================================

  Future<void> _checkLocationStatus() async {
    final isLocationEnabled = await _locationService.isLocationEnabled();

    if (!isLocationEnabled && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  Future<bool> verifyLocationEnabled() async {
    final isLocationEnabled = await _locationService.isLocationEnabled();

    if (!isLocationEnabled && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
      return false;
    }

    return true;
  }
}
