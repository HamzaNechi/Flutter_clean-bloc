import 'package:clean/core/navigations/bottom_nav/bottom_nav_screen.dart';
import 'package:clean/core/utils/snackbar.dart';
import 'package:clean/core/widgets/loading_widget.dart';
import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_state.dart';
import 'package:clean/features/posts/presentation/widgets/form_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdate;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Post" : "Add Post"),
      ),

      body: _buildBody(context),
    );
  }



  Widget _buildBody(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child : BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
          builder: (context, state) {
            if(state is LoadingAddDeleteUpdatePostState){
              return const LoadingWidget();
            }
            return FormAddUpdateWidget(isUpdate:isUpdate, post : isUpdate ? post : null );
          }, 
          listener: (context, state) {
            if(state is MessageAddDeleteUpdatePostState){
              SnackbarMessage().showSuccessSnackBar(message: state.message, context: context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNavBarPage(),), (route) => false);
            }else if(state is ErrorAddDeleteUpdatePostState){
              SnackbarMessage().showErrorSnackBar(message: state.message, context: context);
            }
          },
          )
        ),
        
    );
  }

}



