import 'package:clean/core/errors/exceptions.dart';
import 'package:clean/core/errors/failures.dart';
import 'package:clean/core/network/network_info.dart';
import 'package:clean/features/users/data/datasources/user_remote_datasource.dart';
import 'package:clean/features/users/data/models/user_model.dart';
import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/domain/repositories/user.dart';
import 'package:dartz/dartz.dart';

typedef Future<Unit> DeleteOrUpdateOrAddUser();

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo networkInfo;
  UserRepositoryImpl( {required this.userRemoteDataSource, required this.networkInfo});


  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    if(await networkInfo.isConnected){
      try{
        final remoteUsers = await userRemoteDataSource.getAllUsers();
        return Right(remoteUsers);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addUser(User user) async {
    if(await networkInfo.isConnected){
      try{
        final UserModel userModel = UserModel(name: user.name, email: user.email);
        return _getMessage(() => userRemoteDataSource.addUser(userModel));
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int userId) async {
    if(await networkInfo.isConnected){
      try{
        return _getMessage(() => userRemoteDataSource.deleteUser(userId));
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(User user) async{
    if(await networkInfo.isConnected){
      try{
        final UserModel userModel = UserModel(id: user.id ,name: user.name, email: user.email);
        return _getMessage(() => userRemoteDataSource.updateUser(userModel));
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }


  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddUser deleteOrUpdateOrAdd) async {
    if(await networkInfo.isConnected){
      try{
        await deleteOrUpdateOrAdd();
        return const Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

}