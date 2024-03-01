import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/posts/domain/repositories/post.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase{
  final PostRepository postRepository;

  DeletePostUseCase(this.postRepository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await postRepository.deletePost(postId);
  }

}