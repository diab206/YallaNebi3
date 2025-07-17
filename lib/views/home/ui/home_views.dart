import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/core/widgets/custom_search_bar.dart';

class HomeViews extends StatelessWidget {
  HomeViews({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(
            controller: searchController,
            hintText: 'Search in Market....',
            onSearch: () {},
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/home_main.png',
            width: double.infinity,
            height: 250,
            
          ),
          const SizedBox(height: 16),
          const Text(
            'Popular Categories',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: catogries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.backgroundcolor,
                        child: Icon(
                          catogries[index].icon,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(catogries[index].text),
                    ],
                  ),
                );
              },
            ),
          ),

         
         
        ],
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
];
