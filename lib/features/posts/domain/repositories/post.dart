import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository{
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id); //Either est un class pour la logique ( on peut retourner error en cas d'échec ou rien (Unit) en cas de réussir)
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}