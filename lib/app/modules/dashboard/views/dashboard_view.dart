import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/news_card.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          '',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNews,
          color: AppColors.primary,
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: controller.onSearchChanged,
                    onSubmitted: controller.onSearchSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(color: AppColors.greyMedium),
                      prefixIcon: const Icon(Icons.search, color: AppColors.greyMedium),
                      suffixIcon: const Icon(Icons.tune, color: AppColors.greyMedium),
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.greyLight),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.greyLight),
                      ),
                    ),
                  ),
                ),
              ),

              // Trending Section Header
              _buildSectionHeader('Trending', () => controller.goToTrending()),

              // Trending List (Horizontal)
              SliverToBoxAdapter(
                child: Obx(() {
                  if (controller.isLoadingTrending.value) {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (controller.trendingNewsList.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return SizedBox(
                    height: 320,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.trendingNewsList.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final article = controller.trendingNewsList[index];
                        return SizedBox(
                          width: 320,
                          child: NewsCard(
                            article: article,
                            type: NewsCardType.trending,
                            heroTag: 'trending_${article.url}',
                            onTap: () => controller.goToNewsDetail(
                              article,
                              heroTag: 'trending_${article.url}',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),

              // Latest Section Header
              _buildSectionHeader('Latest', () => controller.goToLatest()),

              // Category Chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Obx(() {
                            final isSelected = controller.selectedCategory.value == category;
                            return GestureDetector(
                              onTap: () => controller.setCategory(category),
                              child: Column(
                                children: [
                                  Text(
                                    category,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? AppColors.black : AppColors.greyMedium,
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      height: 2,
                                      width: 20,
                                      color: AppColors.primary,
                                    ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Latest News List (Vertical)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == controller.newsList.length) {
                    return controller.isLoadingMore.value
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                          )
                        : const SizedBox.shrink();
                  }

                  final article = controller.newsList[index];
                  return NewsCard(
                    article: article,
                    type: NewsCardType.latest,
                    heroTag: 'latest_${article.url}',
                    onTap: () =>
                        controller.goToNewsDetail(article, heroTag: 'latest_${article.url}'),
                  );
                }, childCount: controller.newsList.length + 1),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                'See all',
                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.greyMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
