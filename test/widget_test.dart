import 'package:flutter_test/flutter_test.dart' show isA;
import 'package:bloc_test/bloc_test.dart';
import 'package:estados_app/bloc/tarea_bloc.dart';
import 'package:estados_app/models/tarea.dart';
import 'package:estados_app/services/tarea_service.dart';

class FakeTareaService extends TareaService {
  FakeTareaService({this.falla = false});

  final bool falla;
  final List<Tarea> _db = [
    const Tarea(id: 1, nombre: 'Estudiar', descripcion: 'Bloc'),
  ];

  @override
  Future<List<Tarea>> obtenerTareas() async {
    if (falla) throw Exception('sin conexión');
    return List.of(_db);
  }

  @override
  Future<Tarea> crearTarea(Tarea tarea) async => tarea.copyWith(id: 2);

  @override
  Future<Tarea> actualizarEstado(int id, bool terminada) async =>
      _db.first.copyWith(terminada: terminada);
}

void main() {
  const tarea = Tarea(id: 1, nombre: 'Estudiar', descripcion: 'Bloc');

  blocTest<TareaBloc, TareaState>(
    'carga las tareas desde el servicio',
    build: () => TareaBloc(service: FakeTareaService()),
    act: (bloc) => bloc.add(const TareasCargadas()),
    expect: () => [
      const TareaState(status: TareaStatus.cargando),
      const TareaState(tareas: [tarea], status: TareaStatus.exito),
    ],
  );

  blocTest<TareaBloc, TareaState>(
    'emite error si el servicio falla',
    build: () => TareaBloc(service: FakeTareaService(falla: true)),
    act: (bloc) => bloc.add(const TareasCargadas()),
    expect: () => [
      const TareaState(status: TareaStatus.cargando),
      isA<TareaState>().having((s) => s.status, 'status', TareaStatus.error),
    ],
  );

  blocTest<TareaBloc, TareaState>(
    'agrega una tarea con el id del servidor',
    build: () => TareaBloc(service: FakeTareaService()),
    act: (bloc) => bloc.add(
      const TareaAgregada(Tarea(nombre: 'Nueva', descripcion: '')),
    ),
    expect: () => [
      const TareaState(
        tareas: [Tarea(id: 2, nombre: 'Nueva', descripcion: '')],
        status: TareaStatus.exito,
      ),
    ],
  );

  blocTest<TareaBloc, TareaState>(
    'cambia el estado de una tarea',
    build: () => TareaBloc(service: FakeTareaService()),
    seed: () => const TareaState(tareas: [tarea], status: TareaStatus.exito),
    act: (bloc) => bloc.add(const TareaEstadoCambiado(tarea)),
    expect: () => [
      const TareaState(
        tareas: [
          Tarea(id: 1, nombre: 'Estudiar', descripcion: 'Bloc', terminada: true),
        ],
        status: TareaStatus.exito,
      ),
    ],
  );
}
