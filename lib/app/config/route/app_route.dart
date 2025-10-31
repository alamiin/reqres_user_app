import 'package:flutter/material.dart';

import '../../features/users/presentation/pages/details_user/details_user_screen.dart';
import '../../features/users/presentation/pages/fetch_users/fetch_users_screen.dart';



class AppRoute{
  static const String defaultRoute = "/";
  static const String userDetailsRoute = "/detailsUser";

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case defaultRoute:
        return _materialRoute(const FetchUsersScreen());
      case userDetailsRoute:
        return _materialRoute(DetailsUserScreen());

      default:
        return _materialRoute(const FetchUsersScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

}