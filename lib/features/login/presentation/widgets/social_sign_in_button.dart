import 'package:flutter/material.dart';
import 'package:my_little_app/common/presentation/spacing.dart';

class SocialSignInButton extends StatelessWidget {
  final String buttonText;
  final Widget leadingIcon;
  final Function() onTap;
  const SocialSignInButton({
    super.key,
    required this.buttonText,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        onTap: onTap,
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leadingIcon,
              spacing8,
              Text(buttonText),
            ],
          ),
        ),
      ),
    );
  }
}