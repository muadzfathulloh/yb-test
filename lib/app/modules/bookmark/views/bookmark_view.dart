import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/news_card.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Text(
                'Bookmark',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.filteredNews.isEmpty) {
                  return _buildEmptyState();
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.filteredNews.length,
                  itemBuilder: (context, index) {
                    final article = controller.filteredNews[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: NewsCard(
                        article: article,
                        type: NewsCardType.latest,
                        heroTag: 'bookmark_${article.url}',
                        onTap: () {
                          Get.toNamed(
                            '/news-detail',
                            arguments: {'article': article, 'heroTag': 'bookmark_${article.url}'},
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller.searchController,
          onChanged: (value) => controller.onSearch(value),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.poppins(color: AppColors.greyMedium),
            prefixIcon: const Icon(Icons.search, color: AppColors.greyMedium),
            suffixIcon: const Icon(Icons.tune, color: AppColors.greyMedium),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 80, color: AppColors.greyLight),
          const SizedBox(height: 16),
          Text(
            controller.searchQuery.isEmpty
                ? 'No bookmarks saved yet'
                : 'No articles match your search',
            style: GoogleFonts.poppins(color: AppColors.greyMedium, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
