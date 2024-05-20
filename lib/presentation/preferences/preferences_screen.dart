import 'package:dares_game/presentation/preferences/components/preference_card.dart';
import 'package:dares_game/presentation/preferences/preferences_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'components/preferences_list.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PreferencesNotifier>().fetchLevels();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('¿Que prefieres?'),
        backgroundColor: const Color(0xFF262626),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: const SafeArea(
        child: PreferencesList(),
      ),
    );
  }
}
