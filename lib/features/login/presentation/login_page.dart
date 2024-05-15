// ignore_for_file: always_use_package_imports
import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_little_app/common/presentation/svg_assets.dart';
import 'package:my_little_app/common/presentation/widgets/fake_store_button.dart';
import 'package:my_little_app/common/presentation/widgets/fake_store_text_field.dart';
import 'package:my_little_app/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:my_little_app/features/login/presentation/widgets/social_sign_in_button.dart';
import 'package:my_little_app/features/login/presentation/widgets/welcome_text_widget.dart';
import 'package:my_little_app/features/register/presentation/register_page.dart';
import 'package:my_little_app/features/reset_password/presentation/reset_password_page.dart';
import 'package:my_little_app/generated/l10n.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/spacing.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeTextWidget(),
                  spacing16,
                  FakeStoreTextField.email(
                    hintText: S.of(context).email,
                    fieldName: 'tfEmail',
                    validator: FormBuilderValidators.required(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  FakeStoreTextField.password(
                    hintText: S.of(context).password,
                    validator: FormBuilderValidators.required(),
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
                            '${LoginPage.routeName}${ResetPasswordPage.routeName}',
                          ),
                          child: Text(
                            S.of(context).forgotPassword,
                            style: const TextStyle(fontWeight: FontWeight.w700),
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
                          child: Text(
                            S.of(context).signIn,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            final currentState = _formKey.currentState;
                            log(currentState.toString());
                            final validationSuccess =
                                _formKey.currentState?.validate();
                            if (validationSuccess ?? false) {
                              _formKey.currentState?.save();
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .login(email: 'email', password: 'password');
                            }
                            /*  ref
                                .read(authNotifierProvider.notifier)
                                .login(email: 'email', password: 'password'); */
                          },
                        ),
                        spacing16,
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 0.1,
                                color: Colors.black,
                              ),
                            ),
                            spacing8,
                            Text(
                              S.of(context).or,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            spacing8,
                            const Expanded(
                              child: Divider(
                                thickness: 0.1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        spacing16,
                        SocialSignInButton(
                          buttonText: S.of(context).continueWithFacebook,
                          leadingIcon: SvgPicture.asset(
                            SvgAssets.facebookLogo,
                          ),
                          onTap: () {},
                        ),
                        spacing16,
                        SocialSignInButton(
                          buttonText: S.of(context).continueWithGoogle,
                          leadingIcon: SvgPicture.asset(
                            SvgAssets.googleLogo,
                          ),
                          onTap: () {},
                        ),
                        spacing16,
                        if (Platform.isIOS)
                          SocialSignInButton(
                            buttonText: S.of(context).continueWithApple,
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
                                text: S.of(context).dontHaveAnAccount,
                                style: DefaultTextStyle.of(context).style,
                              ),
                              TextSpan(
                                text: S.of(context).signUp,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => ref.pushNamed(
                                        '${LoginPage.routeName}${RegisterPage.routeName}',
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
      ),
    );
  }
}
