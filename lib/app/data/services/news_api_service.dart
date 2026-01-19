import '../../core/constants/api_constants.dart';
import '../models/news_article.dart';
import 'api_service.dart';

class NewsApiService {
  final ApiService _apiService = ApiService();

  // Fetch news articles with support for query, pageSize, and page
  Future<List<NewsArticle>> getNews({
    String query = 'tesla',
    int pageSize = 20,
    int page = 1,
  }) async {
    try {
      final response = await _apiService.get(
        ApiConstants.everythingEndpoint,
        queryParameters: {
          'q': query,
          'sortBy': 'publishedAt',
          'pageSize': pageSize,
          'page': page,
          'apiKey': ApiConstants.newsApiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final articles = data['articles'] as List;

        return articles
            .map((article) => NewsArticle.fromJson(article as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch trending news (top headlines)
  Future<List<NewsArticle>> getTrendingNews({int pageSize = 5}) async {
    try {
      final response = await _apiService.get(
        ApiConstants.topHeadlinesEndpoint,
        queryParameters: {
          'country': ApiConstants.defaultCountry,
          'pageSize': pageSize,
          'apiKey': ApiConstants.newsApiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final articles = data['articles'] as List;

        return articles
            .map((article) => NewsArticle.fromJson(article as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load trending news: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Search news by query
  Future<List<NewsArticle>> searchNews({required String query, int pageSize = 20}) async {
    try {
      final response = await _apiService.get(
        ApiConstants.everythingEndpoint,
        queryParameters: {'q': query, 'pageSize': pageSize, 'apiKey': ApiConstants.newsApiKey},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final articles = data['articles'] as List;

        return articles
            .map((article) => NewsArticle.fromJson(article as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
