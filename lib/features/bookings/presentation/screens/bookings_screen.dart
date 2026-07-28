import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';
import '../../../reservation/services/booking_service.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedTab = 0;
  bool _isLoading = true;
  List<dynamic> _upcoming = [];
  List<dynamic> _past = [];
  List<dynamic> _cancelled = [];

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    setState(() => _isLoading = true);
    try {
      final data = await BookingService.getCategorizedBookings();
      if (mounted) {
        setState(() {
          _upcoming = data['upcoming'] ?? [];
          _past = data['past'] ?? [];
          _cancelled = data['cancelled'] ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _cancelBooking(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);
    try {
      await BookingService.cancelBooking(id);
      await _fetchBookings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking cancelled successfully'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', '')), backgroundColor: Colors.red),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Booking Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0B191D),
                      fontSize: 18,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.11,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                children: [
                  Expanded(
                    child: _TabItem(
                      label: 'Upcoming',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  Expanded(
                    child: _TabItem(
                      label: 'Past',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                  Expanded(
                    child: _TabItem(
                      label: 'Cancelled',
                      isSelected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Content
            Expanded(
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF0F5238)))
                : RefreshIndicator(
                    onRefresh: _fetchBookings,
                    color: const Color(0xFF0F5238),
                    child: _selectedTab == 0
                      ? _buildTabList(_upcoming, showCancel: true)
                      : _selectedTab == 1
                          ? _buildTabList(_past, showCancel: false)
                          : _buildTabList(_cancelled, showCancel: false),
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildTabList(List<dynamic> list, {bool showCancel = false}) {
    if (list.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 100),
          Center(child: Text('No bookings found')),
        ],
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      itemCount: list.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        if (index == list.length) return const SizedBox(height: 100);
        final item = list[index];
        final studioClass = item['studio_class'] ?? {};
        final studio = studioClass['studio'] ?? {};
        
        return _BookingCard(
          id: item['id'] ?? 0,
          className: studioClass['name'] ?? 'Class Name',
          studioName: studio['name'] ?? 'Studio Name',
          date: studioClass['date'] ?? 'Date',
          time: studioClass['start_time'] != null 
              ? '${studioClass['start_time']} - ${studioClass['end_time'] ?? ''}' 
              : 'Time',
          instructor: studioClass['instructor_name'] ?? 'Instructor',
          location: studio['location'] ?? 'Location',
          credits: '${studioClass['credit_cost'] ?? 0} credits',
          status: item['computed_status'] == 'completed' 
              ? 'Completed' 
              : item['computed_status'] == 'cancelled' ? 'Cancelled' : 'Confirmed',
          showCancel: showCancel,
          onCancel: () => _cancelBooking(item['id']),
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Color(0xFF0F5238),
                  ),
                )
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? const Color(0xFF0F5238) : const Color(0xFF707973),
            fontSize: 14,
            fontFamily: 'Lexend',
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final int id;
  final String className;
  final String studioName;
  final String date;
  final String time;
  final String instructor;
  final String location;
  final String credits;
  final String status;
  final bool showCancel;
  final VoidCallback? onCancel;

  const _BookingCard({
    required this.id,
    required this.className,
    required this.studioName,
    required this.date,
    required this.time,
    required this.instructor,
    required this.location,
    required this.credits,
    required this.status,
    this.showCancel = false,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 12,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      className,
                      style: const TextStyle(
                        color: Color(0xFF191C1A),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                        height: 1.38,
                      ),
                    ),
                    Text(
                      studioName,
                      style: const TextStyle(
                        color: Color(0xFF404943),
                        fontSize: 14,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9E6DA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      status,
                      style: const TextStyle(
                        color: Color(0xFF5B675E),
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.60,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.check_circle,
                      size: 12,
                      color: Color(0xFF5B675E),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Date & Time
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF404943),
              ),
              const SizedBox(width: 8),
              Text(
                '$date · $time',
                style: const TextStyle(
                  color: Color(0xFF404943),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Instructor
          Row(
            children: [
              const Icon(
                Icons.person,
                size: 16,
                color: Color(0xFF404943),
              ),
              const SizedBox(width: 8),
              Text(
                instructor,
                style: const TextStyle(
                  color: Color(0xFF404943),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFF404943),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    color: Color(0xFF404943),
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Credits Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2D6A4F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              credits,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w600,
                height: 1.50,
                letterSpacing: 0.60,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // View Map Button (Full Width)
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                // Open map with location
                // You can use url_launcher package or Google Maps
                print('Opening map for: $location');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D6A4F),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'View Map',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Bottom Actions
          Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Color(0xFFE1E3DF),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to booking details
                    print('View details for: $className');
                  },
                  child: Row(
                    children: const [
                      Text(
                        'View Details',
                        style: TextStyle(
                          color: Color(0xFF0F5238),
                          fontSize: 14,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Color(0xFF0F5238),
                      ),
                    ],
                  ),
                ),
                if (showCancel)
                  GestureDetector(
                    onTap: onCancel,
                    child: const Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFBA1A1A),
                        fontSize: 14,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
