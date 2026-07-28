import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final Map<String, dynamic>? bookingData;
  const BookingConfirmationScreen({super.key, this.bookingData});

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.bookingData ?? {};
    final studioClass = data['studio_class'] ?? {};
    final studio = data['studio'] ?? {};
    
    final className = studioClass['name'] ?? 'Class';
    final studioName = studio['name'] ?? 'Studio';
    final instructorName = studioClass['instructor_name'] ?? 'Instructor';
    final dateStr = studioClass['date'] ?? 'Date';
    final startTimeStr = studioClass['start_time'] ?? 'Time';
    
    // Formatting time roughly
    String formatTime(String time) {
      if (time.length >= 5) return time.substring(0, 5);
      return time;
    }
    final formattedTime = formatTime(startTimeStr);
    
    final creditsUsed = data['credits_used'] ?? 0;
    final balanceAfter = data['credits_available'] ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Offer Claimed',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Usually no back button on success screen
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Success Icon
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: Color(0xFF2D6A4F),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 28,
                    color: Color(0xFF2D6A4F),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Success Message
            const Text(
              'You\'re Booked! 🎉',
              style: TextStyle(
                color: Color(0xFF2D6A4F),
                fontSize: 24,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'See you at $className on $dateStr\nat $formattedTime. A confirmation has been sent to\nyour email.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF404943),
                fontSize: 14,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Booking Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFDEE5D9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking Summary',
                    style: TextStyle(
                      color: Color(0xFF0F5238),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryRow(
                    icon: Icons.fitness_center,
                    label: 'Class',
                    value: className,
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    icon: Icons.location_on_outlined,
                    label: 'Studio',
                    value: studioName,
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    icon: Icons.person_outline,
                    label: 'Instructor',
                    value: instructorName,
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date & Time',
                    value: '$dateStr\n$formattedTime',
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFBFC9C1), height: 1),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Credits Used',
                        style: TextStyle(
                          color: Color(0xFF404943),
                          fontSize: 14,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '-${creditsUsed.toString().padLeft(2, '0')} credits',
                        style: const TextStyle(
                          color: Color(0xFF93000A),
                          fontSize: 14,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 18,
                            color: Color(0xFF0F5238),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'New Balance',
                            style: TextStyle(
                              color: Color(0xFF404943),
                              fontSize: 14,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${balanceAfter.toString().padLeft(2, '0')} credits',
                        style: const TextStyle(
                          color: Color(0xFF0F5238),
                          fontSize: 14,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Location Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFF3F4F6),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(
                      color: Color(0xFF191C1A),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Google Map Integration
                  Container(
                    width: double.infinity,
                    height: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/map.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Elevate Studio - Westside',
                              style: TextStyle(
                                color: Color(0xFF191C1A),
                                fontSize: 14,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '123 Wellness Way\nLos Angeles, CA 90025',
                              style: TextStyle(
                                color: Color(0xFF404943),
                                fontSize: 13,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE7E9E5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.navigation_outlined,
                              color: Color(0xFF0F5238),
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Directions',
                            style: TextStyle(
                              color: Color(0xFF0F5238),
                              fontSize: 10,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.bookings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006B3D), // Dark green
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'View My Bookings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    color: Color(0xFF0F5238),
                    fontSize: 15,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Cancel logic
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Cancel Booking',
                  style: TextStyle(
                    color: Color(0xFFB3261E),
                    fontSize: 15,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF0F5238),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF404943),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF191C1A),
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
