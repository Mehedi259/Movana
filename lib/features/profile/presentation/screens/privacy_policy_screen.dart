import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _ExpandableSection(
            title: '1. Information We Collect',
            content: '''We collect information you provide directly to us, including:

• Personal information (name, email, phone number)
• Profile information (fitness preferences, location)
• Payment information (credit card details)
• Usage data (classes booked, studios visited)
• Device information (IP address, browser type)

We use this information to provide and improve our services, process your bookings, and communicate with you about your account.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '2. How We Use Your Information',
            content: '''We use the information we collect to:

• Provide, maintain, and improve our services
• Process your bookings and transactions
• Send you technical notices and support messages
• Respond to your comments and questions
• Send you marketing communications (with your consent)
• Monitor and analyze trends and usage
• Detect and prevent fraud and abuse
• Comply with legal obligations

We will never sell your personal information to third parties.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '3. Information Sharing',
            content: '''We may share your information with:

• Fitness studios and instructors for booking purposes
• Payment processors to handle transactions
• Service providers who assist in our operations
• Law enforcement when required by law
• Other parties with your consent

We require all third parties to respect the security of your personal data and treat it in accordance with the law.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '4. Data Security',
            content: '''We implement appropriate technical and organizational measures to protect your personal information, including:

• Encryption of data in transit and at rest
• Regular security assessments
• Access controls and authentication
• Secure payment processing
• Regular backups and disaster recovery

However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute security.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '5. Your Rights',
            content: '''You have the right to:

• Access your personal information
• Correct inaccurate information
• Request deletion of your information
• Object to processing of your information
• Request restriction of processing
• Data portability
• Withdraw consent at any time

To exercise these rights, please contact us at privacy@movana.com.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '6. Cookies and Tracking',
            content: '''We use cookies and similar tracking technologies to:

• Remember your preferences
• Understand how you use our services
• Improve your experience
• Deliver personalized content

You can control cookies through your browser settings. However, disabling cookies may limit your ability to use certain features.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '7. Children\'s Privacy',
            content: '''Our services are not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13.

If you are a parent or guardian and believe your child has provided us with personal information, please contact us immediately.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '8. Changes to This Policy',
            content: '''We may update this Privacy Policy from time to time. We will notify you of any changes by:

• Posting the new policy on this page
• Updating the "Last Updated" date
• Sending you an email notification (for material changes)

Your continued use of our services after changes constitutes acceptance of the updated policy.''',
          ),
          SizedBox(height: 12),
          _ExpandableSection(
            title: '9. Contact Us',
            content: '''If you have any questions about this Privacy Policy, please contact us:

Email: privacy@movana.com
Phone: +1 (555) 123-4567
Address: 123 Fitness Street, San Francisco, CA 94102

We will respond to your inquiry within 30 days.''',
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
