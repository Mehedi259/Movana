import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_colors.dart';
import '../../services/profile_service.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  Future<void> _subscribeToPlan(BuildContext context, int planId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await ProfileService.subscribeToPlan(planId);
      if (context.mounted) {
        Navigator.pop(context); // Dismiss loading
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Plan subscribed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back to profile screen
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Dismiss loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Card'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Balance Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Current Balance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'PRO Plan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '120 Credits',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Monthly Usage',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const Text(
                        '120 / 150',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.8,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Buy More Credits ↑'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Choose Your Plan
            const Text(
              'Choose Your Plan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Starter Plan
            _PlanCard(
              name: 'STARTER',
              price: '\$29',
              priceDetail: '/mo (\$0.58 / credit)',
              features: const [
                '50 Credits monthly',
                'Basic class access',
                'Roll over up to 20 unused credits',
              ],
              buttonText: 'Select Plan',
              isRecommended: false,
              onTap: () => _subscribeToPlan(context, 1),
            ),
            const SizedBox(height: 16),
            // Pro Plan (Current)
            _PlanCard(
              name: 'PRO',
              price: '\$49',
              priceDetail: '/mo (\$0.33 / credit)',
              features: const [
                '150 Credits monthly',
                'Priority booking window',
                'Access to premium studios',
                'Roll over up to 20 unused credits',
              ],
              buttonText: 'Select Plan',
              isRecommended: true,
              isCurrent: false,
              onTap: () => _subscribeToPlan(context, 2),
            ),
            const SizedBox(height: 16),
            // Elite Plan
            _PlanCard(
              name: 'ELITE',
              price: '\$89',
              priceDetail: '/mo (\$0.30 / credit)',
              features: const [
                '300 Credits monthly',
                'Unlimited guest passes',
                'Roll over up to 20 unused credits',
              ],
              buttonText: 'Select Plan',
              isRecommended: false,
              onTap: () => _subscribeToPlan(context, 3),
            ),
            const SizedBox(height: 32),
            // Buy Extra Credits
            const Text(
              'Buy Extra Credits',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _CreditPackage(
                    credits: '+20 Credits',
                    price: '\$15',
                    pricePerCredit: '(\$0.50 /credit)',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CreditPackage(
                    credits: '+50 Credits',
                    price: '\$35',
                    pricePerCredit: '(\$0.44 /credit)',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _CreditPackage(
                    credits: '+100 Credits',
                    price: '\$65',
                    pricePerCredit: '(\$0.40 /credit)',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CreditPackage(
                    credits: '+200 Credits',
                    price: '\$120',
                    pricePerCredit: '(\$0.36 /credit)',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String priceDetail;
  final List<String> features;
  final String buttonText;
  final bool isRecommended;
  final bool isCurrent;
  final VoidCallback onTap;

  const _PlanCard({
    required this.name,
    required this.price,
    required this.priceDetail,
    required this.features,
    required this.buttonText,
    this.isRecommended = false,
    this.isCurrent = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primary.withOpacity(0.05) : AppColors.background,
        border: Border.all(
          color: isCurrent ? AppColors.primary : AppColors.divider,
          width: isCurrent ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              if (isRecommended)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  priceDetail,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 20, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feature,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isCurrent ? null : onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: isCurrent ? AppColors.primary : Colors.white,
                foregroundColor: isCurrent ? Colors.white : AppColors.primary,
                side: BorderSide(color: AppColors.primary),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditPackage extends StatelessWidget {
  final String credits;
  final String price;
  final String pricePerCredit;
  final VoidCallback onTap;

  const _CreditPackage({
    required this.credits,
    required this.price,
    required this.pricePerCredit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            credits,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            pricePerCredit,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('Buy'),
            ),
          ),
        ],
      ),
    );
  }
}
