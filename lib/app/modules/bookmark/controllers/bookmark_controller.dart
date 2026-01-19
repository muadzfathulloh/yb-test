import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/news_article.dart';
import '../../../data/services/bookmark_service.dart';

class BookmarkController extends GetxController {
  final _bookmarkService = Get.find<BookmarkService>();
  final searchController = TextEditingController();

  final RxList<NewsArticle> filteredNews = <NewsArticle>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    print('BookmarkController: onInit triggered.');

    // Initially load from service
    _filterNews();

    // Directly listen to the RxList stream for updates
    _bookmarkService.bookmarks.listen((_) {
      print('BookmarkController: Detected change in bookmarks list.');
      _filterNews();
    });

    // Listen to search query
    ever(searchQuery, (_) => _filterNews());
  }

  void _filterNews() {
    final all = _bookmarkService.bookmarks;
    print('BookmarkController: Filtering ${all.length} items. Query: "${searchQuery.value}"');

    if (searchQuery.isEmpty) {
      filteredNews.assignAll(all);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredNews.assignAll(
        all.where(
          (article) =>
              (article.title?.toLowerCase().contains(query) ?? false) ||
              (article.description?.toLowerCase().contains(query) ?? false),
        ),
      );
    }
    print('BookmarkController: Updated filteredNews. New count: ${filteredNews.length}');
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  void removeBookmark(String url) async {
    await _bookmarkService.removeBookmark(url);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
