import 'package:equatable/equatable.dart';

abstract class AddDeleteUpdateState extends Equatable{
  const AddDeleteUpdateState();


  @override
  List<Object?> get props => [];
}

class InitialAddDeleteUpdatePost extends AddDeleteUpdateState{}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdateState{}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdateState{
  final String message;

  const ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object?> get props => [message];
}


class MessageAddDeleteUpdatePostState extends AddDeleteUpdateState{
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object?> get props => [message];
}


