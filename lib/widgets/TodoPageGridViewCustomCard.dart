import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TodoPageGridViewCustomCard extends StatelessWidget {

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
  final double percent;
  final VoidCallback onPressed;

  const TodoPageGridViewCustomCard({Key key, @required this.color, @required this.icon, @required this.title, @required this.subTitle, @required this.onPressed, this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Card(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: color,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    icon,
                    Expanded(child: Container()),
                    CircularPercentIndicator(
                      radius: 35,
                      lineWidth:2.5,
                      backgroundColor: Colors.black,//Theme.of(context).accentColor,
                      percent: percent/100,
                      progressColor: Colors.white,//Theme.of(context).primaryColor,
                      center: percent.toInt()==100?Icon(Icons.check_circle, size: 30, color: Colors.white):Text(percent.toInt().toString(), style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(title??"", style: Theme.of(context).textTheme.title.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
                ),
                Container(
                  child: Text(subTitle??"", style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white)),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}