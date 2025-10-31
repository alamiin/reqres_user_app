import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqres_user_app/app/features/users/presentation/provider/user_provider.dart';


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
      body: Container(),
    );
  }
}
