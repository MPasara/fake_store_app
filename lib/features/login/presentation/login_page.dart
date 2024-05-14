// ignore_for_file: always_use_package_imports
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_little_app/common/presentation/svg_assets.dart';
import 'package:my_little_app/common/presentation/widgets/fake_store_button.dart';
import 'package:my_little_app/common/presentation/widgets/fake_store_text_field.dart';
import 'package:my_little_app/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:my_little_app/features/login/presentation/widgets/social_sign_in_button.dart';
import 'package:my_little_app/features/login/presentation/widgets/welcome_text_widget.dart';
import 'package:my_little_app/features/register/presentation/register_page.dart';
import 'package:my_little_app/features/reset_password/presentation/reset_password_page.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/spacing.dart';

class LoginPage extends ConsumerWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeTextWidget(),
                spacing16,
                FakeStoreTextField.email(
                  hintText: 'Email',
                  fieldName: 'tfEmail',
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                FakeStoreTextField.password(
                  hintText: 'Password',
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  fieldName: 'tfPassword',
                ),
                spacing16,
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => ref.pushNamed(
                          '$routeName${ResetPasswordPage.routeName}',
                        ),
                        child: const Text(
                          'Forgot password',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                spacing32,
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FakeStoreButton(
                        onPressed: () => ref
                            .read(authNotifierProvider.notifier)
                            .login(email: 'email', password: 'password'),
                      ),
                      spacing16,
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.1,
                              color: Colors.black,
                            ),
                          ),
                          spacing8,
                          Text(
                            'OR',
                            style: TextStyle(color: Colors.grey),
                          ),
                          spacing8,
                          Expanded(
                            child: Divider(
                              thickness: 0.1,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      spacing16,
                      SocialSignInButton(
                        buttonText: 'Continue with Facebook',
                        leadingIcon: SvgPicture.asset(
                          SvgAssets.facebookLogo,
                        ),
                        onTap: () {},
                      ),
                      spacing16,
                      SocialSignInButton(
                        buttonText: 'Continue with Google',
                        leadingIcon: SvgPicture.asset(
                          SvgAssets.googleLogo,
                        ),
                        onTap: () {},
                      ),
                      spacing16,
                      if (Platform.isIOS)
                        SocialSignInButton(
                          buttonText: 'Continue with Apple',
                          leadingIcon: SvgPicture.asset(
                            SvgAssets.appleLogo,
                          ),
                          onTap: () {},
                        ),
                      spacing32,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: DefaultTextStyle.of(context).style,
                            ),
                            TextSpan(
                              text: 'Sign up.',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => ref.pushNamed(
                                      '$routeName${RegisterPage.routeName}',
                                    ),
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
