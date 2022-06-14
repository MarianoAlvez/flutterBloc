// 2. Lista de epleados
// 3. Stream Controllers
// 4. Stream Sink Getters
// 5. Constructor - añadir data, escuchar cambios
// 6. dispose
// 1. imports

import 'dart:async';
import 'empleado.dart';

//Se remplasara por una petición a una Api
class EmpleadoBloc {
  List<Empleado> _empleadoList = [
    Empleado(1, 'Empleado 1', 1000.0),
    Empleado(2, 'Empleado 2', 2000.0),
    Empleado(3, 'Empleado 3', 3000.0),
    Empleado(4, 'Empleado 4', 4000.0),
    Empleado(5, 'Empleado 5', 5000.0),
  ];

  //creamos un sinc y stream por cada evento
  //stream Controller
  final _empleadoListStreamController = StreamController<List<Empleado>>();
  final _empleadoSalarioIncrementoStreamController =
      StreamController<Empleado>();
  final _empleadoSalarioDecrementoStreamController =
      StreamController<Empleado>();

  //Getters: stream y sinks
  Stream<List<Empleado>> get empleadoListStream =>
      _empleadoListStreamController.stream;
  StreamSink<List<Empleado>> get empleadoListSink =>
      _empleadoListStreamController.sink;

  StreamSink<Empleado> get empleadoSalarioIncrement =>
      _empleadoSalarioIncrementoStreamController.sink;

  StreamSink<Empleado> get empleadoSalarioDecrement =>
      _empleadoSalarioDecrementoStreamController.sink;

  //Constructor
  EmpleadoBloc() {
    _empleadoListStreamController.add(_empleadoList);
    _empleadoSalarioIncrementoStreamController.stream.listen(_incrementSalario);
    _empleadoSalarioDecrementoStreamController.stream.listen(_decrementSalario);
  }

  //Funciones principales (core function)
  _incrementSalario(Empleado empleado) {
    double salarioActual = empleado.salario;
    double salarioIncrement = salarioActual * 20 / 100;

    _empleadoList[empleado.id - 1].salario = salarioActual + salarioIncrement;
    empleadoListSink.add(_empleadoList);
  }

  _decrementSalario(Empleado empleado) {
    double salarioActual = empleado.salario;
    double salarioIncrement = salarioActual * 20 / 100;

    _empleadoList[empleado.id - 1].salario = salarioActual - salarioIncrement;
    empleadoListSink.add(_empleadoList);
  }

  //Dispose
  void dispose() {
    _empleadoListStreamController.close();
    _empleadoSalarioIncrementoStreamController.close();
    _empleadoSalarioDecrementoStreamController.close();
  }
}
