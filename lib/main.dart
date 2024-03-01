import 'package:clean/core/app_theme.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_event.dart';
import 'package:clean/features/posts/presentation/pages/post_page.dart';
import 'package:clean/features/users/presentation/blocs/user_bloc.dart';
import 'package:clean/features/users/presentation/blocs/user_event.dart';
import 'package:clean/features/users/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => di.sl<PostBloc>()..add(GetAllPostsEvent()),),
      BlocProvider(create: (_) => di.sl<AddDeleteUpdateBloc>(),),
      BlocProvider(create: (_) => di.sl<UserBloc>()..add(GetAllUsersEvent()),)
    ], child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const UserPage(),
    ));
  }
}



