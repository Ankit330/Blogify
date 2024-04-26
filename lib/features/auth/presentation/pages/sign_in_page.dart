import 'package:blogapp/core/common/widgets/loding_indicator.dart';
import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/show_error.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_button.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogapp/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignInPage(),
      );
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailCntllr = TextEditingController();
  final passwordCntllr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCntllr.dispose();
    passwordCntllr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showError(context, state.msg);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LodingIndicator();
            }
            if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                  context, BlogPage.route(), (route) => false);
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Blogify",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    hintText: 'Email',
                    cntllr: emailCntllr,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Password',
                    cntllr: passwordCntllr,
                    isNotVissible: true,
                  ),
                  const SizedBox(height: 20),
                  AuthButton(
                    text: 'Log In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: emailCntllr.text.trim(),
                                passwrod: passwordCntllr.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignUpPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: ' Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
