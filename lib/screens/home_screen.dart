import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'map_screen.dart';
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
    if (status.isGranted) {
      setState(() {
        _showLocationOverlay = false;
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