import 'package:flutter/material.dart';
import 'package:h1d023106_tugas7/side_menu.dart';
import 'package:h1d023106_tugas7/constants.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Nature',
    'City',
    'People',
    'Abstract',
  ];

  final List<Map<String, dynamic>> photos = [
    {
      'category': 'Nature',
      'gradient': [Color(0xFF11998e), Color(0xFF38ef7d)],
    },
    {
      'category': 'City',
      'gradient': [Color(0xFF4776E6), Color(0xFF8E54E9)],
    },
    {
      'category': 'People',
      'gradient': [Color(0xFFFA8BFF), Color(0xFF2BD2FF)],
    },
    {
      'category': 'Abstract',
      'gradient': [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
    },
    {
      'category': 'Nature',
      'gradient': [Color(0xFF06beb6), Color(0xFF48b1bf)],
    },
    {
      'category': 'City',
      'gradient': [Color(0xFFe96443), Color(0xFF904e95)],
    },
    {
      'category': 'Abstract',
      'gradient': [Color(0xFF7F00FF), Color(0xFFE100FF)],
    },
    {
      'category': 'People',
      'gradient': [Color(0xFFFF512F), Color(0xFFDD2476)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPhotos = selectedCategory == 'All'
        ? photos
        : photos.where((p) => p['category'] == selectedCategory).toList();

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
                  'Gallery',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),

            // Category Filter
            SliverToBoxAdapter(
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: AppSpacing.sm),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? AppGradients.primaryGradient
                              : null,
                          color: isSelected ? null : Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          boxShadow: AppShadows.smallShadow,
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Gallery Grid
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.md),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final photo = filteredPhotos[index];
                  return _buildPhotoCard(photo, index);
                }, childCount: filteredPhotos.length),
              ),
            ),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }

  Widget _buildPhotoCard(Map<String, dynamic> photo, int index) {
    return Hero(
      tag: 'photo_$index',
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: photo['gradient'] as List<Color>,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: AppShadows.mediumShadow,
        ),
        child: Stack(
          children: [
            // Category Badge
            Positioned(
              top: AppSpacing.sm,
              right: AppSpacing.sm,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  photo['category'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Image Icon
            Center(
              child: Icon(
                Icons.image,
                size: 60,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
