import 'package:clean/features/posts/presentation/pages/post_add_update.dart';
import 'package:clean/features/posts/presentation/pages/post_page.dart';
import 'package:clean/features/users/presentation/pages/user_add_update_page.dart';
import 'package:clean/features/users/presentation/pages/user_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavUsersWidgetState(userWidget: UserPage(), titleAppBar: 'Users', actionFloatingButtonNavigator: UserAddUpdateWidget(isUpdate: false), index: 0)) {
    on<BottomNavEvent>((event, emit) {

      if(event is BottomNavOnChangeEvent){
        switch (event.index){
          case 0 : emit(const BottomNavUsersWidgetState(userWidget: UserPage(), titleAppBar: 'Users', actionFloatingButtonNavigator: UserAddUpdateWidget(isUpdate: false), index: 0));
          break;
          case 1 : emit(const BottomNavPostsWidgetState(postWidget: PostPage(), titleAppBar: 'Posts', actionFloatingButtonNavigator: PostAddUpdatePage(isUpdate: false), index: 1));
          break;
        }
      }
    });
  }
}
