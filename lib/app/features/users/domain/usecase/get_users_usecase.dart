

import 'package:reqres_user_app/app/core/resources/data_state.dart';
import 'package:reqres_user_app/app/core/usecase/usecase.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_response.dart';
import 'package:reqres_user_app/app/features/users/domain/repository/user_repository.dart';

class GetUsersUseCase implements UseCase<DataState<UserResponse>,int> {

  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  @override
  Future<DataState<UserResponse>> call({ int params = 1}) {
    return _userRepository.getUsers(params);
  }

}