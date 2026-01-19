import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/news_article.dart';
import '../theme/app_colors.dart';

enum NewsCardType { trending, latest }

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onTap;
  final NewsCardType type;
  final String? heroTag;

  const NewsCard({
    super.key,
    required this.article,
    required this.onTap,
    this.type = NewsCardType.latest,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    if (type == NewsCardType.trending) {
      return _buildTrendingCard(context);
    }
    return _buildLatestCard(context);
  }

  Widget _buildTrendingCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: heroTag ?? 'trending_${article.url}',
                child: (article.urlToImage == null || article.urlToImage!.isEmpty)
                    ? Container(
                        height: 180,
                        width: double.infinity,
                        color: AppColors.greyLight,
                        child: const Icon(Icons.broken_image, color: AppColors.greyMedium),
                      )
                    : CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.greyLight,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.greyLight,
                          child: const Icon(Icons.broken_image, color: AppColors.greyMedium),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Trending',
                    style: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyMedium),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSourceLogo(article.sourceName ?? 'N'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          article.sourceName ?? 'Unknown',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyDarker,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, size: 14, color: AppColors.greyMedium),
                      const SizedBox(width: 4),
                      Text(
                        _formatTimeAgo(article.publishedAt),
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyMedium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: heroTag ?? 'latest_${article.url}',
                child: (article.urlToImage == null || article.urlToImage!.isEmpty)
                    ? Container(
                        width: 100,
                        height: 100,
                        color: AppColors.greyLight,
                        child: const Icon(Icons.broken_image, color: AppColors.greyMedium),
                      )
                    : CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(width: 100, height: 100, color: AppColors.greyLight),
                        errorWidget: (context, url, error) => Container(
                          width: 100,
                          height: 100,
                          color: AppColors.greyLight,
                          child: const Icon(Icons.broken_image, color: AppColors.greyMedium),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest',
                    style: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyMedium),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSourceLogo(article.sourceName ?? 'N'),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          article.sourceName ?? 'Unknown',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyDarker,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, size: 12, color: AppColors.greyMedium),
                      const SizedBox(width: 3),
                      Text(
                        _formatTimeAgo(article.publishedAt),
                        style: GoogleFonts.poppins(fontSize: 11, color: AppColors.greyMedium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceLogo(String source) {
    Color color = Colors.blue;
    if (source.contains('BBC')) color = Colors.red;
    if (source.contains('CNN')) color = Colors.redAccent;
    if (source.contains('Reuters')) color = Colors.orange;

    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text(
          source.isNotEmpty ? source[0] : 'N',
          style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
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
