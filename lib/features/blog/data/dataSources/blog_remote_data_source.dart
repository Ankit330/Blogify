import 'dart:io';

import 'package:blogapp/core/expections/server_expections.dart';
import 'package:blogapp/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBLogs();
}

class BlogRemoteDataSourceImp implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImp(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerExpection(e.message);
    } catch (e) {
      throw ServerExpection(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_image').upload(
            blog.id,
            image,
          );
      return supabaseClient.storage.from('blog_image').getPublicUrl(blog.id);
    } on StorageException catch (e) {
      throw ServerExpection(e.message);
    } catch (e) {
      throw ServerExpection(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBLogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select(
            '* , profiles (name)',
          )
          .order('updated_at', ascending: false);
      return blogs
          .map((blog) => BlogModel.fromJson(blog).copyWith(
                publisherName: blog['profiles']['name'],
              ))
          .toList();
    } on StorageException catch (e) {
      throw ServerExpection(e.message);
    } on PostgrestException catch (e) {
      throw ServerExpection(e.message);
    } catch (e) {
      throw ServerExpection(e.toString());
    }
  }
}
