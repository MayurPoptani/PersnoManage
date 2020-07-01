import 'package:flutter/material.dart';

class HomePageGridViewCustomCard extends StatelessWidget {

  static final List<Color> darkThemeCardColors = [
    Color.fromRGBO(245, 139, 105, 1), 
    Color.fromRGBO(119, 182, 226, 1), 
    Color.fromRGBO(121, 139, 190, 1),
    Color.fromRGBO(90, 191, 179, 1),
  ];
  static final List<Color> lightThemeCardColors = [
    Color.fromRGBO(241, 88, 40, 1),
    Color.fromRGBO(40, 128, 189, 1),
    Color.fromRGBO(100, 121, 180, 1), 
    Color.fromRGBO(64, 165, 154, 1), 
  ];

  final Color color;
  final Icon icon;
  final String title, subTitle;
  final VoidCallback onPressed;

  const HomePageGridViewCustomCard({Key key, @required this.color, @required this.icon, @required this.title, @required this.subTitle, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(        
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color: color,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              icon,
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(title??"", style: Theme.of(context).textTheme.title.copyWith(color: Colors.white)),
              ),
              Container(
                child: Text(subTitle??"", style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white)),
              ),
            ],
          ),
        )
      ),
    );
  }
}