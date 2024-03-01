import 'package:clean/features/posts/domain/entities/post.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_event.dart';
import 'package:clean/features/posts/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class FormAddUpdateWidget extends StatefulWidget {

  final bool isUpdate;
  final Post? post;
  const FormAddUpdateWidget({super.key, required this.isUpdate, this.post});

  @override
  State<FormAddUpdateWidget> createState() => _FormAddUpdateWidgetState();
}

class _FormAddUpdateWidgetState extends State<FormAddUpdateWidget> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if(widget.isUpdate){
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }


  void validateFormThenUpdateOrAddPost(){
    final isValid = _key.currentState!.validate();
    if(isValid){
      final Post post = Post(id: widget.isUpdate ? widget.post!.id : null, title: _titleController.text, body: _bodyController.text);
      if(widget.isUpdate){
        BlocProvider.of<AddDeleteUpdateBloc>(context).add(UpdatePostEvent(post: post));
      }else{
        BlocProvider.of<AddDeleteUpdateBloc>(context).add(AddPostEvent(post: post));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(controller: _titleController, isMultilines: false, validateText: "Title can't be empty", hintTextValue: 'title',),
          TextFormFieldWidget(controller: _bodyController, isMultilines: true, validateText: "Body can't be empty", hintTextValue: 'body',),
          ElevatedButton.icon(
          onPressed:validateFormThenUpdateOrAddPost, 
          icon: Icon(widget.isUpdate ? Icons.edit : Icons.add,),
          label: Text(widget.isUpdate ? "Edit" : "Add",),
          )

        ],
      ));
  }
}