import 'package:clean/core/errors/failures.dart';
import 'package:clean/core/strings/failures.dart';
import 'package:clean/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_event.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostsUseCase getAllPosts;
  PostBloc(
    {required this.getAllPosts}
  ) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if(event is GetAllPostsEvent || event is RefreshPostEvent){
        emit(LoadingPostState());
        final failureOrPosts = await getAllPosts.call();
        failureOrPosts.fold(
          (failure){
            emit(ErrorPostState(message: _mapFailureToMessage(failure)));
          }, 
          (posts){
            emit(LoadedPostState(posts: posts));
          }
          );
      }
    });
  }


  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure : return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure : return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure : return OFFLINE_FAILURE_MESSAGE;
      default: return "Unexpected Error, Please try again later ";
    }
  }
}