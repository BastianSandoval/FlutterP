import 'package:flutter/Material.dart';
import 'package:animate_do/animate_do.dart';
import 'HomePage.dart';

class Tiles extends StatefulWidget {
  final IntSize size;

  final int index;

  Tiles(this.index, this.size);

  @override
  _TilesState createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  bool icon = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => setState(() {
        switch (icon) {
          case true:
            icon = false;
            break;
          case false:
            icon = true;
            break;
        }
      }),
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.size.height.toDouble() * 0.4,
            width: widget.size.width.toDouble() * 0.4,
            child: Image(
              image: NetworkImage(
                  'https://picsum.photos/${widget.size.height}/${widget.size.width}'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: icon
                ? JelloIn(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
    );
  }
}
