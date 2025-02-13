import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutterapp/components/horizontal_listview.dart';
import 'package:flutterapp/components/products.dart';
import 'package:flutterapp/pages/cart.dart';

// helper files
import 'components/horizontal_listview.dart';


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
          animationDuration: Duration(milliseconds: 1000),
          dotBgColor: Colors.transparent,
        )
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.5,
        backgroundColor: Colors.redAccent,
        title: Text('FashApp'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
          })
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
              leading: Icon(Icons.home, color: Colors.redAccent,),

            ),
          ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person, color: Colors.redAccent,),

              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket, color: Colors.redAccent,),

              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(Icons.shopping_cart, color: Colors.redAccent, ),

              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favorites'),
                leading: Icon(Icons.favorite, color: Colors.redAccent,),

              ),
            ),

            Divider(),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings,),

              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help,),

              ),
            )

          ],
        )

      ),

      body: new Column(
        children: <Widget>[
          //image_carousel,
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
          Flexible(child: Products()),


        ],
      ),

    );
  }
}

