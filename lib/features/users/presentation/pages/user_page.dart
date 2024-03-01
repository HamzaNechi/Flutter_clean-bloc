import 'package:clean/core/widgets/loading_widget.dart';
import 'package:clean/features/posts/presentation/widgets/message_display_widget.dart';
import 'package:clean/features/users/presentation/blocs/user_bloc.dart';
import 'package:clean/features/users/presentation/blocs/user_event.dart';
import 'package:clean/features/users/presentation/blocs/user_state.dart';
import 'package:clean/features/users/presentation/pages/user_add_update_page.dart';
import 'package:clean/features/users/presentation/widgets/list_users/list_users_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Users"),
      ),

      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserAddUpdateWidget(isUpdate: false),));
      },
      child: const Icon(Icons.add), 
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if(state is LoadingUserState){
              return const LoadingWidget();
            }else if(state is LoadedUserState){
              return RefreshIndicator(
                onRefresh: () => _refreshUsers(context),
                child: ListUserWidget(users: state.users));
            }else if(state is ErrorUserState){
              return MessageDisplayWidget(message: state.message);
            }else if(state is MessageUserState){
              BlocProvider.of<UserBloc>(context).add(RefreshAllUsersEvent());
            }

            return const Center(
              child: Text("Mochekla fel bloc"),
            );
          },
        ),
        ),
    );
  }

  Future<void> _refreshUsers(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(RefreshAllUsersEvent()) ;
  }
}