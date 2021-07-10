import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/about/about_us.dart';
import 'package:flutter_app/pages/login/login.dart';
import 'package:flutter_app/auth/auth.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/projects/project_widget.dart';
import 'package:flutter_app/pages/tasks/add_task.dart';
import 'package:flutter_app/pages/tasks/task_completed/task_complted.dart';
import 'package:flutter_app/utils/extension.dart';
import 'package:provider/provider.dart';


import 'dart:html';

void main() async {

  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();

  // Build home page
  Widget home = new BlocProvider(bloc: HomeBloc(), child: AdaptiveHome());

  // Run app!
  runApp(new MaterialApp(
    title: 'WhatToDo',
    home: ChangeNotifierProvider(
      create: (context) => AuthData.get(),
      child: new LoginPage(homepage:home),
    ),
    theme: ThemeData(
      accentColor: Colors.orange,
      primaryColor: const Color(0xFFDE4435),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}


class AdaptiveHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.isWiderScreen() ? WiderHomePage() : HomePage();
  }
}

class WiderHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeBloc = context.bloc<HomeBloc>();
    return Row(
      children: [
        Expanded(
          child: StreamBuilder<SCREEN>(
              stream: homeBloc.screens,
              builder: (context, snapshot) {
                //Refresh side drawer whenever screen is updated
                return SideDrawer();
              }),
          flex: 2,
        ),
        SizedBox(
          width: 0.5,
        ),
        Expanded(
          child: StreamBuilder<SCREEN>(
              stream: homeBloc.screens,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  // ignore: missing_enum_constant_in_switch
                  switch (snapshot.data) {
                    case SCREEN.ABOUT:
                      return AboutUsScreen();
                    case SCREEN.ADD_TASK:
                      return AddTaskProvider();
                    case SCREEN.COMPLETED_TASK:
                      return TaskCompletedPage();
                    case SCREEN.ADD_PROJECT:
                      return AddProjectPage();
                    case SCREEN.HOME:
                      return HomePage();
                  }
                }
                return HomePage();
              }),
          flex: 5,
        )
      ],
    );
  }
}
