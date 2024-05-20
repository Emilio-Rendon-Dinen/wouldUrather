import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final String categoryName;
  final void Function() onTap;
  const CategoryCard({
    required this.index,
    required this.categoryName,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = index == 0
        ? const Color(0xFFF27BBD)
        : index == 1
            ? const Color(0xFf2A748C)
            : index == 2
                ? const Color(0xFFFFBB70)
                : const Color(0xFFD24545);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: color,
          child: Center(
            child: Text(
              categoryName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
