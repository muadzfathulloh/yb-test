import 'package:flutter/material.dart';
import 'package:flutter_getx_app/app/core/constants/api_constants.dart';
import 'package:get/get.dart';

import '../../../data/models/news_article.dart';
import '../../../data/services/news_api_service.dart';

class DashboardController extends GetxController {
  final NewsApiService _newsApiService = NewsApiService();

  // Observable states
  final RxList<NewsArticle> newsList = <NewsArticle>[].obs;
  final RxList<NewsArticle> trendingNewsList = <NewsArticle>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingTrending = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  // Scroll Controller
  final scrollController = ScrollController();

  // Search & Filter
  final searchController = TextEditingController();
  final RxString selectedCategory = 'All'.obs;
  final RxString _searchQuery = ''.obs;
  final List<String> categories = [
    'All',
    'Technology',
    'Business',
    'Finance',
    'Sports',
    'Health',
    'Entertainment',
  ];

  // Pagination
  int currentPage = 1;
  final int pageSize = 20;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchTrendingNews();
    fetchNews();

    // Add scroll listener for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });

    // Debounce search input only
    debounce(_searchQuery, (_) => fetchNews(), time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  // Handle search text change
  void onSearchChanged(String value) {
    _searchQuery.value = value;
  }

  // Get query string for API
  String get _currentQuery {
    String query = _searchQuery.value.trim();
    if (query.isEmpty) {
      // Use category as fallback query if search is empty
      // NewsAPI Everything requires at least one query parameter
      query = selectedCategory.value == 'All' ? ApiConstants.defaultQuery : selectedCategory.value;
    }
    return query;
  }

  // Fetch trending news (top-headlines)
  Future<void> fetchTrendingNews() async {
    if (isLoadingTrending.value) return;
    try {
      isLoadingTrending.value = true;
      final articles = await _newsApiService.getTrendingNews();
      trendingNewsList.value = articles;
    } catch (e) {
      debugPrint('Error fetching trending news: $e');
    } finally {
      isLoadingTrending.value = false;
    }
  }

  // Fetch news from API (first page)
  Future<void> fetchNews() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      errorMessage.value = '';
      currentPage = 1;
      hasMore = true;

      // Show loading dialog for a smoother experience
      if (newsList.isNotEmpty) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      }

      final articles = await _newsApiService.getNews(
        query: _currentQuery,
        pageSize: pageSize,
        page: currentPage,
      );

      newsList.value = articles;

      if (articles.length < pageSize) {
        hasMore = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      // Close the loading dialog if it's open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }

  // Load more news (pagination)
  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;

    try {
      isLoadingMore.value = true;
      currentPage++;

      final articles = await _newsApiService.getNews(
        query: _currentQuery,
        pageSize: pageSize,
        page: currentPage,
      );

      if (articles.isEmpty || articles.length < pageSize) {
        hasMore = false;
      }

      newsList.addAll(articles);
    } catch (e) {
      currentPage--;
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Refresh news (for pull-to-refresh)
  Future<void> refreshNews() async {
    await fetchNews();
  }

  // Set selected category
  void setCategory(String category) {
    if (selectedCategory.value != category) {
      selectedCategory.value = category;
      fetchNews(); // Fetch immediately
    }
  }

  // Handle search submit
  void onSearchSubmitted(String value) {
    if (value.trim().isEmpty) return;

    // Combine trending and latest for local filtering in the search page
    final allArticles = [...trendingNewsList, ...newsList];

    Get.toNamed('/search', arguments: {'articles': allArticles, 'query': value});
  }

  // Navigate to news detail
  void goToNewsDetail(NewsArticle article, {String? heroTag}) {
    Get.toNamed('/news-detail', arguments: {'article': article, 'heroTag': heroTag});
  }

  void goToTrending() {
    Get.toNamed('/trending');
  }

  void goToLatest() {
    Get.toNamed('/latest');
  }
}
