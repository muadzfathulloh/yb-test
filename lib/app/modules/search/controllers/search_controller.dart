import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/news_article.dart';

class SearchResultController extends GetxController {
  final searchController = TextEditingController();

  // All articles passed from Dashboard
  final RxList<NewsArticle> allArticles = <NewsArticle>[].obs;
  // Filtered results
  final RxList<NewsArticle> filteredNews = <NewsArticle>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Retrieve arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      final List<NewsArticle> initialArticles = args['articles'] as List<NewsArticle>? ?? [];
      final String initialQuery = args['query'] as String? ?? '';

      allArticles.assignAll(initialArticles);
      searchQuery.value = initialQuery;
      searchController.text = initialQuery;
    }

    // Initial filter
    _filterNews();

    // Listen to query changes
    ever(searchQuery, (_) => _filterNews());
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  void _filterNews() {
    if (searchQuery.isEmpty) {
      filteredNews.assignAll(allArticles);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredNews.assignAll(
        allArticles
            .where(
              (article) =>
                  (article.title?.toLowerCase().contains(query) ?? false) ||
                  (article.description?.toLowerCase().contains(query) ?? false) ||
                  (article.sourceName?.toLowerCase().contains(query) ?? false),
            )
            .toList(),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
