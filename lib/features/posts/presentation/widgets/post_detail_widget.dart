import 'package:clean/core/utils/snackbar.dart';
import 'package:clean/core/widgets/loading_widget.dart';
import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_state.dart';
import 'package:clean/features/posts/presentation/pages/post_add_update.dart';
import 'package:clean/features/posts/presentation/pages/post_page.dart';
import 'package:clean/features/posts/presentation/widgets/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(post.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

          const Divider(height: 50,),

          Text(post.body, style: const TextStyle(fontSize: 16,),),

          const Divider(height: 50,),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
              onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PostAddUpdatePage(isUpdate: true, post: post,),)), 
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
      return BlocConsumer<AddDeleteUpdateBloc , AddDeleteUpdateState>(
      builder: (context, state) {
        if(state is LoadingAddDeleteUpdatePostState){
          return const AlertDialog(
            title: LoadingWidget(),
          );
        }

        return DeleteDialogWidget(postId : post.id!);
      }, 
      listener: (context, state) {
        if(state is MessageAddDeleteUpdatePostState){
          SnackbarMessage().showSuccessSnackBar(message: state.message, context: context);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PostPage(),), (route) => false);
        }else if (state is ErrorAddDeleteUpdatePostState){
          Navigator.of(context).pop();
          SnackbarMessage().showErrorSnackBar(message: state.message, context: context);
        }
      },);
    },);
  }
}