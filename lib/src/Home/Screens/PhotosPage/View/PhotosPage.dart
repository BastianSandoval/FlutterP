import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inicio/src/Home/Screens/PhotosPage/Bloc/ListPhotosBloc.dart';
import 'package:inicio/src/Home/Screens/PhotosPage/Providers/photos.dart';

class PhotosPage extends StatefulWidget {
  final String nombre;
  PhotosPage(this.nombre);
  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  ListPhotosBloc bloc = ListPhotosBloc();

  @override
  Widget build(BuildContext context) {
    bloc.sinkPhotos.add(MostrarPhotos());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
      ),
      body: Stack(
        children: <Widget>[
          galleryPhotos(
            bloc: bloc,
          ),
        ],
      ),
    );
  }
}

Widget galleryPhotos({ListPhotosBloc bloc, int crossAxisCount = 3}) {
  return StreamBuilder<List<Photos>>(
    stream: bloc.getPhotos,
    builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
      if (snapshot.hasData) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {},
            child: photo(snapshot.data[index].thumbnailUrl),
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget photo(String string) {
  return Container(
      //margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Image(image: NetworkImage(string)));
}
