class Webtoon {
  final String title;
  final String thumbnailUrl;
  final String description;

  Webtoon({
    required this.title,
    required this.thumbnailUrl,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
    };
  }

  factory Webtoon.fromJson(Map<String, dynamic> json) {
    return Webtoon(
      title: json['title'] ?? 'Unknown Title',
      thumbnailUrl: json['thumbnailUrl'] ?? 'assets/default_thumbnail.png',
      description: json['description'] ?? 'No description available.',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Webtoon && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
