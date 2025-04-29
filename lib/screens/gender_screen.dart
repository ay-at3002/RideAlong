import 'package:flutter/material.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({Key? key}) : super(key: key);

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "BACK",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // Gender Icon at the top
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFF3F51B5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CustomPaint(
                      painter: GenderSymbolPainter(),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Select Gender Text
              Text(
                "Select Gender",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Please select your gender
              Text(
                "Please select your gender",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Gender Selection Options
              Column(
                children: [
                  // Male and Female Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Male Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = 'male';
                            });
                          },
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedGender == 'male' 
                                    ? Color(0xFF3F51B5) 
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF3F51B5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Female Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = 'female';
                            });
                          },
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedGender == 'female' 
                                    ? Color(0xFFE91E63) 
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE91E63),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Other Option
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGender = 'other';
                      });
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedGender == 'other' 
                              ? Color(0xFF9C27B0) 
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF9C27B0),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.people_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Other",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedGender != null
                      ? () {
                          // Handle confirmation
                          Navigator.pop(context, _selectedGender);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3F51B5),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Color(0xFF3F51B5).withOpacity(0.6),
                    disabledForegroundColor: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "CONFIRM",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for the combined gender symbol
class GenderSymbolPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Draw female circle
    final double circleRadius = size.width * 0.25;
    final Offset femaleCenter = Offset(size.width * 0.35, size.height * 0.6);
    canvas.drawCircle(femaleCenter, circleRadius, paint);

    // Draw female cross at the bottom
    final Offset femaleCrossStart = Offset(femaleCenter.dx, femaleCenter.dy + circleRadius);
    final Offset femaleCrossEnd = Offset(femaleCenter.dx, femaleCenter.dy + circleRadius * 2);
    canvas.drawLine(femaleCrossStart, femaleCrossEnd, paint);

    // Draw horizontal line for female cross
    final Offset femaleHorizStart = Offset(femaleCenter.dx - circleRadius * 0.7, femaleCrossStart.dy + circleRadius * 0.5);
    final Offset femaleHorizEnd = Offset(femaleCenter.dx + circleRadius * 0.7, femaleCrossStart.dy + circleRadius * 0.5);
    canvas.drawLine(femaleHorizStart, femaleHorizEnd, paint);

    // Draw male circle
    final Offset maleCenter = Offset(size.width * 0.65, size.height * 0.4);
    canvas.drawCircle(maleCenter, circleRadius, paint);

    // Draw male arrow
    final Offset arrowStart = Offset(maleCenter.dx + circleRadius * 0.7, maleCenter.dy - circleRadius * 0.7);
    final Offset arrowEnd = Offset(arrowStart.dx + circleRadius, arrowStart.dy - circleRadius);
    canvas.drawLine(maleCenter, arrowEnd, paint);

    // Draw arrowhead
    final Offset arrowhead1 = Offset(arrowEnd.dx, arrowEnd.dy + circleRadius * 0.4);
    final Offset arrowhead2 = Offset(arrowEnd.dx - circleRadius * 0.4, arrowEnd.dy);
    canvas.drawLine(arrowEnd, arrowhead1, paint);
    canvas.drawLine(arrowEnd, arrowhead2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}