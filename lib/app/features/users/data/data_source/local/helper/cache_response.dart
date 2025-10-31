import 'dart:async';

import 'package:dio/dio.dart';
import 'package:reqres_user_app/app/features/users/data/model/dio_cache.dart';



import '../app_database.dart';
import 'content_serialization.dart';

mixin CacheResponseMixin{

  Future<void> saveResponse(Response response, AppDatabase appDatabase) async {
    if (response.statusCode == 200) {

      String url = "${response.requestOptions.uri.toString()}_data";
      CacheModel? searchCache = await appDatabase.userDao.getCache(url);
      final data = await serializeContent(response.requestOptions.responseType, response.data);
      final element  = CacheModel(code: 200, url: url, data: data);

      if(searchCache == null){
        await appDatabase.userDao.insertCache(element);
      }else{
        await appDatabase.userDao.updateCache(element);
      }

    }
  }

  Future<Response?> loadResponse(DioException err, AppDatabase appDatabase) async {

    String url = "${err.requestOptions.uri.toString()}_data";
    CacheModel? searchCache = await appDatabase.userDao.getCache(url);

    if (searchCache != null) {
      Response response = Response(requestOptions: err.requestOptions);
      response.statusCode = 200;
      response.data = deserializeContent(ResponseType.json, searchCache.data);
      return response;
    }
    return null;
  }

}


