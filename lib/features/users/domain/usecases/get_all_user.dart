import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/domain/repositories/user.dart';
import 'package:dartz/dartz.dart';

class GetAllUserUseCase{
  final UserRepository userRepository;

  GetAllUserUseCase(this.userRepository);

  Future<Either<Failure, List<User>>> call()async {
    return await userRepository.getAllUsers();
  }
}