import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'map_screen.dart';
import 'phone_input_screen.dart';
import '../widgets/location_service_overlay.dart';
import '../services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _showLocationOverlay = true;
  bool _locationServicesEnabled = false;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkLocationRequirements();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check location requirements when app resumes from background
    if (state == AppLifecycleState.resumed) {
      _checkLocationRequirements();
    }
  }

  Future<void> _checkLocationRequirements() async {
    // Use the LocationService class for consistent checking
    final isLocationEnabled = await _locationService.isLocationEnabled();
    
    // Check if location services are enabled on the device
    final servicesEnabled = await Geolocator.isLocationServiceEnabled();
    
    if (!mounted) return;
    
    setState(() {
      _locationServicesEnabled = servicesEnabled;
      // Show overlay if location is not fully enabled
      _showLocationOverlay = !isLocationEnabled;
    });

    // If location is fully enabled, proceed to next screen
    if (isLocationEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PhoneInputScreen()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapScreen(),
          if (_showLocationOverlay)
            LocationServiceOverlay(
              onOpenSettings: () async {
                await _locationService.openSettings();
                // No need for delay here as we'll check in didChangeAppLifecycleState
                // when the app resumes
              },
              locationServicesDisabled: !_locationServicesEnabled,
            ),
        ],
      ),
    );
  }
}