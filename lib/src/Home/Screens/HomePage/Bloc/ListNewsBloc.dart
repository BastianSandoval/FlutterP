import 'dart:async';

import 'package:inicio/src/Home/Screens/HomePage/Providers/Http/ApiNews.dart';
import 'package:inicio/src/Home/Screens/HomePage/Providers/News.dart';

class Bloc {}

class MostrarNews extends Bloc {}

class ListNewsBloc {
  final ApiNews _api = ApiNews();

  // ignore: close_sinks
  StreamController<Bloc> _input = StreamController();
  //salida de datos
  StreamController<List<News>> _output = StreamController();

  ListNewsBloc() {
    this._input.stream.listen(_onEvent);
  }

  //Metodo Entrada
  StreamSink<Bloc> get sinkNews => _input.sink;

  //Metodo Salida
  Stream<List<News>> get getNews => _output.stream;

  void dispose() {
    this._input.close();
    this._output.close();
  }

  void _onEvent(Bloc event) async {
    if (event is MostrarNews) {
      _output.add(await _api.getNews());
    }
  }
}
