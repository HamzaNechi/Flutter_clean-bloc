import 'package:clean/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  @override
  List<Object?> get props => [];
}


class GetAllUsersEvent extends UserEvent{}

class RefreshAllUsersEvent extends UserEvent{}

class AddUserEvent extends UserEvent{
  final User user;

  AddUserEvent({required this.user});

  @override
  List<Object?> get props => [user];

}

class UpdateUserEvent extends UserEvent{
  final User user;

  UpdateUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class DeleteUserEvent extends UserEvent{
  final int userId;

  DeleteUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}


