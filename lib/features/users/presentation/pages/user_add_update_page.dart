import 'package:clean/core/navigations/bottom_nav/bottom_nav_screen.dart';
import 'package:clean/core/utils/snackbar.dart';
import 'package:clean/core/widgets/loading_widget.dart';
import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/presentation/blocs/user_bloc.dart';
import 'package:clean/features/users/presentation/blocs/user_state.dart';
import 'package:clean/features/users/presentation/widgets/add_update_user/form_add_update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddUpdateWidget extends StatelessWidget {
  final bool isUpdate;
  final User? user;
  const UserAddUpdateWidget({super.key, required this.isUpdate, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update User" : "Add User"),
      ),
      body: Center(
        child: BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            if(state is LoadingUserState){
              return const LoadingWidget();
            }
            return FormWidgetAddUpdateUser(isUpdate: isUpdate, user: isUpdate ? user : null,);
          }, 
          listener: (context, state) {
            if(state is MessageUserState){
              SnackbarMessage().showSuccessSnackBar(message: state.message, context: context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNavBarPage(),), (route) => false);
            }else if (state is ErrorUserState){
              SnackbarMessage().showErrorSnackBar(message: state.message, context: context);
            }
          },),
      ),
    );
  }
}