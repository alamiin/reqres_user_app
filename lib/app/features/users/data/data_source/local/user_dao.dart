import 'package:floor/floor.dart';
import 'package:reqres_user_app/app/features/users/data/model/dio_cache.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_model.dart';




@dao
abstract class UserDao {

  @Insert()
  Future<void> insertUser(UserModel userModel);

  @Query('SELECT * FROM user WHERE email = :key')
  Future<UserModel?> getUser(String key);

  @update
  Future<void> updateRepository(UserModel repoModel);

  @Insert()
  Future<void> insertCache(CacheModel cacheModel);

  @Query('SELECT * FROM cache WHERE url = :url')
  Future<CacheModel?> getCache(String url);

  @update
  Future<void> updateCache(CacheModel cacheModel);

}