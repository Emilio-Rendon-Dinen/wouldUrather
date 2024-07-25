import 'package:dares_game/presentation/preferences/preferences_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreferencesCard extends StatelessWidget {
  const PreferencesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String? firstPreference = context.select<PreferencesNotifier, String?>(
      (notifier) => notifier.firstPreference?.preferenceText,
    );
    final String? secondPreference = context.select<PreferencesNotifier, String?>(
      (notifier) => notifier.secondPreference?.preferenceText,
    );
    final int? categoryId = context.select<PreferencesNotifier, int?>(
      (notifier) => notifier.firstPreference?.categoryId,
    );

    return Container(
      color: const Color(0xFF262626),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: categoryId == 1
                              ? const Color(0xFFF27BBD)
                              : categoryId == 2
                                  ? const Color(0xFf2A748C) //-----
                                  : categoryId == 3
                                      ? const Color(0xFFFFBB70) //-----
                                      : const Color(0xFFD24545),
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            firstPreference ?? '',
                            style: const TextStyle(color: Colors.white, fontSize: 32),
                          ),
                        )),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => context.read<PreferencesNotifier>().getPreferences(),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0xFF262626),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: categoryId == 1
                              ? const Color(0xFF874CCC)
                              : categoryId == 2
                                  ? const Color(0xFFD04848)
                                  : categoryId == 3
                                      ? const Color(0xFFE4C59E)
                                      : const Color(0xFF5F8670),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              secondPreference ?? '',
                              style: const TextStyle(color: Colors.white, fontSize: 32),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => context.read<PreferencesNotifier>().getPreferences(),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF262626),
                  border: Border.all(
                    color: const Color(0xFF262626),
                    width: 2.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
