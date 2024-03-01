import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:clean/features/posts/domain/repositories/post.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase{
  final PostRepository _postRepository;

  GetAllPostsUseCase(this._postRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await _postRepository.getAllPosts();
  }
}