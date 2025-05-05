import 'package:flutter/material.dart';
import 'dart:ui';

class LocationServiceOverlay extends StatelessWidget {
  final VoidCallback onOpenSettings;
  final bool locationServicesDisabled;
  
  const LocationServiceOverlay({
    Key? key,
    required this.onOpenSettings,
    this.locationServicesDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 64,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Text(
                  locationServicesDisabled
                      ? 'Location Services Disabled'
                      : 'Location Permission Required',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  locationServicesDisabled
                      ? 'Please enable location services on your device to use this app.'
                      : 'This app needs access to your location to function properly.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onOpenSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    locationServicesDisabled
                        ? 'Open Location Settings'
                        : 'Grant Permission',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}