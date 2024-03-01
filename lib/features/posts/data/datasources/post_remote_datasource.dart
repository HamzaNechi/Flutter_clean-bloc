import 'dart:convert';

import 'package:clean/core/errors/exceptions.dart';
import 'package:clean/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource{
  Future<List<PostModel>> getAllPost();
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}


const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});


  
  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/posts"), 
      headers: {"Content-Type" : "application/json"}
      );

    if(response.statusCode == 200){
      List decodeJsonData = jsonDecode(response.body) as List;
      List<PostModel> posts = decodeJsonData
                              .map<PostModel>((postModel) => PostModel.fromJson(postModel))
                              .toList();
      return posts;
    }else{
      throw ServerException();
    }
  }


  
  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title' : postModel.title,
      'body': postModel.body
    };

    final response = await client.post(Uri.parse("$BASE_URL/posts"), body: body);

    if(response.statusCode == 201){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await client.delete(
      Uri.parse('$BASE_URL/posts/$id'),
      headers: {
        "Content-Type" : "application/json"
      }
    );

    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id;
    final body = {
      'title' : postModel.title,
      'body' : postModel.body
    };

    final response = await client.patch(
      Uri.parse('$BASE_URL/posts/$postId'),
      body: body
    );

    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

}