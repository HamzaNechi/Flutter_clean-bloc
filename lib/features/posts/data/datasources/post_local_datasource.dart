import 'dart:convert';

import 'package:clean/core/errors/exceptions.dart';
import 'package:clean/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCachedPost();
  Future<Unit> cachePosts(List<PostModel> posts);
}


class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({ required this.sharedPreferences});


  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List postModelToJson = posts.map((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString('CACHED_POSTS', jsonEncode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    final jsonString = sharedPreferences.getString("CACHED_POSTS");
    if(jsonString != null){
      List decodeJsonData = jsonDecode(jsonString);
      List<PostModel> posts = decodeJsonData.map<PostModel>((postModel) => PostModel.fromJson(postModel)).toList();
      return Future.value(posts);
    }else{
      throw EmptyCacheException();
    }
  }

}