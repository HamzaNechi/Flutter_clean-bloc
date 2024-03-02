import 'package:clean/core/widgets/loading_widget.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_event.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_state.dart';
import 'package:clean/features/posts/presentation/widgets/message_display_widget.dart';
import 'package:clean/features/posts/presentation/widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if(state is LoadingPostState){
            return const LoadingWidget();
          }else if(state is LoadedPostState){
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts : state.posts));
          }else if(state is ErrorPostState){
            return MessageDisplayWidget(message : state.message);
          }

          return const LoadingWidget();
        },
        ),
      );
  }
}



Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<PostBloc>(context).add(RefreshPostEvent());
}