import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/custom_circle_indicitor.dart';
import 'package:yalla_nebi3/core/components/custom_profile_button.dart';
import 'package:yalla_nebi3/core/functions/nackbar_helper.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
import 'package:yalla_nebi3/views/auth/ui/login_view.dart';
import 'package:yalla_nebi3/views/product_details/logic/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/views/profile/ui/edit_name.dart';
import 'package:yalla_nebi3/views/profile/ui/my_orders_view.dart';

class PerfoileView extends StatelessWidget {
  const PerfoileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        }
        if (state is LogoutFailure) {
          showAppSnackBar(context, 'Logout failed. Please try again.');
        }
      },
      builder: (context, state) {
         AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return state is LogoutLoading
            ? CustomCircleProgressIndicictor()
            : Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Karim Ahmed",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "FlutterDeveloper.karim@gmail.com",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ProfileButton(
                          icon: Icons.person,
                          label: "Edit Name",
                          onPressed: () {
                            navigteTo(context, EditName());
                          },
                        ),
                        const SizedBox(height: 12),
                        ProfileButton(
                          icon: Icons.shopping_bag,
                          label: "My Orders",
                          onPressed: () {
                            navigteTo(context, MyOrdersView());
                          },
                        ),
                        const SizedBox(height: 12),
                        ProfileButton(
                          icon: Icons.logout,
                          label: "Logout",
                          onPressed: () {
                            cubit.signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
      },
    );
  }
}
