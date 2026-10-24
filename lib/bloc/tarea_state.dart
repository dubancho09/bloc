part of 'tarea_bloc.dart';

enum TareaStatus { inicial, cargando, exito, error }

class TareaState extends Equatable {
  final List<Tarea> tareas;
  final TareaStatus status;
  final String? error;

  const TareaState({
    this.tareas = const [],
    this.status = TareaStatus.inicial,
    this.error,
  });

  TareaState copyWith({
    List<Tarea>? tareas,
    TareaStatus? status,
    String? error,
  }) {
    return TareaState(
      tareas: tareas ?? this.tareas,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [tareas, status, error];
}
