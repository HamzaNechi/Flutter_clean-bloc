import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/users/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository{
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, Unit>> deleteUser(int userId);
  Future<Either<Failure, Unit>> updateUser(User user);
  Future<Either<Failure, Unit>> addUser(User user);
}