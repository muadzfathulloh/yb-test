import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/news_article.dart';

class BookmarkService extends GetxService {
  final _storage = GetStorage();
  final String _key = 'bookmarks';
  final RxList<NewsArticle> bookmarks = <NewsArticle>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  void _loadFromStorage() {
    try {
      final List<dynamic>? data = _storage.read<List<dynamic>>(_key);
      if (data != null) {
        bookmarks.assignAll(
          data.map((e) => NewsArticle.fromJson(e as Map<String, dynamic>)).toList(),
        );
      }
    } catch (e) {
      print('BookmarkService Error : $e');
    }
  }

  Future<void> saveBookmark(NewsArticle article) async {
    print('BookmarkService: Saving article ${article.title}');
    if (!bookmarks.any((e) => e.url == article.url)) {
      bookmarks.add(article);
      await _storage.write(_key, bookmarks.map((e) => e.toJson()).toList());
    } else {}
  }

  Future<void> removeBookmark(String url) async {
    bookmarks.removeWhere((e) => e.url == url);
    await _storage.write(_key, bookmarks.map((e) => e.toJson()).toList());
  }

  bool isBookmarked(String url) {
    return bookmarks.any((e) => e.url == url);
  }
}
