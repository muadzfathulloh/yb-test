import 'package:get/get.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/models/news_article.dart';
import '../../../data/services/news_api_service.dart';

class LatestController extends GetxController {
  final NewsApiService _newsApiService = NewsApiService();

  final RxList<NewsArticle> articles = <NewsArticle>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLatestNews();
  }

  Future<void> fetchLatestNews() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetchedArticles = await _newsApiService.getNews(
        query: ApiConstants.defaultQuery,
        pageSize: 30,
      );
      articles.value = fetchedArticles;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void goToNewsDetail(NewsArticle article) {
    Get.toNamed('/news-detail', arguments: article);
  }
}
