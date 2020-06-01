import 'package:flutter/material.dart';

/*class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return Container(
        color: Colors.lightBlue,
        child: Text("Hey", style: TextStyle(color: Colors.white))
    );
  }
}*/


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text('ShopApp2')
      ),
    );
  }
}
