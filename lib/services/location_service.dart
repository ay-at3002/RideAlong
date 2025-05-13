import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // Singleton pattern
  static final LocationService _instance = LocationService._internal();
  
  factory LocationService() => _instance;
  
  LocationService._internal();
  
  // Check if both location services are enabled and permission is granted
  Future<bool> isLocationEnabled() async {
    // Check if location services are enabled on the device
    final servicesEnabled = await Geolocator.isLocationServiceEnabled();
    
    // Check app permission status
    final permissionStatus = await Permission.location.status;
    
    // Return true only if both services are enabled and permission is granted
    return servicesEnabled && permissionStatus.isGranted;
  }

  // Open appropriate settings based on what's disabled
  Future<void> openSettings() async {
    final servicesEnabled = await Geolocator.isLocationServiceEnabled();
    
    if (!servicesEnabled) {
      await Geolocator.openLocationSettings();
    } else {
      await openAppSettings();
    }
  }
}