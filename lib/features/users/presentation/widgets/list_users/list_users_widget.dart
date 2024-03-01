import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/presentation/widgets/list_users/item_user_widget.dart';
import 'package:flutter/material.dart';

class ListUserWidget extends StatelessWidget {
  final List<User> users;
  const ListUserWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => ItemUserWidget(user : users[index]),);
  }
}