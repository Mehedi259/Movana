import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I cancel a class?',
      'answer':
          'You can cancel a booked class from the "My Bookings" section. Simply open your upcoming booking and tap "Cancel". If the cancellation is made within the allowed time window, your credits will be returned automatically.',
    },
    {
      'question': 'How do credits work?',
      'answer':
          'Credits are used to book classes across different studios. Each class requires a specific number of credits depending on factors like time, popularity, and demand. You can purchase credits through subscription plans or top-ups and use them anytime to book sessions.',
    },
    {
      'question': 'Can I roll over my credits?',
      'answer':
          'Yes, unused credits can roll over to the next billing cycle depending on your subscription plan. Please note that rollover limits may apply based on your selected plan.',
    },
    {
      'question': 'What is the late cancellation policy?',
      'answer':
          'If you cancel a class within the late cancellation window (usually within 12 hours before the class starts), your credits may not be refunded. Missing a class without cancellation may also result in a penalty.',
    },
    {
      'question': 'Is my personal data safe?',
      'answer':
          'To book a class, browse or search for a studio, select your preferred session, and tap "Book Now." Once confirmed, the required credits will be deducted from your balance, and your spot will be reserved instantly.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final faq = _faqs[index];
          final isExpanded = _expandedIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    faq['question']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  ),
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      faq['answer']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
