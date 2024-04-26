import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/calculate_time.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_view_page.dart';
import 'package:flutter/material.dart';

class BlogCart extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCart({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Chip(
                                  label: Text(
                                e,
                              )),
                            ))
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            Text(
              '${calculateTime(blog.content)} min ~ reading time',
              style: const TextStyle(color: AppPallete.greyColor),
            ),
          ],
        ),
      ),
    );
  }
}
