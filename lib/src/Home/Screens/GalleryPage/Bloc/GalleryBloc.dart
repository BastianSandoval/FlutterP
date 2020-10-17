import 'dart:async';

import 'package:inicio/src/Home/Screens/GalleryPage/Providers/AlbumProvider.dart';
import 'package:photo_gallery/photo_gallery.dart';

class Bloc {}

class MostrarGalleria extends Bloc {}

class GalleryBloc {
  final AlbumProvider provider = AlbumProvider();

  // ignore: close_sinks
  StreamController<Bloc> _input = StreamController();
  //salida de datos
  StreamController<List<Album>> _output = StreamController();

  GalleryBloc() {
    this._input.stream.listen(_onEvent);
  }

  //Metodo Entrada
  StreamSink<Bloc> get sinkEvent => _input.sink;

  //Metodo Salida
  Stream<List<Album>> get getAlbum => _output.stream;

  void dispose() {
    this._input.close();
    this._output.close();
  }

  void _onEvent(Bloc event) async {
    if (event is MostrarGalleria) {
      _output.add(await provider.initAsync());
    }
  }
}
