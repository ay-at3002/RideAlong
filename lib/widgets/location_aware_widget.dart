import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../screens/home_screen.dart';

/// A wrapper widget that ensures location services are enabled
/// 
/// Wrap any screen with this widget to enforce location checking:
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return LocationAwareWidget(
///     child: Scaffold(
///       // Your UI
///     ),
///   );
/// }
/// ```
class LocationAwareWidget extends StatefulWidget {
  final Widget child;
  
  const LocationAwareWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<LocationAwareWidget> createState() => _LocationAwareWidgetState();
}

class _LocationAwareWidgetState extends State<LocationAwareWidget> with WidgetsBindingObserver {
  final LocationService _locationService = LocationService();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkLocationStatus();
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkLocationStatus();
    }
  }
  
  Future<void> _checkLocationStatus() async {
    final isLocationEnabled = await _locationService.isLocationEnabled();
    
    if (!isLocationEnabled && mounted) {
      // Navigate back to home screen where location overlay will be shown
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}