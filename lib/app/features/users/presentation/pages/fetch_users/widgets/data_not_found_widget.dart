import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqres_user_app/app/core/constants/app_text_data.dart';
import 'package:reqres_user_app/app/core/constants/colors.dart';
import 'package:reqres_user_app/app/features/users/presentation/provider/user_provider.dart';
import 'package:reqres_user_app/app/features/users/presentation/widgets/text_style.dart';

class DataNotFoundWidget extends StatelessWidget {
  const DataNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  provider.message,
                  style: titleText(),
                  textAlign: TextAlign.center,
                ),
                if(!provider.isNoUserFound)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: grey600, // Change this color as needed
                      ),
                      onPressed: () {
                        Provider.of<UserProvider>(context,
                            listen: false)
                            .fetchUsers();
                      },
                      child: Text(
                        AppTextData.reload,
                        style: bodyText(),
                      )
                  )

              ],
            ),
          );
        });
  }
}
