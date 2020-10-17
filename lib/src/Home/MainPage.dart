import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inicio/src/Home/Bloc/NavBarBloc.dart';
import 'Screens/HomePage/View/HomePage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _currentIndex = 2;
  NavBarBloc bloc = NavBarBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Widget>(
        stream: bloc.getItemBar,
        initialData: HomePage(nombre: "Home"),
        builder: (context, snapshot) => snapshot.data,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60.0,
        backgroundColor: Colors.amber,

        //    type: BottomNavigationBarType.fixed,
        items: <Widget>[
          Icon(
            Icons.search,
          ),
          Icon(Icons.picture_in_picture),
          Icon(Icons.home),
          //  Icon(Icons.airplay),
          Icon(Icons.perm_identity),
        ],
        onTap: (index) => setState(
          () {
            switch (index) {
              case 0:
                bloc.sinkItemBar.add(PageSearch());
                break;
              case 1:
                bloc.sinkItemBar.add(PagePhotos());
                break;
              case 2:
                bloc.sinkItemBar.add(PageHome());
                break;
              case 3:
                bloc.sinkItemBar.add(PageProfile());
                break;
            }
            _currentIndex = index;
          },
        ),
      ),
    );
  }
}

Widget customContainer() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    padding: EdgeInsets.all(16),
    //margin: EdgeInsets.all(16),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.black,
    ),
    //transform: Matrix4.rotationZ(.05),
    // constraints: BoxConstraints(maxWidth: 100),
  );
}

class CustomGradientButton extends StatelessWidget {
  final Text text;
  final double width;
  final double height;
  final List<Color> gradientColors;
  final Alignment initialPosition;
  final Alignment finalPosition;
  final Function function;
  final Icon leadingIcon;
  final Icon finalIcon;

  const CustomGradientButton(
      {Key key,
      @required this.text,
      @required this.width,
      @required this.height,
      @required this.gradientColors,
      @required this.initialPosition,
      @required this.finalPosition,
      @required this.function,
      this.leadingIcon,
      this.finalIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: initialPosition,
            end: finalPosition,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, -2),
              blurRadius: height * .1,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            leadingIcon ?? Container(),
            text,
            finalIcon ?? Offstage(),
          ],
        ),
      ),
    );
  }
}

/*void pushPage(BuildContext context, Photos photo, String tag) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => InformationPagePhoto(photo, tag),
    ),
  );
}*/
