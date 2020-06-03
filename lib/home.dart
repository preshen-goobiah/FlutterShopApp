import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutterapp/components/horizontal_listview.dart';
import 'package:flutterapp/components/products.dart';

// helper files
import 'components/horizontal_listview.dart';

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

    Widget image_carousel = new Container(
        height: 200,
        child: new Carousel(
          boxFit: BoxFit.cover,
          dotSize: 2,
          indicatorBgPadding: 1,
          images: [
            AssetImage('images/c1.jpg'),
            AssetImage('images/m1.jpeg'),
            AssetImage('images/w3.jpeg'),
            AssetImage('images/w4.jpeg'),
            AssetImage('images/m2.jpg'),
          ],
          autoplay: false,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000)
        )
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.5,
        backgroundColor: Colors.redAccent,
        title: Text('FashApp'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white), onPressed: (){})
        ],
      ),

      drawer: new Drawer(

        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader
                (
                accountName: Text('Matt Lecache'),
                accountEmail: Text('matt@gmail.com'),

                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white)
                  )
                ),
              decoration: new BoxDecoration(
                color: Colors.redAccent
              )
            ),
//          Body

          InkWell(
            onTap: (){},
            child: ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),

            ),
          ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person),

              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket),

              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard),

              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favorites'),
                leading: Icon(Icons.favorite),

              ),
            ),

            Divider(),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.amber,),

              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.amber),

              ),
            )

          ],
        )

      ),

      body: new ListView(
        children: <Widget>[
          image_carousel,
          // padding widget
          new Padding(padding: const EdgeInsets.all(20.0),
          child: new Text('Categories')),

          // horizontal list view
          HorizontalList(),

          // padding widget
          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text('Recent Products'),
          ),

          // grid view
          Container(
            height: 320,
            child: Products(),
          )

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        selectedItemColor: Colors.amber[800],

      ),
    );
  }
}

