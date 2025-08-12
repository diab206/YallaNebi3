import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/core/models/user_data_model.dart';
import 'package:yalla_nebi3/views/favourit/ui/favourit_view.dart';
import 'package:yalla_nebi3/views/home/ui/home_views.dart';
import 'package:yalla_nebi3/views/nav_bar/logic/cubit/nav_bar_cubit.dart';
import 'package:yalla_nebi3/views/profile/ui/profile_views.dart';
import 'package:yalla_nebi3/views/store/ui/store_views.dart';

class MainHomeView extends StatefulWidget {
  static const String routeName = 'main_home';
  const MainHomeView({super.key,required this.userDataModel});
  final UserDataModel userDataModel;

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  late List<Widget> views;
  @override
  initState() {
    views = [
    HomeViews(userDataModel: widget.userDataModel,),
    StoreView(),
    FavouritView(),
    PerfoileView(),
  ];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          NavBarCubit cubit = context.read<NavBarCubit>();

          return Scaffold(
            body: SafeArea(child: views[cubit.currentIndex]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: AppColors.backgroundcolor),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                child: GNav(
                  onTabChange: (index) {
                    cubit.changeIndex(index);
                  },
                  rippleColor:
                      AppColors
                          .primaryColor, // tab button ripple color when pressed
                  hoverColor: AppColors.primaryColor, // tab button hover color

                  duration: Duration(
                    milliseconds: 400,
                  ), // tab animation duration
                  gap: 8, // the tab button gap between icon and text
                  color: AppColors.greyColor, // unselected icon color
                  activeColor:
                      AppColors.backgroundcolor, // selected icon and text color
                  iconSize: 24, // tab button icon size
                  tabBackgroundColor:
                      AppColors.primaryColor, // selected tab background color
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ), // navigation bar padding
                  tabs: [
                    GButton(icon: Icons.home, text: 'Home'),

                    GButton(icon: Icons.store, text: 'Store'),
                    GButton(icon: Icons.favorite, text: 'Favorite'),
                    GButton(icon: Icons.person, text: 'Profile'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
