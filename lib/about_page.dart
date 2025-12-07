import 'package:flutter/material.dart';
import 'package:h1d023106_tugas7/side_menu.dart';
import 'package:h1d023106_tugas7/constants.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDurations.slow,
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'About',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.accentGradient,
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),

            // Content
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Hero Section
                  _buildHeroSection(),
                  const SizedBox(height: AppSpacing.xl),

                  // Features Section
                  Text('Fitur Aplikasi', style: AppTextStyles.headline2),
                  const SizedBox(height: AppSpacing.md),
                  _buildFeaturesList(),
                  const SizedBox(height: AppSpacing.xl),

                  // Info Section
                  _buildInfoCard(),
                  const SizedBox(height: AppSpacing.lg),
                ]),
              ),
            ),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }

  Widget _buildHeroSection() {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: AppShadows.largeShadow,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: const Icon(
                Icons.flutter_dash,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Flutter App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Aplikasi Mobile Modern',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: const Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.design_services,
        'title': 'Modern Design',
        'description': 'UI/UX yang menarik dengan gradien dan animasi',
        'color': AppColors.primary1,
      },
      {
        'icon': Icons.menu,
        'title': 'Easy Navigation',
        'description': 'Navigasi yang mudah dengan side menu',
        'color': AppColors.accent1,
      },
      {
        'icon': Icons.speed,
        'title': 'Fast Performance',
        'description': 'Performa aplikasi yang cepat dan responsif',
        'color': AppColors.success,
      },
      {
        'icon': Icons.security,
        'title': 'Secure',
        'description': 'Keamanan data dengan SharedPreferences',
        'color': AppColors.primary2,
      },
    ];

    return Column(
      children: features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;

        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(index * 0.1, 1.0, curve: Curves.easeOutCubic),
                ),
              ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(index * 0.1, 1.0, curve: Curves.easeInOut),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                boxShadow: AppShadows.smallShadow,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: (feature['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      feature['icon'] as IconData,
                      color: feature['color'] as Color,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature['title'] as String,
                          style: AppTextStyles.headline3,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feature['description'] as String,
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.cardGradient,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.primary1.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary1, size: 28),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Informasi Aplikasi',
                style: AppTextStyles.headline3.copyWith(
                  color: AppColors.primary1,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildInfoRow('Developer', 'Flutter Team'),
          _buildInfoRow('Platform', 'Android & iOS'),
          _buildInfoRow('Framework', 'Flutter 3.0+'),
          _buildInfoRow('License', 'MIT License'),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary1.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Row(
              children: [
                Icon(Icons.copyright, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: AppSpacing.xs),
                Text('2025 All rights reserved', style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
