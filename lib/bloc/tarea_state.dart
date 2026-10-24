part of 'tarea_bloc.dart';

class TareaState extends Equatable {
  final List<Tarea> tareas;

  const TareaState({this.tareas = const []});

  @override
  List<Object?> get props => [tareas];
}
