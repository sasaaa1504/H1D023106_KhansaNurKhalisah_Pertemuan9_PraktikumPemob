import 'package:flutter/material.dart';
import 'package:h1d023106_tugas7/home_page.dart';
import 'package:h1d023106_tugas7/about_page.dart';
import 'package:h1d023106_tugas7/gallery_page.dart';
import 'package:h1d023106_tugas7/services_page.dart';
import 'package:h1d023106_tugas7/contact_page.dart';
import 'package:h1d023106_tugas7/profile_page.dart';
import 'package:h1d023106_tugas7/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF7FAFC), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Custom Drawer Header
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: AppGradients.primaryGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      boxShadow: AppShadows.mediumShadow,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primary1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    namauser ?? 'Loading...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: const Text(
                      'Premium User',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Menu Items
            _buildMenuItem(
              context,
              Icons.home,
              'Home',
              const HomePage(),
              AppColors.primary1,
            ),
            _buildMenuItem(
              context,
              Icons.photo_library,
              'Gallery',
              const GalleryPage(),
              Color(0xFF11998e),
            ),
            _buildMenuItem(
              context,
              Icons.business_center,
              'Services',
              const ServicesPage(),
              Color(0xFF6B73FF),
            ),
            _buildMenuItem(
              context,
              Icons.contact_mail,
              'Contact',
              const ContactPage(),
              Color(0xFF00C9FF),
            ),
            _buildMenuItem(
              context,
              Icons.person_outline,
              'Profile',
              const ProfilePage(),
              Color(0xFFf5576c),
            ),
            _buildMenuItem(
              context,
              Icons.info,
              'About',
              const AboutPage(),
              AppColors.accent1,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Divider(),
            ),

            // Settings & Logout
            _buildMenuItem(
              context,
              Icons.settings,
              'Settings',
              null,
              AppColors.textSecondary,
            ),
            _buildMenuItem(
              context,
              Icons.logout,
              'Logout',
              null,
              AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget? page,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textLight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        onTap: () {
          Navigator.pop(context); // Close drawer
          if (page != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
      ),
    );
  }
}
