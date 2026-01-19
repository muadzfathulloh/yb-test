import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/news_article.dart';
import '../../../data/services/bookmark_service.dart';

class NewsDetailController extends GetxController {
  late NewsArticle article;
  String? heroTag;
  final _bookmarkService = Get.find<BookmarkService>();

  // Interaction states
  final RxBool isLiked = false.obs;
  final RxInt likeCount = 24500.obs; // Dummy 24.5K
  final RxInt commentCount = 1000.obs; // Dummy 1K
  final RxBool isBookmarked = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get article and heroTag from arguments map
    final args = Get.arguments as Map<String, dynamic>;
    article = args['article'] as NewsArticle;
    heroTag = args['heroTag'] as String?;

    isBookmarked.value = _bookmarkService.isBookmarked(article.url ?? '');
  }

  Future<void> shareArticle() async {
    try {
      if (article.url != null) {
        await SharePlus.instance.share(
          ShareParams(text: '${article.title}\n\nRead more at: ${article.url}'),
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Could not open share menu', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void toggleBookmark() {
    if (isBookmarked.value) {
      _bookmarkService.removeBookmark(article.url ?? '');
      isBookmarked.value = false;
      Get.snackbar(
        'Success',
        'Removed from bookmarks (${_bookmarkService.bookmarks.length})',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      _bookmarkService.saveBookmark(article);
      isBookmarked.value = true;
      Get.snackbar(
        'Success',
        'Added to bookmarks (${_bookmarkService.bookmarks.length})',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
    if (isLiked.value) {
      likeCount.value++;
    } else {
      likeCount.value--;
    }
  }

  void goToComments() {
    Get.toNamed('/comments');
  }

  // Helper to format counts
  String formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  // Open article in browser
  Future<void> openInBrowser() async {
    if (article.url != null) {
      final uri = Uri.parse(article.url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Error', 'Could not open article', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
