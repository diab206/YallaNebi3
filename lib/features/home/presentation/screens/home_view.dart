import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:yalla_nebi3/core/config/sensitive_data.dart';
import 'package:yalla_nebi3/core/constants/app_colors.dart';
import 'package:yalla_nebi3/core/utils/navigation_helper.dart';
import 'package:yalla_nebi3/core/widgets/categories_list.dart';
import 'package:yalla_nebi3/core/widgets/custom_search_bar.dart';
import 'package:yalla_nebi3/core/widgets/product_list.dart';
import 'package:yalla_nebi3/features/auth/data/models/user_data_model.dart';
import 'package:yalla_nebi3/features/home/presentation/screens/search_view.dart';


class HomeViews extends StatefulWidget {
  const HomeViews({super.key,required this.userDataModel});
 final UserDataModel userDataModel;

  @override
  State<HomeViews> createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  @override
  void initState() {
    PaymentData.initialize(
      apiKey:
          paymobApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
          integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
      // Optional User Data
      userData: UserData(
        email: widget.userDataModel.email, // Optional: Defaults to 'NA'
       // phone: "User Phone", // Optional: Defaults to 'NA'
        name: "User First Name", // Optional: Defaults to 'NA'
      //  lastName: "User Last Name", // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.primaryColor, // Default: Colors.blue
        appBarBackgroundColor: AppColors.primaryColor, // Default: Colors.white

        buttonStyle:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white
            ), // Default: ElevatedButton.styleFrom()
        circleProgressColor:  AppColors.primaryColor, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
    super.initState();
    // You can add any initialization logic here if needed
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          CustomSearchBar(
            controller: searchController,
            hintText: 'Search in Market....',
            onSearch: () {
              if (searchController.text.isNotEmpty) {
                navigteTo(context, SearchView(query: searchController.text));
                searchController.clear();
              }
            },
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/home_main.png',
            width: double.infinity,
            height: 250,
          ),
          const SizedBox(height: 16),
          const Text('Popular Categories', style: TextStyle(fontSize: 15)),
          const SizedBox(height: 8),
          CatagriesList(),
          const SizedBox(height: 8),
          ProductList(),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
