import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inicio/src/Home/Screens/HomePage/Bloc/ListNewsBloc.dart';
import 'package:inicio/src/Home/Screens/HomePage/Providers/News.dart';

class Novedades extends StatelessWidget {
  ListNewsBloc bloc = ListNewsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.sinkNews.add(MostrarNews());
    return Scaffold(
      body: StreamBuilder<List<News>>(
        stream: bloc.getNews,
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 400.0),
              physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                snapshot.data[index].thumbnailUrl)),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        width: 300,
                        child: Text(
                          snapshot.data[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              heightFactor: 3,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
