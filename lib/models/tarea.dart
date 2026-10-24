import 'package:equatable/equatable.dart';

class Tarea extends Equatable {
  final String nombre;
  final String descripcion;
  final bool terminada;

  const Tarea({
    required this.nombre,
    required this.descripcion,
    this.terminada = false,
  });

  Tarea copyWith({String? nombre, String? descripcion, bool? terminada}) {
    return Tarea(
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      terminada: terminada ?? this.terminada,
    );
  }

  @override
  List<Object?> get props => [nombre, descripcion, terminada];
}
