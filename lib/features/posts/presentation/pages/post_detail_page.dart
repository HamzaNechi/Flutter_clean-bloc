import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:clean/features/posts/presentation/widgets/post_detail_widget.dart';
import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child : PostDetailWidget(post: post,)
          ),
          
      ),
    );
  }
}