// lib/app/core/utils/error_handler.dart
import 'package:dio/dio.dart';
import '../resources/data_state.dart';
import '../../features/users/data/model/user_response.dart';

class ErrorHandler {
  static DataState<UserResponse> handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return DataFailed<UserResponse>(DioException(
            requestOptions: error.requestOptions,
            message: 'Connection timeout. Please check your internet connection.',
          ));

        case DioExceptionType.connectionError:
          return DataFailed<UserResponse>(DioException(
            requestOptions: error.requestOptions,
            message: 'No internet connection',
          ));

        case DioExceptionType.badResponse:
          String message = 'Something went wrong';
          if (error.response?.statusCode == 404) {
            message = 'Resource not found';
          } else if (error.response?.statusCode == 500) {
            message = 'Server error';
          }
          return DataFailed<UserResponse>(DioException(
            requestOptions: error.requestOptions,
            message: message,
          ));

        default:
          return DataFailed<UserResponse>(DioException(
            requestOptions: error.requestOptions,
            message: 'Something went wrong',
          ));
      }
    }

    return DataFailed<UserResponse>(DioException(
      requestOptions: RequestOptions(path: ''),
      message: error.toString(),
    ));
  }
}