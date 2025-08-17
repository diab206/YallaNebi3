import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/custom_action_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';
import 'package:yalla_nebi3/core/functions/snackbar_helper.dart';
import 'package:yalla_nebi3/views/auth/logic/cubit/authentication_cubit.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Initialize controller with current user name
    final currentUser = context.read<AuthenticationCubit>().userDataModel;
    _nameController = TextEditingController(text: currentUser?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, 'Edit Name'),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccess) {
            showAppSnackBar(context, 'Name updated successfully!');
            Navigator.pop(context);
          } else if (state is UpdateUserDataFailure) {
            showAppSnackBar(context, 'Failed to update name. Please try again.');
          }
        },
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: 'Enter your name',
                      keyboardType: TextInputType.name,
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 20),
                    state is UpdateUserDataLoading
                        ? CircularProgressIndicator()
                        : CustomActionButton(
                            text: 'Update',
                            onPressed: () {
                              final newName = _nameController.text.trim();
                              if (newName.isNotEmpty) {
                                context.read<AuthenticationCubit>().updateUserName(newName);
                              } else {
                                showAppSnackBar(context, 'Please enter a valid name');
                              }
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}