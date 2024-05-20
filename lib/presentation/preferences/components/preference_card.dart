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
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 20,
            right: 20,
            child: Stack(
              children: [
                Container(
                  height: 378,
                  width: 380,
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
                      style: const TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  )),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.read<PreferencesNotifier>().getPreferences(),
                    child: Container(
                      height: 378,
                      width: 380,
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
          Positioned(
            bottom: 8,
            left: 20,
            right: 20,
            child: Stack(
              children: [
                Container(
                  height: 378,
                  width: 380,
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
                      style: const TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  )),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.read<PreferencesNotifier>().getPreferences(),
                    child: Container(
                      height: 378,
                      width: 380,
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
          Positioned(
            top: 340,
            left: 150,
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF262626),
                // border: Border.all(
                //   color: Colors.white,
                //   width: 2.0,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
