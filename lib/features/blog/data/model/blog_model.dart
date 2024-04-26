import 'package:blogapp/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.publisherId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.publisherName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'publisher_id': publisherId,
      'blog_title': title,
      'blog_content': content,
      'blog_image': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] ?? '',
      publisherId: map['publisher_id'] ?? '',
      title: map['blog_title'] ?? '',
      content: map['blog_content'] ?? '',
      imageUrl: map['blog_image'] ?? '',
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  BlogModel copyWith({
    String? id,
    String? publisherId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? publisherName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      publisherId: publisherId ?? this.publisherId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      publisherName: publisherName ?? this.publisherName,
    );
  }
}
