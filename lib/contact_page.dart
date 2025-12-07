import 'package:flutter/material.dart';
import 'package:h1d023106_tugas7/side_menu.dart';
import 'package:h1d023106_tugas7/constants.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
                  'Contact',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                  // Header
                  Text('Hubungi Kami', style: AppTextStyles.headline1),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Kami siap membantu Anda',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Contact Cards
                  _buildContactCard(
                    Icons.email,
                    'Email',
                    'info@flutterapp.com',
                    AppColors.primary1,
                  ),
                  _buildContactCard(
                    Icons.phone,
                    'Phone',
                    '+62 812 3456 7890',
                    AppColors.success,
                  ),
                  _buildContactCard(
                    Icons.location_on,
                    'Address',
                    'Jakarta, Indonesia',
                    AppColors.accent1,
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Social Media Section
                  Text('Ikuti Kami', style: AppTextStyles.headline2),
                  const SizedBox(height: AppSpacing.md),
                  _buildSocialMediaSection(),

                  const SizedBox(height: AppSpacing.xl),

                  // Map Placeholder
                  _buildMapPlaceholder(),
                ]),
              ),
            ),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }

  Widget _buildContactCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
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
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.headline3),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: AppColors.textLight, size: 16),
        ],
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    final socialMedia = [
      {'icon': Icons.facebook, 'name': 'Facebook', 'color': Color(0xFF1877F2)},
      {
        'icon': Icons.camera_alt,
        'name': 'Instagram',
        'color': Color(0xFFE4405F),
      },
      {'icon': Icons.send, 'name': 'Twitter', 'color': Color(0xFF1DA1F2)},
      {'icon': Icons.chat, 'name': 'WhatsApp', 'color': Color(0xFF25D366)},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.5,
      ),
      itemCount: socialMedia.length,
      itemBuilder: (context, index) {
        final social = socialMedia[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: AppShadows.smallShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                social['icon'] as IconData,
                color: social['color'] as Color,
                size: 40,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                social['name'] as String,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: AppShadows.mediumShadow,
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 60, color: Colors.white.withOpacity(0.5)),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Lokasi Kami',
                  style: AppTextStyles.headline3.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: AppSpacing.md,
            right: AppSpacing.md,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.directions, color: AppColors.primary1, size: 20),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Get Directions',
                    style: TextStyle(
                      color: AppColors.primary1,
                      fontWeight: FontWeight.w600,
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
}
