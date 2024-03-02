import 'package:clean/core/navigations/bottom_nav/bottom_nav_bloc/bloc/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarPage extends StatelessWidget {
  const BottomNavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final String titleAppBar = state.props[1].toString();
        final Widget widget = state.props[0] as Widget;
        final Widget actionFloatingButtonNavigator = state.props[2] as Widget;
        int index = state.props[3] as int;

        return Scaffold(
          appBar: AppBar(
            title: Text(titleAppBar),
          ),

          body: widget,

          floatingActionButton: FloatingActionButton(
            onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => actionFloatingButtonNavigator,));
          },
          child:const Icon(Icons.add), 
          ),

          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "users"
              ),


              BottomNavigationBarItem(
                icon: Icon(Icons.pan_tool_alt_sharp),
                label: "posts"
              ),
            ],

            currentIndex: index,
            onTap: (value) {
              BlocProvider.of<BottomNavBloc>(context).add(BottomNavOnChangeEvent(index: value));
            },
            ),
        );
      }, 
      );
  }
}