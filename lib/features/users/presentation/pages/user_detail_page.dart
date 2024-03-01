import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/presentation/widgets/detail_user/user_detail_widget.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child : UserDetailWidget(user: user,)
          ),
          
      ),
    );
  }
}