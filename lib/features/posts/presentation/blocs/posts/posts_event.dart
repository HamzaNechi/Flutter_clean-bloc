import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable{

  const PostEvent();


  @override
  List<Object?> get props => [];
}



class GetAllPostsEvent extends PostEvent{}

class RefreshPostEvent extends PostEvent{}
