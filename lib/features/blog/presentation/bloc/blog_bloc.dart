import 'dart:io';

import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:blogapp/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:blogapp/features/blog/domain/usecase/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onUploadBlog);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  Future<void> _onUploadBlog(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
      publisherId: event.publisherId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogSuccess()),
    );
  }

  Future<void> _onFetchAllBlogs(
      BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParam());

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs)),
    );
  }
}
