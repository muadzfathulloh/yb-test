class NewsArticle {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? sourceName;
  final String? content;
  final String? author;

  NewsArticle({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.sourceName,
    this.content,
    this.author,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'] as String)
          : null,
      sourceName: json['source']?['name'] as String?,
      content: json['content'] as String?,
      author: json['author'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt?.toIso8601String(),
      'source': {'name': sourceName},
      'content': content,
      'author': author,
    };
  }

  // Helper method to get excerpt (short description)
  String get excerpt {
    if (description != null && description!.length > 150) {
      return '${description!.substring(0, 150)}...';
    }
    return description ?? '';
  }

  // Helper method to check if image is available
  bool get hasImage => urlToImage != null && urlToImage!.isNotEmpty;
}
