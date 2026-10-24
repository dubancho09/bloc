part of 'tarea_bloc.dart';

sealed class TareaEvent extends Equatable {
  const TareaEvent();

  @override
  List<Object?> get props => [];
}

class TareasCargadas extends TareaEvent {
  const TareasCargadas();
}

class TareaAgregada extends TareaEvent {
  final Tarea tarea;

  const TareaAgregada(this.tarea);

  @override
  List<Object?> get props => [tarea];
}

class TareaEstadoCambiado extends TareaEvent {
  final Tarea tarea;

  const TareaEstadoCambiado(this.tarea);

  @override
  List<Object?> get props => [tarea];
}
