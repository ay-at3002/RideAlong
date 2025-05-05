import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'map_screen.dart';
import 'phone_input_screen.dart'; // Add this import
import '../widgets/location_service_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showLocationOverlay = true;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.location.status;
    if (!mounted) return;
    
    setState(() {
      _showLocationOverlay = !status.isGranted;
    });

    if (status.isGranted) {
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
                await openAppSettings();
                // Check again after returning from settings
                await Future.delayed(const Duration(seconds: 1));
                await _checkLocationPermission();
              },
            ),
        ],
      ),
    );
  }
}
