import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart'; // Add this import for location service check
import 'map_screen.dart';
import 'phone_input_screen.dart';
import '../widgets/location_service_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLocationOverlay = true;
  bool _locationServicesEnabled = false; // Track location services status

  @override
  void initState() {
    super.initState();
    _checkLocationRequirements();
  }

  Future<void> _checkLocationRequirements() async {
    // Check if location services are enabled on the device
    final servicesEnabled = await Geolocator.isLocationServiceEnabled();
    
    // Check app permission status
    final permissionStatus = await Permission.location.status;
    
    if (!mounted) return;
    
    setState(() {
      _locationServicesEnabled = servicesEnabled;
      // Show overlay if either services are disabled or permission is not granted
      _showLocationOverlay = !servicesEnabled || !permissionStatus.isGranted;
    });

    // If both location services are enabled and permission is granted, proceed to next screen
    if (servicesEnabled && permissionStatus.isGranted) {
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
                // Handle different settings based on what's missing
                if (!_locationServicesEnabled) {
                  // For location services being disabled
                  await Geolocator.openLocationSettings();
                } else {
                  // For app permissions not granted
                  await openAppSettings();
                }
                
                // Check again after returning from settings
                await Future.delayed(const Duration(seconds: 1));
                await _checkLocationRequirements();
              },
              locationServicesDisabled: !_locationServicesEnabled,
            ),
        ],
      ),
    );
  }
}