import 'package:equatable/equatable.dart';

class Tarea extends Equatable {
  final int? id;
  final String nombre;
  final String descripcion;
  final bool terminada;

  const Tarea({
    this.id,
    required this.nombre,
    required this.descripcion,
    this.terminada = false,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      id: json['id'] as int?,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String? ?? '',
      terminada: json['terminada'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'descripcion': descripcion,
        'terminada': terminada,
      };

  Tarea copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    bool? terminada,
  }) {
    return Tarea(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      terminada: terminada ?? this.terminada,
    );
  }

  @override
  List<Object?> get props => [id, nombre, descripcion, terminada];
}
