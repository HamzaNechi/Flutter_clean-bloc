import 'package:clean/features/users/domain/entities/user.dart';

class UserModel extends User{
  const UserModel({super.id ,required super.name, required super.email});


  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(id: json['id'],name: json['name'], email: json['email']);
  }


  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'name' : name,
      'email' : email
    };
  }

}