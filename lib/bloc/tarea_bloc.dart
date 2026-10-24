import 'package:equatable/equatable.dart';
import 'package:estados_app/models/tarea.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tarea_event.dart';
part 'tarea_state.dart';

class TareaBloc extends Bloc<TareaEvent, TareaState> {
  TareaBloc() : super(const TareaState()) {
    on<TareaAgregada>(_onTareaAgregada);
    on<TareaEstadoCambiado>(_onTareaEstadoCambiado);
  }

  void _onTareaAgregada(TareaAgregada event, Emitter<TareaState> emit) {
    emit(TareaState(tareas: [...state.tareas, event.tarea]));
  }

  void _onTareaEstadoCambiado(
    TareaEstadoCambiado event,
    Emitter<TareaState> emit,
  ) {
    final tareas = [...state.tareas];
    final tarea = tareas[event.indice];
    tareas[event.indice] = tarea.copyWith(terminada: !tarea.terminada);
    emit(TareaState(tareas: tareas));
  }
}
