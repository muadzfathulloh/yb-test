import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/news_card.dart';
import '../controllers/trending_controller.dart';

class TrendingView extends GetView<TrendingController> {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Trending',
          style: GoogleFonts.poppins(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.articles.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty && controller.articles.isEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchTrendingNews,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.articles.length,
            itemBuilder: (context, index) {
              final article = controller.articles[index];
              return NewsCard(
                article: article,
                type: NewsCardType.trending,
                onTap: () => controller.goToNewsDetail(article),
              );
            },
          ),
        );
      }),
    );
  }
}
