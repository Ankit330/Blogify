import 'dart:developer';
import 'dart:io';

import 'package:blogapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogapp/core/common/widgets/loding_indicator.dart';
import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/pick_image.dart';
import 'package:blogapp/core/utils/show_error.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_page.dart';
import 'package:blogapp/features/blog/presentation/widgets/blog_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      CupertinoPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  TextEditingController titleCnt = TextEditingController();
  TextEditingController contentCnt = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<String> selectedTopics = [];
  File? image;

  Future<void> selectImage() async {
    final selectedImage = await pickImage();
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  void uploadBlog() {
    final publisherId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<BlogBloc>().add(BlogUpload(
          publisherId: publisherId,
          title: titleCnt.text,
          content: contentCnt.text,
          image: image!,
          topics: selectedTopics,
        ));
  }

  @override
  void dispose() {
    titleCnt.dispose();
    contentCnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppPallete.transparentColor,
            title: const Text(
              'Create New Blog',
              style: TextStyle(fontSize: 22),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedTopics.isNotEmpty &&
                        image != null) {
                      uploadBlog();
                    } else if (selectedTopics.isEmpty) {
                      showError(context, 'Select at least one category!');
                    } else {
                      showError(context, 'Select image');
                    }
                  },
                  icon: const Icon(
                    Icons.done_outline,
                    size: 24,
                  ))
            ],
          ),
          body: BlocConsumer<BlogBloc, BlogState>(
            listener: (context, state) {
              if (state is BlogFailure) {
                log(state.error);
                showError(context, state.error);
              } else if (state is BlogSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  BlogPage.route(),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is BlogLoading) {
                return const LodingIndicator();
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    children: [
                      image != null
                          ? GestureDetector(
                              onTap: selectImage,
                              child: SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            )
                          : GestureDetector(
                              onTap: () => selectImage(),
                              child: DottedBorder(
                                dashPattern: const [10, 5],
                                color: AppPallete.borderColor,
                                radius: const Radius.circular(12),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: const SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open_rounded,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Select your Image',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Buisness',
                            'Technology',
                            'Programming',
                            'Entertainment',
                            'Other',
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }

                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(
                                          e,
                                          style: TextStyle(
                                            color: selectedTopics.contains(e)
                                                ? AppPallete.backgroundColor
                                                : AppPallete.whiteColor,
                                          ),
                                        ),
                                        color: selectedTopics.contains(e)
                                            ? const MaterialStatePropertyAll(
                                                AppPallete.gradient2)
                                            : null,
                                        side: selectedTopics.contains(e)
                                            ? null
                                            : const BorderSide(
                                                color: AppPallete.borderColor),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlogTextField(
                        text: 'Blog Title',
                        cnt: titleCnt,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlogTextField(
                        text: 'Blog Content',
                        cnt: contentCnt,
                      ),
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
