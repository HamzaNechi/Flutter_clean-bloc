import 'package:clean/features/users/domain/entities/user.dart';
import 'package:clean/features/users/presentation/blocs/user_bloc.dart';
import 'package:clean/features/users/presentation/blocs/user_event.dart';
import 'package:clean/features/users/presentation/widgets/add_update_user/text_editing_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidgetAddUpdateUser extends StatefulWidget {
  final bool isUpdate;
  final User? user;
  const FormWidgetAddUpdateUser({super.key, required this.isUpdate, this.user});

  @override
  State<FormWidgetAddUpdateUser> createState() => _FormWidgetAddUpdateUserState();
}

class _FormWidgetAddUpdateUserState extends State<FormWidgetAddUpdateUser> {

  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    if(widget.isUpdate){
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
    }
    super.initState();
  }


  
    validateAndSubmitForm() {
      if(_keyform.currentState!.validate()){
        final User user = User(id: widget.isUpdate ? widget.user!.id : null ,name: _nameController.text, email: _emailController.text);
        if(widget.isUpdate){
          BlocProvider.of<UserBloc>(context).add(UpdateUserEvent(user: user));
        }else{
          BlocProvider.of<UserBloc>(context).add(AddUserEvent(user: user));
        }
      }
    }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _keyform,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextEditingWidgetForUserForm(controller: _nameController, hint: 'Name', validateText: "Name can't be empty"),
          TextEditingWidgetForUserForm(controller: _emailController, hint: 'Email', validateText: "Email can't be empty"),


          ElevatedButton.icon(
            onPressed: () => validateAndSubmitForm(), 
            icon: const Icon(Icons.add), 
            label: const Text("Add User"))
        ],
      )
      );


      
  }
  
  
}