import 'dart:async';

import 'package:inicio/src/Home/Screens/PhotosPage/Providers/Http/ApiPhotos.dart';
import 'package:inicio/src/Home/Screens/PhotosPage/Providers/photos.dart';

class Bloc {}

class MostrarPhotos extends Bloc {}

class ListPhotosBloc {
  final ApiPhotos _api = ApiPhotos();

  // ignore: close_sinks
  StreamController<Bloc> _input = StreamController();
  //salida de datos
  StreamController<List<Photos>> _output = StreamController();

  ListPhotosBloc() {
    this._input.stream.listen(_onEvent);
  }

  //Metodo Entrada
  StreamSink<Bloc> get sinkPhotos => _input.sink;

  //Metodo Salida
  Stream<List<Photos>> get getPhotos => _output.stream;

  void dispose() {
    this._input.close();
    this._output.close();
  }

  void _onEvent(Bloc event) async {
    if (event is MostrarPhotos) {
      _output.add(await _api.getPhotos());
    }
  }
}
