import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/domain/repositories/user.dart';
import 'package:dartz/dartz.dart';

class AddUserUseCase{
  final UserRepository userRepository;

  AddUserUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(User user) async {
    return await userRepository.addUser(user);
  }
}