import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _ExpandableSection(
            title: '1. Acceptance of Terms',
            content: '''By accessing and using Movana's services, you accept and agree to be bound by these Terms and Conditions.

If you do not agree to these terms, you may not use our services. We reserve the right to modify these terms at any time, and your continued use constitutes acceptance of any changes.

These terms apply to all users of the service, including browsers, customers, and contributors of content.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '2. Account Registration',
            content: '''To use our services, you must:

• Be at least 18 years old
• Provide accurate and complete information
• Maintain the security of your account
• Notify us immediately of any unauthorized use
• Accept responsibility for all activities under your account

You may not:
• Share your account credentials
• Create multiple accounts
• Use another person's account
• Impersonate any person or entity''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '3. Booking and Payments',
            content: '''When booking classes through Movana:

• All bookings are subject to availability
• Payment is required at the time of booking
• Prices are subject to change without notice
• You are responsible for all charges incurred
• Credits are non-refundable and non-transferable
• Promotional offers may have specific terms

Cancellation Policy:
• Cancel up to 12 hours before class for full credit
• Late cancellations forfeit 50% of credits
• No-shows forfeit 100% of credits''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '4. User Conduct',
            content: '''You agree to use our services only for lawful purposes. You must not:

• Violate any laws or regulations
• Infringe on intellectual property rights
• Transmit harmful or malicious code
• Harass, abuse, or harm others
• Interfere with the service's operation
• Attempt unauthorized access to systems
• Use automated systems to access the service
• Collect user information without consent

Violations may result in account suspension or termination.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '5. Intellectual Property',
            content: '''All content on Movana, including:

• Text, graphics, logos, and images
• Software and source code
• Trademarks and service marks
• Design and layout

...is owned by Movana or its licensors and protected by copyright, trademark, and other intellectual property laws.

You may not reproduce, distribute, modify, or create derivative works without our express written permission.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '6. Liability and Disclaimers',
            content: '''Movana provides services "as is" without warranties of any kind.

We are not liable for:
• Injuries sustained during fitness activities
• Loss or damage to personal property
• Service interruptions or errors
• Actions of third-party studios or instructors
• Indirect, incidental, or consequential damages

You assume all risks associated with fitness activities. Consult a physician before beginning any exercise program.

Our total liability shall not exceed the amount you paid for services in the past 12 months.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '7. Indemnification',
            content: '''You agree to indemnify and hold harmless Movana, its officers, directors, employees, and agents from any claims, damages, losses, or expenses arising from:

• Your use of the services
• Your violation of these terms
• Your violation of any rights of others
• Your conduct in connection with the services

This indemnification obligation survives termination of your account.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '8. Termination',
            content: '''We may terminate or suspend your account at any time for:

• Violation of these terms
• Fraudulent or illegal activity
• Abuse of the service
• Non-payment of fees
• Any other reason at our discretion

Upon termination:
• Your right to use the service ceases immediately
• Unused credits are forfeited
• We may delete your account and data
• Certain provisions of these terms survive termination''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '9. Dispute Resolution',
            content: '''Any disputes arising from these terms or your use of our services shall be resolved through:

1. Good faith negotiation between parties
2. Binding arbitration if negotiation fails
3. Arbitration conducted in San Francisco, CA
4. Governed by California law

You waive the right to participate in class action lawsuits. Each party bears its own costs unless otherwise awarded by the arbitrator.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '10. General Provisions',
            content: '''Governing Law: These terms are governed by California law.

Severability: If any provision is found invalid, the remaining provisions remain in effect.

Entire Agreement: These terms constitute the entire agreement between you and Movana.

No Waiver: Our failure to enforce any right does not waive that right.

Assignment: You may not assign these terms. We may assign them without notice.

Contact: For questions about these terms, contact legal@movana.com''',
          ),
          SizedBox(height: 24),
          Text(
            'Last Updated: May 9, 2026',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ExpandableSection extends StatefulWidget {
  final String title;
  final String content;

  const _ExpandableSection({
    required this.title,
    required this.content,
  });

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.content,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
