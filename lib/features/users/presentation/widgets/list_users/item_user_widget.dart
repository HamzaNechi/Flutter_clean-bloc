import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/presentation/pages/user_detail_page.dart';
import 'package:flutter/material.dart';

class ItemUserWidget extends StatelessWidget {
  final User user;
  const ItemUserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(user.id.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
      title: Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), ),
      subtitle: Text(user.email, style: const TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailPage(user: user),));
      },
    );
  }
}