import 'package:equatable/equatable.dart';
import 'package:estados_app/models/tarea.dart';
import 'package:estados_app/services/tarea_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tarea_event.dart';
part 'tarea_state.dart';

class TareaBloc extends Bloc<TareaEvent, TareaState> {
  TareaBloc({required TareaService service})
      : _service = service,
        super(const TareaState()) {
    on<TareasCargadas>(_onTareasCargadas);
    on<TareaAgregada>(_onTareaAgregada);
    on<TareaEstadoCambiado>(_onTareaEstadoCambiado);
  }

  final TareaService _service;

  Future<void> _onTareasCargadas(
    TareasCargadas event,
    Emitter<TareaState> emit,
  ) async {
    emit(state.copyWith(status: TareaStatus.cargando));
    try {
      final tareas = await _service.obtenerTareas();
      emit(state.copyWith(tareas: tareas, status: TareaStatus.exito));
    } catch (e) {
      emit(state.copyWith(status: TareaStatus.error, error: e.toString()));
    }
  }

  Future<void> _onTareaAgregada(
    TareaAgregada event,
    Emitter<TareaState> emit,
  ) async {
    try {
      final creada = await _service.crearTarea(event.tarea);
      emit(state.copyWith(
        tareas: [...state.tareas, creada],
        status: TareaStatus.exito,
      ));
    } catch (e) {
      emit(state.copyWith(status: TareaStatus.error, error: e.toString()));
    }
  }

  Future<void> _onTareaEstadoCambiado(
    TareaEstadoCambiado event,
    Emitter<TareaState> emit,
  ) async {
    final original = event.tarea;
    try {
      final actualizada =
          await _service.actualizarEstado(original.id!, !original.terminada);
      emit(state.copyWith(
        tareas: [
          for (final t in state.tareas) t.id == actualizada.id ? actualizada : t,
        ],
        status: TareaStatus.exito,
      ));
    } catch (e) {
      emit(state.copyWith(status: TareaStatus.error, error: e.toString()));
    }
  }
}
