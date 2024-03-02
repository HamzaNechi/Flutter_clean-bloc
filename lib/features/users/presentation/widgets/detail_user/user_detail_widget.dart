import 'package:clean/core/navigations/bottom_nav/bottom_nav_screen.dart';
import 'package:clean/core/utils/snackbar.dart';
import 'package:clean/core/widgets/loading_widget.dart';
import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/presentation/blocs/user_bloc.dart';
import 'package:clean/features/users/presentation/blocs/user_state.dart';
import 'package:clean/features/users/presentation/pages/user_add_update_page.dart';
import 'package:clean/features/users/presentation/widgets/detail_user/delete_dialog_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailWidget extends StatelessWidget {
  final User user;
  const UserDetailWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(user.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

          const Divider(height: 50,),

          Text(user.email, style: const TextStyle(fontSize: 16,),),

          const Divider(height: 50,),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
              onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => UserAddUpdateWidget(isUpdate: true, user: user,),)), 
              icon: const Icon(Icons.edit,),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade700),
              ),
              label: const Text("Edit" ),
              ),

              const SizedBox(width: 10,),



              ElevatedButton.icon(
              onPressed:() => deleteDialog(context), 
              icon: const Icon(Icons.delete,),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600),
              ),
              label: const Text("Delete" ),
              ),
            ],
          )
        ],
      ),
      );
  }



  void deleteDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return BlocConsumer<UserBloc , UserState>(
      builder: (context, state) {
        if(state is LoadingUserState){
          return const AlertDialog(
            title: LoadingWidget(),
          );
        }

        return DeleteUserDialogWidget(userId: user.id!,);
      }, 
      listener: (context, state) {
        if(state is MessageUserState){
          SnackbarMessage().showSuccessSnackBar(message: state.message, context: context);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BottomNavBarPage(),), (route) => false);
        }else if (state is ErrorUserState){
          Navigator.of(context).pop();
          SnackbarMessage().showErrorSnackBar(message: state.message, context: context);
        }
      },);
    },);
  }
}