import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inicio/src/Home/Screens/HomePage/View/HomePage.dart';
import 'package:inicio/src/Home/Screens/PhotosPage/View/PhotosPage.dart';
import 'package:inicio/src/Home/Screens/GalleryPage/View/GalleryPage.dart';
import 'package:inicio/src/Home/Screens/ProfilePage/ProfilePage.dart';

class Bloc {}

class PagePhotos extends Bloc {}

class PageHome extends Bloc {}

class PageSearch extends Bloc {}

class PageHistories extends Bloc {}

class PageProfile extends Bloc {}

class NavBarBloc {
  // ignore: close_sinks
  StreamController<Bloc> _input = StreamController();
  //salida de datos
  StreamController<Widget> _output = StreamController();

  final tab = [
    Center(
      child: GalleryPage(
        "Galeria",
      ),
    ),
    Center(
      child: PhotosPage("Fotos"),
    ),
    Center(
      child: HomePage(nombre: "Home"),
    ),
    Center(
      child: ProfilePage("Perfil"),
    ),
  ];

  //Constructor
  NavBarBloc() {
    _input.stream.listen(_onEvent);
  }

  //Metodo Entrada
  StreamSink<Bloc> get sinkItemBar => _input.sink;

  //Metodo Salida
  Stream<Widget> get getItemBar => _output.stream;

  void dispose() {
    this._input.close();
    this._output.close();
  }

  void _onEvent(Bloc event) {
    if (event is PageSearch) {
      _output.add(tab[0]);
    }
    if (event is PagePhotos) {
      _output.add(tab[1]);
    }
    if (event is PageHome) {
      _output.add(tab[2]);
    }
    if (event is PageProfile) {
      _output.add(tab[3]);
    }
  }
}
