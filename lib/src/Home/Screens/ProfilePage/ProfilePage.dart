import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inicio/src/Home/Screens/HomePage/Bloc/ListNewsBloc.dart';
import 'package:inicio/src/Home/Screens/HomePage/Providers/News.dart';

import 'Novedades.dart';

class ProfilePage extends StatefulWidget {
  final String nombre;
  ProfilePage(this.nombre);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final PickedFile pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(
        () {
          _pickImageError = e;
        },
      );
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return CircleAvatar(
        maxRadius: 100.0,
        backgroundImage: FileImage(
          File(_imageFile.path),
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return CircleAvatar(
        maxRadius: 100,
        backgroundImage: NetworkImage('https://picsum.photos/${400}/${400}'),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(
        () {
          _imageFile = response.file;
        },
      );
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
      ),
      body: Stack(
        children: [
          Novedades(),
          Card(
            margin: EdgeInsets.only(bottom: 300),
            child: Column(
              children: [
                Center(
                  heightFactor: 1.1,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Seguidores: \n 0",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20, right: 100)),
                          FloatingActionButton(
                            child: Icon(Icons.photo_album),
                            onPressed: () {
                              _onImageButtonPressed(ImageSource.gallery,
                                  context: context);
                            },
                          )
                        ],
                      ),
                      defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveLostData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                GestureDetector(
                                  onTap: () {
                                    _onImageButtonPressed(ImageSource.gallery,
                                        context: context);
                                  },
                                );
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return CircleAvatar(
                                      maxRadius: 100,
                                      backgroundImage: NetworkImage(
                                          'https://picsum.photos/${400}/${400}'),
                                    );
                                  case ConnectionState.done:
                                    return _previewImage();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Pick image/video error: ${snapshot.error}}',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return CircleAvatar(
                                        maxRadius: 150,
                                        backgroundImage: NetworkImage(
                                            'https://picsum.photos/${400}/${400}'),
                                      );
                                    }
                                }
                              },
                            )
                          : _previewImage(),
                      Column(
                        children: [
                          Text(
                            "Publicaciones: \n 0",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          FloatingActionButton(
                            child: Icon(Icons.camera_alt),
                            onPressed: () {
                              _onImageButtonPressed(ImageSource.camera,
                                  context: context);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: 120,
                  width: 400,
                  margin: EdgeInsets.all(5.0),
                  child: Text(
                    "1. Tienes razón, mi perfil no es perfecto.  \n" +
                        "2. ¡Sonríe! Esa es la actitud.\n" +
                        "3. Aprendiz de mucho, maestra de nada.\n" +
                        "4. La felicidad es una dirección, no un lugar.\n" +
                        "5. Vivo, sueño, viajo. Repito.\n",
                    textAlign: TextAlign.left,
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
