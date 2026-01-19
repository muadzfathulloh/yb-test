import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/news_detail_controller.dart';

class NewsDetailView extends GetView<NewsDetailController> {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final article = controller.article;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with share and back
          SliverAppBar(
            expandedHeight: 0,
            pinned: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: AppColors.black),
                onPressed: () => controller.shareArticle(),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: AppColors.black),
                onPressed: () {},
              ),
            ],
          ),

          // Source Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildSourceAvatar(article.sourceName ?? 'Unknown'),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.sourceName ?? 'Unknown',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        _formatTimeAgo(article.publishedAt),
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyMedium),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    ),
                    child: const Text('Following'),
                  ),
                ],
              ),
            ),
          ),

          // Hero Image
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Hero(
                  tag: controller.heroTag ?? 'latest_${article.url}',
                  child: (article.urlToImage == null || article.urlToImage!.isEmpty)
                      ? Container(
                          height: 250,
                          width: double.infinity,
                          color: AppColors.greyLight,
                          child: const Icon(
                            Icons.broken_image,
                            size: 64,
                            color: AppColors.greyMedium,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: article.urlToImage!,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.greyLight,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.greyLight,
                            child: const Icon(
                              Icons.broken_image,
                              size: 64,
                              color: AppColors.greyMedium,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),

          // Category Label
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Europe',
                    style: GoogleFonts.poppins(fontSize: 14, color: AppColors.greyMedium),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title ?? 'No Title',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.content ?? article.description ?? 'No content available.',
                style: GoogleFonts.poppins(fontSize: 16, color: AppColors.greyDarker, height: 1.6),
              ),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),

      // Bottom Interaction Bar
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.greyLight)),
        ),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: controller.toggleLike,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      controller.isLiked.value ? Icons.favorite : Icons.favorite_border,
                      size: 24,
                      color: controller.isLiked.value ? Colors.red : AppColors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.formatCount(controller.likeCount.value),
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.goToComments,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 12),
                    const Icon(Icons.chat_bubble_outline, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      controller.formatCount(controller.commentCount.value),
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Obx(
                () => IconButton(
                  onPressed: controller.toggleBookmark,
                  icon: Icon(
                    controller.isBookmarked.value ? Icons.bookmark : Icons.bookmark_border,
                    size: 24,
                    color: controller.isBookmarked.value ? AppColors.primary : AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSourceAvatar(String source) {
    Color color = Colors.blue;
    if (source.contains('BBC')) color = Colors.red;
    if (source.contains('CNN')) color = Colors.redAccent;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          source.isNotEmpty ? source[0].toUpperCase() : 'N',
          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime? date) {
    if (date == null) return '';
    try {
      final Duration diff = DateTime.now().difference(date);

      if (diff.inDays > 0) return '${diff.inDays}d ago';
      if (diff.inHours > 0) return '${diff.inHours}h ago';
      if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
      return 'just now';
    } catch (e) {
      return '';
    }
  }
}
