import 'package:dares_game/presentation/preferences/preferences_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleType extends StatelessWidget {
  const TitleType({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = context.select<PreferencesNotifier, String>(
      (notifier) => notifier.title,
    );
    return Text(title);
  }
}
