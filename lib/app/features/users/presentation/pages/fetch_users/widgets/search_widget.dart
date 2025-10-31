import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqres_user_app/app/core/constants/colors.dart';
import 'package:reqres_user_app/app/features/users/presentation/provider/user_provider.dart';
import 'package:reqres_user_app/app/features/users/presentation/widgets/text_style.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        style: bodyText(),
        decoration: InputDecoration(
          labelText: 'Search Users',

          labelStyle: bodyText(),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: Icon(Icons.search, color: slateGrey),
          filled: true,
          fillColor: grey600,
        ),
        onChanged: (value) {
          Provider.of<UserProvider>(context, listen: false).searchUsers(value);
          // Implement search logic here
        },
      ),
    );
  }
}
