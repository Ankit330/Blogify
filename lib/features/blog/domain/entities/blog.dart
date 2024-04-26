class Blog {
  final String id;
  final String publisherId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;
  final String? publisherName;

  Blog({
    required this.id,
    required this.publisherId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
    this.publisherName,
  });
}
