import 'package:dares_game/domain/entities/category.dart';
import 'package:dares_game/presentation/home/home_notifier.dart';
import 'package:dares_game/presentation/home/widgets/category_card.dart';
// import 'package:dares_game/presentation/models/snapshot_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeNotifier>().fetchCategories();
    });

    final List<Category?> category = context.select<HomeNotifier, List<Category?>>(
      (notifier) => notifier.categories,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('¿Que prefieres?'),
      ),
      body: SafeArea(
        child: category.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: 4,
                    itemBuilder: (_, index) {
                      return CategoryCard(
                          index: index,
                          categoryName: category[index]!.categoryName,
                          onTap: () => context.push(
                                '/preferences',
                                extra: category[index]!.id,
                              ));
                    },
                    shrinkWrap: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      child: Card(
                        color: const Color(0xFF31363F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () => context.push(
                            '/preferences',
                            extra: 5,
                          ),
                          child: const Center(
                            child: Text(
                              'Aleatorio',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
