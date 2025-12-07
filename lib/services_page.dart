import 'package:flutter/material.dart';
import 'package:h1d023106_tugas7/side_menu.dart';
import 'package:h1d023106_tugas7/constants.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> services = [
    {
      'icon': Icons.phone_android,
      'title': 'Mobile Development',
      'description':
          'Pengembangan aplikasi mobile Android & iOS dengan Flutter',
      'color': AppColors.primary1,
      'features': ['Cross-platform', 'Native Performance', 'Hot Reload'],
    },
    {
      'icon': Icons.web,
      'title': 'Web Development',
      'description': 'Pembuatan website modern dan responsif',
      'color': AppColors.accent1,
      'features': ['Responsive Design', 'SEO Optimized', 'Fast Loading'],
    },
    {
      'icon': Icons.cloud,
      'title': 'Cloud Services',
      'description': 'Layanan cloud computing dan hosting',
      'color': AppColors.primary2,
      'features': ['Scalable', 'Secure', '99.9% Uptime'],
    },
    {
      'icon': Icons.design_services,
      'title': 'UI/UX Design',
      'description': 'Desain antarmuka yang menarik dan user-friendly',
      'color': AppColors.success,
      'features': ['Modern Design', 'User Research', 'Prototyping'],
    },
  ];

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
                  'Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6B73FF), Color(0xFF000DFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),

            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Layanan Kami', style: AppTextStyles.headline1),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Solusi digital terbaik untuk bisnis Anda',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            // Services List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              index * 0.15,
                              1.0,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                        ),
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            index * 0.15,
                            1.0,
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                      child: _buildServiceCard(services[index]),
                    ),
                  );
                }, childCount: services.length),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.mediumShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: (service['color'] as Color).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.lg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        service['color'] as Color,
                        (service['color'] as Color).withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: [
                      BoxShadow(
                        color: (service['color'] as Color).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['title'] as String,
                        style: AppTextStyles.headline3,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['description'] as String,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Features
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fitur Unggulan:',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ...(service['features'] as List<String>).map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: service['color'] as Color,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(feature, style: AppTextStyles.bodyMedium),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: AppSpacing.md),

                // CTA Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: service['color'] as Color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Pelajari Lebih Lanjut',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
