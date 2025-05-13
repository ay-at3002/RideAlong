import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import 'home_screen.dart';
import 'otp_input_screen.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> with WidgetsBindingObserver {
  final TextEditingController _phoneController = TextEditingController();
  final AuthService _authService = AuthService();
  final LocationService _locationService = LocationService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Register observer to detect app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
    // Pre-fill the phone number as shown in the design
    _phoneController.text = "+234 674 456 5903";
    // Check location status when screen first loads
    _checkLocationStatus();
  }

  @override
  void dispose() {
    // Remove observer when screen is disposed
    WidgetsBinding.instance.removeObserver(this);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check location status when app resumes from background
    if (state == AppLifecycleState.resumed) {
      _checkLocationStatus();
    }
  }

  // Check if location is enabled, navigate back to home if not
  Future<void> _checkLocationStatus() async {
    final isLocationEnabled = await _locationService.isLocationEnabled();
    
    if (!isLocationEnabled && mounted) {
      // Navigate back to home screen where location overlay will be shown
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  Future<void> _verifyPhone() async {
    // Check location again before proceeding
    final isLocationEnabled = await _locationService.isLocationEnabled();
    if (!isLocationEnabled) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.verifyPhoneNumber(
        phoneNumber: _phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verify on Android if possible
          await _authService.verifyOTP(
            verificationId: credential.verificationId!,
            smsCode: credential.smsCode!,
          );
          setState(() {
            _isLoading = false;
          });
          // Navigate to home or next screen
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification Failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => OtpInputScreen(
                    phoneNumber: _phoneController.text,
                    verificationId: verificationId,
                  ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Illustration
              Image.asset('assets/images/otp_illustration.png', height: 160),
              const SizedBox(height: 40),
              // Title
              const Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                'We will send you a one-time password to this number',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF767676)),
              ),
              const SizedBox(height: 40),
              // Phone number label
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Phone Number',
                  style: TextStyle(fontSize: 16, color: Color(0xFFAAAAAA)),
                ),
              ),
              const SizedBox(height: 8),
              // Phone number field
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2C65F6), width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2C65F6), width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2C65F6), width: 2),
                  ),
                ),
                style: const TextStyle(fontSize: 18, color: Color(0xFF333333)),
              ),
              const Spacer(),
              // Get OTP Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyPhone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C65F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'Get OTP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}