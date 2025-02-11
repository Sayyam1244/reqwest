import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          'Re',
          style: theme.textTheme.headlineMedium,
        ),
        AppText(
          'qwest',
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.background,
          ),
        ),
      ],
    );
  }
}
