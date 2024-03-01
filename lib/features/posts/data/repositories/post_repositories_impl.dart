import 'package:clean/core/errors/exceptions.dart';
import 'package:clean/core/errors/failures.dart';
import 'package:clean/core/network/network_info.dart';
import 'package:clean/features/posts/data/datasources/post_local_datasource.dart';
import 'package:clean/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:clean/features/posts/data/models/post_model.dart';
import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:clean/features/posts/domain/repositories/post.dart';
import 'package:dartz/dartz.dart';


typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostRepositoryImpl implements PostRepository{

  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl({required this.remoteDataSource,required this.localDataSource, required this.networkInfo});



  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if(await networkInfo.isConnected){
      try{
        final remotePosts = await remoteDataSource.getAllPost();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      }on ServerException {
        return Left(ServerFailure());
      } 
    }else{
      try{
        final localPosts = await localDataSource.getCachedPost();
        return Right(localPosts);
      }on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }


  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdateOrAdd) async {
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