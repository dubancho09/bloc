import 'package:bloc_test/bloc_test.dart';
import 'package:estados_app/bloc/tarea_bloc.dart';
import 'package:estados_app/models/tarea.dart';

void main() {
  const tarea = Tarea(nombre: 'Estudiar', descripcion: 'Bloc');

  blocTest<TareaBloc, TareaState>(
    'agrega una tarea',
    build: TareaBloc.new,
    act: (bloc) => bloc.add(const TareaAgregada(tarea)),
    expect: () => [
      const TareaState(tareas: [tarea]),
    ],
  );

  blocTest<TareaBloc, TareaState>(
    'cambia el estado de una tarea',
    build: TareaBloc.new,
    seed: () => const TareaState(tareas: [tarea]),
    act: (bloc) => bloc.add(const TareaEstadoCambiado(0)),
    expect: () => [
      const TareaState(tareas: [Tarea(nombre: 'Estudiar', descripcion: 'Bloc', terminada: true)]),
    ],
  );
}
