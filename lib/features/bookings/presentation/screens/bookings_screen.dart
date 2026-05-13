import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_bottom_nav_bar.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Booking Setails',
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
              child: _selectedTab == 0
                  ? _buildUpcomingTab()
                  : _selectedTab == 1
                      ? _buildPastTab()
                      : _buildCancelledTab(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildUpcomingTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      children: const [
        _BookingCard(
          className: 'Reformer Pilates',
          studioName: 'Zen Flow Studio',
          date: 'Mon, Mar 16',
          time: '7:00 AM to 7:30 AM',
          instructor: 'Giovanna',
          location: 'Unit 24, Point Square Shopping, East wall\nRoad, Dublin 1, Ireland',
          credits: '20 credits',
          status: 'Confirmed',
        ),
        SizedBox(height: 16),
        _BookingCard(
          className: 'Morning Vinyasa',
          studioName: 'Zen Flow Studio',
          date: 'Tue, Mar 17',
          time: '8:30 AM to 9:30 AM',
          instructor: 'Alex',
          location: 'Unit 24, Point Square Shopping, East wall\nRoad, Dublin 1, Ireland',
          credits: '5 credits',
          status: 'Confirmed',
        ),
        SizedBox(height: 100),
      ],
    );
  }

  Widget _buildPastTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      children: const [
        _BookingCard(
          className: 'Power Yoga',
          studioName: 'Zen Flow Studio',
          date: 'Mon, Mar 9',
          time: '6:00 AM to 7:00 AM',
          instructor: 'Sarah',
          location: 'Unit 24, Point Square Shopping, East wall\nRoad, Dublin 1, Ireland',
          credits: '8 credits',
          status: 'Completed',
        ),
        SizedBox(height: 16),
        _BookingCard(
          className: 'HIIT Training',
          studioName: 'FitForce Gym',
          date: 'Fri, Mar 6',
          time: '5:30 PM to 6:30 PM',
          instructor: 'Mike',
          location: 'Unit 24, Point Square Shopping, East wall\nRoad, Dublin 1, Ireland',
          credits: '10 credits',
          status: 'Completed',
        ),
        SizedBox(height: 100),
      ],
    );
  }

  Widget _buildCancelledTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      children: const [
        _BookingCard(
          className: 'Spin Class',
          studioName: 'CycleFit Studio',
          date: 'Wed, Mar 11',
          time: '7:00 PM to 8:00 PM',
          instructor: 'Emma',
          location: 'Unit 24, Point Square Shopping, East wall\nRoad, Dublin 1, Ireland',
          credits: '12 credits',
          status: 'Cancelled',
        ),
        SizedBox(height: 100),
      ],
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
  final String className;
  final String studioName;
  final String date;
  final String time;
  final String instructor;
  final String location;
  final String credits;
  final String status;

  const _BookingCard({
    required this.className,
    required this.studioName,
    required this.date,
    required this.time,
    required this.instructor,
    required this.location,
    required this.credits,
    required this.status,
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
                GestureDetector(
                  onTap: () {
                    // Show cancel confirmation dialog
                    print('Cancel booking: $className');
                  },
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
