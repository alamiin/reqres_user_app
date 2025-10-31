
import 'package:floor/floor.dart';
import 'package:reqres_user_app/app/features/users/data/data_source/local/user_dao.dart';
import 'package:reqres_user_app/app/features/users/data/model/dio_cache.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_model.dart';



import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [UserModel, CacheModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}