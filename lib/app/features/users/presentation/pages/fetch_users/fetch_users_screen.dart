import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqres_user_app/app/features/users/presentation/pages/fetch_users/widgets/all_users_widgets.dart';
import 'package:reqres_user_app/app/features/users/presentation/pages/fetch_users/widgets/search_widget.dart';
import 'package:reqres_user_app/app/features/users/presentation/provider/user_provider.dart';

import '../../../../../core/constants/app_text_data.dart';
import '../../widgets/loader.dart';
import '../../widgets/text_style.dart';


class FetchUsersScreen extends StatefulWidget {
  const FetchUsersScreen({super.key});

  @override
  State<FetchUsersScreen> createState() => _FetchUsersScreenState();
}

class _FetchUsersScreenState extends State<FetchUsersScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppTextData.users, style: titleText(),),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SearchWidget(),
                Expanded(
                    child: provider.isLoading
                        ? const Center(
                      child: Loader(),
                    )
                        : provider.filteredUsers.isNotEmpty
                        ? AllUsersWidgets(userList: provider.filteredUsers)
                        : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppTextData.noInternetConnection,
                            style: titleText(),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Provider.of<UserProvider>(context,
                                    listen: false)
                                    .fetchUsers();
                              },
                              child: Text(
                                AppTextData.reload,
                                style: bodyText(),
                              ))
                        ],
                      ),
                    )),
                provider.isBottomLoading
                    ? Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Loader(),
                )
                    : const SizedBox()
              ],
            );
          },
        )),
      ),
    );
  }
}
