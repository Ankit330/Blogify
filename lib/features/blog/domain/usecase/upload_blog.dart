import 'dart:io';

import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failures, Blog>> call(UploadBlogParams p) async {
    return await blogRepository.uploadBlog(
      image: p.image,
      title: p.title,
      content: p.content,
      publisherId: p.publisherId,
      topics: p.topics,
    );
  }
}

class UploadBlogParams {
  final String publisherId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.publisherId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
