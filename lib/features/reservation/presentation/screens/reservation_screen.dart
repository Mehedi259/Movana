import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../studio/services/studio_service.dart';
import '../../../profile/services/profile_service.dart';
import '../../services/booking_service.dart';

class ReservationScreen extends StatefulWidget {
  final int? classId;
  const ReservationScreen({super.key, this.classId});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  bool _isLoading = false;
  bool _isDataLoading = true;
  Map<String, dynamic>? _classDetails;
  Map<String, dynamic>? _creditStatus;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (widget.classId == null) {
      setState(() => _isDataLoading = false);
      return;
    }
    try {
      final classFuture = StudioService.getClassDetails(widget.classId!);
      final creditFuture = ProfileService.getCreditStatus();
      
      final results = await Future.wait([classFuture, creditFuture]);
      
      if (mounted) {
        setState(() {
          _classDetails = results[0];
          _creditStatus = results[1];
          _isDataLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isDataLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: $e')),
        );
      }
    }
  }

  Future<void> _handleBooking() async {
    if (widget.classId == null) return;
    setState(() => _isLoading = true);
    
    try {
      final result = await BookingService.bookClass(widget.classId!);
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushNamed(
          context,
          AppRoutes.bookingConfirmation,
          arguments: result['booking'],
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDataLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final classData = _classDetails ?? {};
    final creditData = _creditStatus ?? {};
    final className = classData['name'] ?? 'Class Name';
    
    // Sometimes 'studio' might be an int ID, and 'studio_name' or 'location' has the string
    String studioName = 'Studio Name';
    if (classData['studio'] is Map) {
      studioName = classData['studio']['name'] ?? 'Studio Name';
    } else if (classData['studio_name'] != null) {
      studioName = classData['studio_name'].toString();
    } else if (classData['location'] != null) {
      studioName = classData['location'].toString();
    }
    
    final instructorName = classData['instructor_name'] ?? 'Instructor';
    final dateStr = classData['date'] ?? 'Date';
    final startTimeStr = classData['start_time'] ?? '00:00:00';
    final endTimeStr = classData['end_time'] ?? '00:00:00';
    
    // Formatting time roughly
    String formatTime(String time) {
      if (time.length >= 5) return time.substring(0, 5);
      return time;
    }
    final timeStr = '${formatTime(startTimeStr)} - ${formatTime(endTimeStr)}';

    final classCost = (classData['credits_required'] ?? 2).toInt();
    final userBalance = (creditData['total_available'] ?? 0).toInt();
    final balanceAfter = userBalance - classCost;
    
    final bool hasEnoughCredits = balanceAfter >= 0;

    String? imageUrl;
    if (classData['images'] != null && (classData['images'] as List).isNotEmpty) {
      imageUrl = (classData['images'] as List).first['image'];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 18,
                  color: Color(0xFF0B191D),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Class Reservation',
          style: TextStyle(
            color: Color(0xFF0B191D),
            fontSize: 18,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 280,
            child: imageUrl != null 
              ? Image.network(
                  ApiConstants.baseUrl.replaceAll('/api/v1', '') + imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200]),
                )
              : Image.asset(
                  'assets/Reformer Pilates.png',
                  fit: BoxFit.cover,
                ),
          ),

          // Scrollable Content overlaying the image
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 240), // Push down to reveal image

                  // The "Bottom Sheet" container
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1E000000),
                          blurRadius: 40,
                          offset: Offset(0, -12),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag Handle
                        Center(
                          child: Container(
                            width: 48,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1D5DB),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Header: Checkout & Close button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Checkout',
                              style: TextStyle(
                                color: Color(0xFF191C1A),
                                fontSize: 22,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE7E9E5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Color(0xFF404943),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Class Detail Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 12,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: imageUrl != null 
                                  ? Image.network(
                                      ApiConstants.baseUrl.replaceAll('/api/v1', '') + imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200], width: 60, height: 60),
                                    )
                                  : Image.asset(
                                      'assets/Reformer Pilates.png',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      className,
                                      style: const TextStyle(
                                        color: Color(0xFF191C1A),
                                        fontSize: 17,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$dateStr, $timeStr',
                                      style: const TextStyle(
                                        color: Color(0xFF404943),
                                        fontSize: 14,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: Color(0xFF0F5238),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          studioName,
                                          style: const TextStyle(
                                            color: Color(0xFF404943),
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Warning Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0F0),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFFDAD6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  size: 20,
                                  color: Color(0xFF93000A),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'This reservation occurs within 12 hours.\nStandard cancellation fees will apply.',
                                  style: TextStyle(
                                    color: Color(0xFF93000A),
                                    fontSize: 14,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Cost Details Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F4F0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _buildCostRow(
                                'Class cost',
                                '$classCost credits',
                                isValueBold: true,
                              ),
                              const SizedBox(height: 12),
                              _buildCostRow(
                                'Your balance',
                                '$userBalance credits',
                                isValueBold: true,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Divider(
                                  color: Color(0xFFD1D5DB),
                                  height: 1,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Balance after',
                                    style: TextStyle(
                                      color: Color(0xFF191C1A),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '$balanceAfter credits',
                                    style: TextStyle(
                                      color: hasEnoughCredits ? const Color(0xFF0F5238) : Colors.red,
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Footer (Terms and Button)
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'By booking you agree to the ',
                              style: const TextStyle(
                                color: Color(0xFF404943),
                                fontSize: 14,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Cancellation Policy',
                                  style: const TextStyle(
                                    color: Color(0xFF0F5238),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Confirm Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: (_isLoading || !hasEnoughCredits) ? null : _handleBooking,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F5238),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              disabledBackgroundColor: const Color(0xFF0F5238).withValues(alpha: 0.5),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.check, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        'Confirm Reservation',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String value,
      {bool isValueBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF191C1A),
            fontSize: 14,
            fontFamily: 'Lexend',
            fontWeight: isValueBold ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
