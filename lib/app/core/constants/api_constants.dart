class ApiConstants {
  ApiConstants._();

  // News API
  static const String newsApiBaseUrl = 'https://newsapi.org/v2/';
  static const String newsApiKey = '177fad0842d64e09a5261932c2d3f60b';

  // Endpoints
  static const String topHeadlinesEndpoint = 'top-headlines';
  static const String everythingEndpoint = 'everything';

  // Default parameters
  static const String defaultCountry = 'us';
  static const String defaultQuery = 'news';
  static const int defaultPageSize = 10;
}
