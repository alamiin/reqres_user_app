import 'dart:io';

import 'package:dio/dio.dart';

import 'package:reqres_user_app/app/core/constants/constants.dart';
import 'package:reqres_user_app/app/core/resources/data_state.dart';
import 'package:reqres_user_app/app/core/utils/error_handler.dart';
import 'package:reqres_user_app/app/features/users/data/data_source/remote/dio_client.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_response.dart';
import 'package:reqres_user_app/app/features/users/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final DioClient _dioClient;
  UserRepositoryImpl(this._dioClient);


  @override
  Future<DataState<UserResponse>> getUsers(int pageNo) async {
    try {
      final queryParameter = {
        perPage: perPageKey,
        page: "$pageNo"
      };
      final httpResponse = await _dioClient.get(
          uri: fetchUsers,
          queryParameters: queryParameter
      );


      if (httpResponse.statusCode == HttpStatus.ok) {
        final successRepoData = UserResponse.fromJson(httpResponse.data);
        return DataSuccess(successRepoData);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.statusMessage,
                response: httpResponse,
                type: DioExceptionType.unknown,
                requestOptions: httpResponse.requestOptions
            )
        );
      }
    }  catch(e) {
      return ErrorHandler.handleError(e);
    }
  }

}