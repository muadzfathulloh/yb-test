import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/news_card.dart';
import '../controllers/search_controller.dart';

class SearchResultView extends GetView<SearchResultController> {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Search Results',
          style: GoogleFonts.poppins(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
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
                        heroTag: 'search_${article.url}',
                        onTap: () {
                          Get.toNamed(
                            '/news-detail',
                            arguments: {'article': article, 'heroTag': 'search_${article.url}'},
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
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: TextField(
          controller: controller.searchController,
          onChanged: (value) => controller.onSearch(value),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.poppins(color: AppColors.greyMedium),
            prefixIcon: const Icon(Icons.search, color: AppColors.greyMedium),
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
          Icon(Icons.search_off, size: 80, color: AppColors.greyLight),
          const SizedBox(height: 16),
          Text(
            'No articles found',
            style: GoogleFonts.poppins(
              color: AppColors.greyMedium,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords',
            style: GoogleFonts.poppins(color: AppColors.greyMedium, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
