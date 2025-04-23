import 'package:flutter/material.dart';

class OtpInputScreen extends StatefulWidget {
  final String phoneNumber;
  
  const OtpInputScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  // Pre-filled OTP digits for demonstration
  final List<String> _otpDigits = ['', '', '', ''];
  final int _otpLength = 4;
  
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
              // Illustration - same as previous screen
              Image.asset(
                'assets/images/otp_illustration.png',
                height: 160,
              ),
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
              const SizedBox(height: 24),
              // Description with phone number
              Text(
                'Enter OTP sent to ${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF767676),
                ),
              ),
              const SizedBox(height: 40),
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _otpLength,
                  (index) => _buildOtpDigitField(index),
                ),
              ),
              const SizedBox(height: 24),
              // Resend OTP text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive OTP? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFAAAAAA),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle resend OTP
                    },
                    child: const Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2C65F6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Get OTP Button (same as previous screen)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle verification
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C65F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Verify OTP',
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

  Widget _buildOtpDigitField(int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF2C65F6),
            width: 2,
          ),
        ),
      ),
      child: Center(
        child: Text(
          _otpDigits[index],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}