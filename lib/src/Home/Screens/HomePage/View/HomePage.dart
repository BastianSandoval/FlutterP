import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inicio/src/Home/Screens/HomePage/Providers/News.dart';
import 'dart:math';

import 'package:inicio/src/Home/Screens/HomePage/View/Tiles.dart';

class HomePage extends StatefulWidget {
  final String nombre;
  HomePage({this.nombre});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int fit = 2;
  static const int _kItemCount = 100;
  final List<IntSize> _sizes;
  _HomePageState() : _sizes = _createSizes(_kItemCount).toList();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
      ),
      body: new StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 4.0,
        itemCount: _kItemCount,
        itemBuilder: (context, index) => new Tiles(index, _sizes[index]),
        staggeredTileBuilder: (index) => new StaggeredTile.fit(fit),
      ),
    );
  }

  Widget description({News data}) => Row(
        children: [
          Container(
            height: 100.0,
            width: 200.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              "Titulo: ${data.title}",
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
}

List<IntSize> _createSizes(int count) {
  Random rnd = new Random();
  return new List.generate(count,
      (i) => new IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}
