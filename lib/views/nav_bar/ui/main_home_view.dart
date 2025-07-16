import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(padding: 
      const EdgeInsets.all(8.0),
       // ignore: avoid_unnecessary_containers
       child: Container(child: Text('Main Home View')))),
       bottomNavigationBar:Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundcolor,
        ),
          
         child: Padding(
           padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
           ),
           child: GNav(
             // tab button hover color
              rippleColor:AppColors.primaryColor, // tab button ripple color when pressed
               hoverColor:AppColors.primaryColor, // tab button hover color
         
            
             duration: Duration(milliseconds: 400), // tab animation duration
             gap: 8, // the tab button gap between icon and text 
             color:AppColors.greyColor, // unselected icon color
             activeColor:AppColors.backgroundcolor, // selected icon and text color
             iconSize: 24, // tab button icon size
             tabBackgroundColor: AppColors.primaryColor, // selected tab background color
             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
             tabs: [
               GButton(
                 icon: Icons.home,
                 text: 'Home',
               ),
              
               GButton(
                 icon: Icons.store,
                 text: 'Store',
               ),
                GButton(
                 icon: Icons.favorite,
                 text: 'Favorite',
               ),
               GButton(
                 icon: Icons.person,
                 text: 'Profile',
               )
             ]
           ),
         ),
       )
    );
    
  }
}