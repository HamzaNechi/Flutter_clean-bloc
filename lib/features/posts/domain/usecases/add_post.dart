import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:clean/features/posts/domain/repositories/post.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase{
  final PostRepository postRepository;

  AddPostUseCase(this.postRepository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.addPost(post);
  }

}