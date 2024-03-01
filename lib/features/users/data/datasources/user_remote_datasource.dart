import 'dart:convert';

import 'package:clean/core/errors/exceptions.dart';
import 'package:clean/features/users/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource{
  Future<List<UserModel>> getAllUsers();
  Future<Unit> deleteUser(int userId);
  Future<Unit> updateUser(UserModel user);
  Future<Unit> addUser(UserModel user);
}


const BASE_URL = "https://jsonplaceholder.typicode.com/users";

class UserRemoteDataSourceImpl extends UserRemoteDataSource{
  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await http.get(
      Uri.parse(BASE_URL), 
      headers: {
        "Content-Type" : "application/json"
      }
      );

    if(response.statusCode == 200){
      List jsonDecodeData = jsonDecode(response.body) as List;
      List<UserModel> users = jsonDecodeData.map<UserModel>((userModel) => UserModel.fromJson(userModel)).toList();
      return users;
    }else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> addUser(UserModel user) async {
    final body = {
      'name' : user.name,
      'email' : user.email
    };


    final response = await http.post(Uri.parse(BASE_URL), body: body);

    if(response.statusCode == 201){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }



  @override
  Future<Unit> updateUser(UserModel user) async {
    final body = {
      'name' : user.name,
      'email' : user.email
    };


    final response = await http.patch(Uri.parse("$BASE_URL/${user.id}"), body: body);

    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }


  @override
  Future<Unit> deleteUser(int userId) async {
    final response = await http.delete(Uri.parse("$BASE_URL/$userId"));
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

}
