import 'package:estados_app/bloc/tarea_bloc.dart';
import 'package:estados_app/config/routes.dart';
import 'package:estados_app/services/tarea_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TareaBloc(service: TareaService())..add(const TareasCargadas()),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Material App',
      ),
    );
  }
}
