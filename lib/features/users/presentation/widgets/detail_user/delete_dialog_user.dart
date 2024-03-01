import 'package:clean/features/users/presentation/blocs/user_bloc.dart';
import 'package:clean/features/users/presentation/blocs/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteUserDialogWidget extends StatelessWidget {
  final int userId;
  const DeleteUserDialogWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure !?" , style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, child: const Text("No")
        ),


        TextButton(
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(DeleteUserEvent(userId: userId));
          }, child: const Text("Yes")
        ),
      ],
    );
  }
}