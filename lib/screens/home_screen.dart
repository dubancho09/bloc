import 'package:estados_app/bloc/tarea_bloc.dart';
import 'package:estados_app/models/tarea.dart';
import 'package:estados_app/widgets/custom_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  bool _terminada = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  void _guardar() {
    final nombre = _nombreController.text.trim();
    if (nombre.isEmpty) return;

    context.read<TareaBloc>().add(
      TareaAgregada(
        Tarea(
          nombre: nombre,
          descripcion: _descripcionController.text.trim(),
          terminada: _terminada,
        ),
      ),
    );
    _nombreController.clear();
    _descripcionController.clear();
    setState(() => _terminada = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado APP'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Tareas', style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              BlocConsumer<TareaBloc, TareaState>(
                listenWhen: (prev, curr) =>
                    curr.status == TareaStatus.error && prev.status != curr.status,
                listener: (context, state) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error ?? 'Error de conexión')),
                  );
                },
                builder: (context, state) {
                  if (state.status == TareaStatus.cargando) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      for (final tarea in state.tareas) ...[
                        CustomListCard(
                          nombre: tarea.nombre,
                          descripcion: tarea.descripcion,
                          estado: tarea.terminada,
                          onChanged: (_) => context
                              .read<TareaBloc>()
                              .add(TareaEstadoCambiado(tarea)),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ],
                  );
                },
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  hint: Text('Ingrese el nombre de la tarea')
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  hint: Text('Ingrese la descripción de la tarea')
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text('Estado'),
                  SizedBox(width: 15,),
                  Switch(
                    value: _terminada,
                    onChanged: (value) => setState(() => _terminada = value),
                  ),
                ],
              ),
              FilledButton(onPressed: _guardar, child: Text('Guardar'))
            ],
          ),
        ),
      )
    );
  }
}
