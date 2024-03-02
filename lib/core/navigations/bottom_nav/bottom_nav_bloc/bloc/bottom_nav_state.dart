part of 'bottom_nav_bloc.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();
  
  @override
  List<Object> get props => [];
}

class BottomNavUsersWidgetState extends BottomNavState{
  final String titleAppBar;
  final Widget userWidget;
  final Widget actionFloatingButtonNavigator;
  final int index;

  const BottomNavUsersWidgetState({required this.userWidget,required this.titleAppBar, required this.actionFloatingButtonNavigator, required this.index});

  @override
  List<Object> get props => [userWidget, titleAppBar, actionFloatingButtonNavigator, index];
}


class BottomNavPostsWidgetState extends BottomNavState{
  final String titleAppBar;
  final Widget actionFloatingButtonNavigator;
  final Widget postWidget;
  final int index;

  const BottomNavPostsWidgetState({required this.postWidget,required this.titleAppBar,required this.actionFloatingButtonNavigator, required this.index});

  @override
  List<Object> get props => [postWidget, titleAppBar, actionFloatingButtonNavigator, index];
}
