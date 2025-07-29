import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/custom_action_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';

class EditName extends StatelessWidget {
  const EditName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, 'Edit Name'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Enter your name',
                keyboardType: TextInputType.name,
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              CustomActionButton(
                text: 'update',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
