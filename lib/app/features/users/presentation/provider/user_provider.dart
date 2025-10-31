import 'package:flutter/foundation.dart';
import 'package:reqres_user_app/app/core/resources/data_state.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_model.dart';
import 'package:reqres_user_app/app/features/users/domain/usecase/get_users_usecase.dart';

class UserProvider with ChangeNotifier{
  final GetUsersUseCase getUsersUseCase;
  UserProvider({required this.getUsersUseCase});

  bool isLoading = false;
  bool isNoUserFound = false;
  bool isBottomLoading = false;
  List<UserModel> userList = [];
  List<UserModel> filteredUsers = [];
  String message = "";
  String searchQuery = "";
  int pageCounter = 1;
  int totalPages = 1;

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

    switch(dataState){
      case DataSuccess():{
        userList = [];
        pageCounter++;
        userList = dataState.data!.data;
        totalPages = dataState.data!.totalPages;
        filteredUsers = List.from(userList);
        if(filteredUsers.isEmpty || filteredUsers.length == userList.length - dataState.data!.data!.length){
          filteredUsers.addAll(dataState.data!.data!);
        }
      }
      case DataFailed():{
        message = dataState.error!.message!;
      }
    }

    updateLoader(false);
  }

  void fetchScrollUsers() async {

    if(isLoading || isBottomLoading || pageCounter > totalPages){
      return;
    }

    updateBottomLoader(true);

    final dataState = await getUsersUseCase(params: pageCounter);

    switch(dataState){
      case DataSuccess():{
        if(pageCounter == 1){
          userList = [];
        }
        pageCounter++;
        userList.addAll(dataState.data!.data!);
        filteredUsers = List.from(userList);
      }
      case DataFailed():{
        message = dataState.error!.message!;
      }
    }

    updateBottomLoader(false);
  }

  void searchUsers(String query){
    final q = query.trim().toLowerCase();
    if(q.isEmpty){
      filteredUsers = List.from(userList);
      isNoUserFound = false;
      message = "";
      notifyListeners();
      return;
    }

    filteredUsers = userList.where((u){
      final first = (u.firstName ?? '').toLowerCase();
      final last = (u.lastName ?? '').toLowerCase();
      final fullName = '${first} ${last}'.trim();
      return first.contains(q) || last.contains(q) || fullName.contains(q);
    }).toList();

    if(filteredUsers.isEmpty){
      message = "No users found for \"$query\"";
      isNoUserFound = true;
    }else{
      isNoUserFound = false;
      message = "";
    }

    notifyListeners();
  }




}