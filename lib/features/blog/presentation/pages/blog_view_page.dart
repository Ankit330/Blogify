import 'package:blogapp/core/common/widgets/loding_indicator.dart';
import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/calculate_time.dart';
import 'package:blogapp/core/utils/formate_date.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  final Blog blog;
  static route(Blog blog) => MaterialPageRoute(
      builder: (context) => BlogViewPage(
            blog: blog,
          ));
  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppPallete.backgroundColor,
      ),
      body: Scrollbar(
        thickness: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                blog.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'written by -> ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${blog.publisherName}',
                    style: const TextStyle(
                        color: AppPallete.grren,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                '${formateDate(blog.updatedAt)} ~ ${calculateTime(blog.content)} min',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const SizedBox(
                            height: 200, child: LodingIndicator());
                      }
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                blog.content,
                style: const TextStyle(fontSize: 16, height: 2),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
