import 'package:blogapp/core/common/widgets/loding_indicator.dart';
import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/show_error.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/add_new_blog.dart';
import 'package:blogapp/features/blog/presentation/widgets/blog_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: AppPallete.whiteColor),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Log Out",
        style: TextStyle(color: AppPallete.errorColor),
      ),
      onPressed: () {
        context.read<AuthBloc>().add(AuthUserSignOut());
        Navigator.pushAndRemoveUntil(
            context, SignInPage.route(), (route) => false);
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Would you want to log out!! "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              showAlertDialog(context);
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
          ),
          elevation: 0,
          backgroundColor: AppPallete.transparentColor,
          title: const Text(
            'Blogify',
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, AddNewBlogPage.route());
                },
                icon: const Icon(
                  CupertinoIcons.add_circled,
                  size: 24,
                ))
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              return showError(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const LodingIndicator();
            }
            if (state is AuthSuccessSignOut) {
              Navigator.pushAndRemoveUntil(
                  context, SignInPage.route(), (route) => false);
            }
            if (state is BlogDisplaySuccess) {
              return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return BlogCart(
                      blog: blog,
                      color: index % 4 == 0
                          ? AppPallete.red
                          : index % 4 == 1
                              ? AppPallete.blue
                              : index % 4 == 2
                                  ? AppPallete.grren
                                  : AppPallete.yellow,
                    );
                  });
            }
            return const Center(
              child: Text('No Blogs Yet!!'),
            );
          },
        ),
      ),
    );
  }
}
