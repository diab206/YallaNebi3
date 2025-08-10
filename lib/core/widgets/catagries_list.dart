import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
import 'package:yalla_nebi3/views/home/ui/catogries_view.dart';

class CatagriesList extends StatelessWidget {
  const CatagriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: catogries.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                navigteTo(context, CatogriesView(category: catogries[index].text));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.backgroundcolor,
                    child: Icon(catogries[index].icon, size: 30),
                  ),
                  const SizedBox(height: 4),
                  Text(catogries[index].text),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Catogry {
  final String text;
  final IconData icon;

  Catogry({required this.text, required this.icon});
}

List<Catogry> catogries = [
  Catogry(text: 'Sports', icon: Icons.sports),
  Catogry(text: 'Electronics', icon: Icons.tv),
  Catogry(text: 'Collections', icon: Icons.collections),
  Catogry(text: 'Books', icon: Icons.book),
  Catogry(text: 'Games', icon: Icons.games),
  Catogry(text: 'Bikes', icon: Icons.bike_scooter),
];
