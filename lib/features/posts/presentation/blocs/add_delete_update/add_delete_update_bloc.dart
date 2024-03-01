import 'package:clean/core/errors/failures.dart';
import 'package:clean/core/strings/failures.dart';
import 'package:clean/core/strings/messages.dart';
import 'package:clean/features/posts/domain/usecases/add_post.dart';
import 'package:clean/features/posts/domain/usecases/delete_post.dart';
import 'package:clean/features/posts/domain/usecases/update_post.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_event.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDeleteUpdateBloc extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState>{
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUSeCase updatePost;

  AddDeleteUpdateBloc({required this.addPost,required this.deletePost,required this.updatePost}) : super(InitialAddDeleteUpdatePost()){
    on<AddDeleteUpdateEvent>((event, emit) async {
      //add post
      if(event is AddPostEvent){
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
          //update post
      }else{
        if(event is UpdatePostEvent){
          emit(LoadingAddDeleteUpdatePostState());
          final failureOrDoneMessage = await updatePost(event.post);
          emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
            //delete post
        }else{
          if(event is DeletePostEvent){
            emit(LoadingAddDeleteUpdatePostState());
            final failureOrDoneMessage = await deletePost(event.postId);
            emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
          }
        }
      }
    });
  }


  AddDeleteUpdateState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String msg){
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)), 
      (_) => MessageAddDeleteUpdatePostState(message: msg)
      );
  }


  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure : return SERVER_FAILURE_MESSAGE;
      case OfflineFailure : return OFFLINE_FAILURE_MESSAGE;
      default: return "Unexpected Error, Please try again later ";
    }
  }

}