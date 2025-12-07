import 'package:flutter/material.dart';
import 'package:h1d023106_tugas7/side_menu.dart';
import 'package:h1d023106_tugas7/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var namauser;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = prefs.getString('username') ?? 'User';
    });
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
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          boxShadow: AppShadows.largeShadow,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Color(0xFFf5576c),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        namauser ?? 'Loading...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  // Stats Section
                  _buildStatsSection(),
                  const SizedBox(height: AppSpacing.lg),

                  // Activity Section
                  Text('Aktivitas Terkini', style: AppTextStyles.headline2),
                  const SizedBox(height: AppSpacing.md),
                  _buildActivityCard(
                    'Login berhasil',
                    'Anda login ke aplikasi',
                    Icons.login,
                    AppColors.success,
                    'Baru saja',
                  ),
                  _buildActivityCard(
                    'Profile Updated',
                    'Informasi profil diperbarui',
                    Icons.edit,
                    AppColors.primary1,
                    '2 jam yang lalu',
                  ),
                  _buildActivityCard(
                    'New Achievement',
                    'Mendapatkan badge "Early Adopter"',
                    Icons.star,
                    AppColors.warning,
                    'Kemarin',
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Settings Section
                  Text('Pengaturan', style: AppTextStyles.headline2),
                  const SizedBox(height: AppSpacing.md),
                  _buildSettingsList(),

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

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: AppShadows.mediumShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('45', 'Posts', Icons.article),
          Container(
            width: 1,
            height: 40,
            color: AppColors.textLight.withOpacity(0.3),
          ),
          _buildStatItem('1.2K', 'Followers', Icons.people),
          Container(
            width: 1,
            height: 40,
            color: AppColors.textLight.withOpacity(0.3),
          ),
          _buildStatItem('320', 'Following', Icons.person_add),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary1, size: 28),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: AppTextStyles.headline3),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildActivityCard(
    String title,
    String description,
    IconData icon,
    Color color,
    String time,
  ) {
    return Container(
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
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headline3.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(description, style: AppTextStyles.caption),
              ],
            ),
          ),
          Text(time, style: AppTextStyles.caption.copyWith(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    final settings = [
      {
        'icon': Icons.notifications,
        'title': 'Notifikasi',
        'color': AppColors.accent1,
      },
      {'icon': Icons.security, 'title': 'Keamanan', 'color': AppColors.success},
      {
        'icon': Icons.privacy_tip,
        'title': 'Privasi',
        'color': AppColors.primary2,
      },
      {'icon': Icons.help, 'title': 'Bantuan', 'color': AppColors.warning},
    ];

    return Column(
      children: settings.map((setting) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: AppShadows.smallShadow,
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: (setting['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                setting['icon'] as IconData,
                color: setting['color'] as Color,
                size: 24,
              ),
            ),
            title: Text(
              setting['title'] as String,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textLight,
            ),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}
