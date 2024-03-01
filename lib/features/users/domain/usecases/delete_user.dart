import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/users/domain/repositories/user.dart';
import 'package:dartz/dartz.dart';

class DeleteUserUseCase{
  final UserRepository userRepository;

  DeleteUserUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(int userId) async{
    return await userRepository.deleteUser(userId);
  }
}