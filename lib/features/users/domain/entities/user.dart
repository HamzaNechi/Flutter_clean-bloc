import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int? id;
  final String name;
  final String email;

  const User({this.id, required this.name, required this.email});


  @override
  List<Object?> get props => [id, name, email];
}