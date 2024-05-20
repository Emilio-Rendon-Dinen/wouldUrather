part of '../preferences_screen.dart';

class PreferencesList extends StatelessWidget {
  const PreferencesList({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.select<PreferencesNotifier, bool>((notifier) => notifier.isExecutingRequest);
    return isLoading ? const Center(child: CircularProgressIndicator()) : const PreferencesCard();
  }
}
