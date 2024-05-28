import 'package:flutter/material.dart';
import 'package:my_little_app/common/presentation/build_context_extensions.dart';
import 'package:my_little_app/generated/l10n.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).welcomeBack,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: context.appColors.secondary,
            ),
          ),
          Text(
            S.of(context).signIn,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: context.appColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
