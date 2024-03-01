import 'package:clean/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable{
  @override
  List<Object?> get props => [];
}


class InitialUserState extends UserState{}

class LoadingUserState extends UserState{}

class LoadedUserState extends UserState{
  final List<User> users;

  LoadedUserState({required this.users});

  @override
  List<Object?> get props => [users];
}

class ErrorUserState extends UserState{
  final String message;

  ErrorUserState({required this.message});

  @override
  List<Object?> get props => [message];
}


class MessageUserState extends UserState{
  final String message;

  MessageUserState({required this.message});

  @override
  List<Object?> get props => [message];
}


