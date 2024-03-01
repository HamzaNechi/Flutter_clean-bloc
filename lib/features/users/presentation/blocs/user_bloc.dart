import 'package:clean/core/errors/failures.dart';
import 'package:clean/core/strings/failures.dart';
import 'package:clean/core/strings/messages.dart';
import 'package:clean/features/users/domain/usecases/add_user.dart';
import 'package:clean/features/users/domain/usecases/delete_user.dart';
import 'package:clean/features/users/domain/usecases/get_all_user.dart';
import 'package:clean/features/users/domain/usecases/update_user.dart';
import 'package:clean/features/users/presentation/blocs/user_event.dart';
import 'package:clean/features/users/presentation/blocs/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final GetAllUserUseCase getAllUsers;
  final AddUserUseCase addUser;
  final UpdateUserUseCase updateUser;
  final DeleteUserUseCase deleteUser;

  UserBloc(
    {required this.getAllUsers, 
    required this.addUser, 
    required this.updateUser, 
    required this.deleteUser}) : super(InitialUserState()){
      on<UserEvent>((event, emit) async {
        //get all users
        if(event is GetAllUsersEvent || event is RefreshAllUsersEvent){
          emit(LoadingUserState());
          final failureOrUsers = await getAllUsers();
          failureOrUsers.fold(
            (failure) {
              emit(ErrorUserState(message: _mapFailureToMessage(failure)));
            }, 
            (users) => {
              emit(LoadedUserState(users: users))
            });
        }


        //add user
        if(event is AddUserEvent){
          emit(LoadingUserState());
          final failureOrDoneAction = await addUser(event.user);
          emit(_eitherDoneMessageOrErrorState(failureOrDoneAction, USER_ADD_SUCCESS_MESSAGE));
        }


        //update user
        if(event is UpdateUserEvent){
          emit(LoadingUserState());
          final failureOrDoneAction = await updateUser(event.user);
          emit(_eitherDoneMessageOrErrorState(failureOrDoneAction, USER_UPDATE_SUCCESS_MESSAGE));
        }


        //delete user
        if(event is DeleteUserEvent){
          emit(LoadingUserState());
          final failureOrDoneAction = await deleteUser(event.userId);
          emit(_eitherDoneMessageOrErrorState(failureOrDoneAction, USER_DELETE_SUCCESS_MESSAGE));
        }

      });
    }


    UserState _eitherDoneMessageOrErrorState(Either<Failure, Unit> failureOrDone , String message){
      return failureOrDone.fold(
            (failure) {
              return ErrorUserState(message: _mapFailureToMessage(failure));
            }, 
            (_) {
              return MessageUserState(message: message);
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