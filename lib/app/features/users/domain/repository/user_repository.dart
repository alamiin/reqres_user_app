import 'package:reqres_user_app/app/core/resources/data_state.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_response.dart';

abstract class UserRepository {
  Future<DataState<UserResponse>> getUsers(int pageNo);
}