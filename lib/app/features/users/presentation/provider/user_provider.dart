import 'package:flutter/foundation.dart';
import 'package:reqres_user_app/app/core/resources/data_state.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_model.dart';
import 'package:reqres_user_app/app/features/users/domain/usecase/get_users_usecase.dart';

class UserProvider with ChangeNotifier{
  final GetUsersUseCase getUsersUseCase;
  UserProvider({required this.getUsersUseCase});

  bool isLoading = false;
  bool isBottomLoading = false;
  List<UserModel> userList = [];
  String message = "";
  int pageCounter = 1;

  void updateLoader(bool state){
    isLoading = state;
    notifyListeners();
  }

  void updateBottomLoader(bool state){
    isBottomLoading = state;
    notifyListeners();
  }

  void fetchUsers() async {

    if(isBottomLoading){
      return;
    }

    updateLoader(true);

    pageCounter = 1;
    final dataState = await getUsersUseCase(params: pageCounter);

    if (dataState is DataSuccess && dataState.data!.data!.isNotEmpty) {
      userList = [];
      pageCounter++;
      userList = dataState.data!.data!;
    }

    if (dataState is DataFailed) {
      message = dataState.error!.message!;
    }

    updateLoader(false);
  }

}