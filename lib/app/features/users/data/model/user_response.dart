import 'package:reqres_user_app/app/features/users/data/model/user_model.dart';

class UserResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> data;

  UserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {

    List<UserModel> items = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        items.add(UserModel.fromJson(v));
      });
    }

    return UserResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': data,
    };
  }
}