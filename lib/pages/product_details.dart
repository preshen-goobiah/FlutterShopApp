import 'package:flutter/material.dart';
import 'package:flutterapp/home.dart';
import 'package:flutterapp/main.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  ProductDetails(
      {
        this.product_detail_name,
        this.product_detail_new_price,
        this.product_detail_old_price,
        this.product_detail_picture,
      });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.5,
          backgroundColor: Colors.redAccent,
          title: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=> new HomePage()));},
              child: Text('FashApp')),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){}),
            new IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white), onPressed: (){})
          ],
        ),

      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white70,
                child: Image.asset(widget.product_detail_picture)
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text("${widget.product_detail_name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("\$${widget.product_detail_old_price}",
                        style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),)
                      ),
                      Expanded(
                          child: new Text("\$${widget.product_detail_old_price}",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)
                      ),

                      )
                      ,

                    ],
                  )
                )
              ),
            )
          ),

          // the first buttons
          Row(
            children: <Widget>[
              // the size button
              Expanded(
                child: MaterialButton(
                    onPressed: (){
                      showDialog(context: context,
                      builder: (context){
                        return new AlertDialog(
                          title: new Text("Size"),
                          content: new Text("Choose the size"),
                          actions: <Widget>[
                            new MaterialButton(onPressed: (){
                              Navigator.of(context).pop(context);
                            },
                            child: new Text("close"))
                          ]
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text("Size")
                    ),
                    Expanded(
                        child: new Icon(Icons.arrow_drop_down)
                    ),
                  ]
                ))
              ),
              Expanded(
                  child: MaterialButton(onPressed: ()
                      {
                        showDialog(context: context,
                            builder: (context){
                              return new AlertDialog(
                                  title: new Text("Color"),
                                  content: new Text("Choose the color"),
                                  actions: <Widget>[
                                    new MaterialButton(onPressed: (){
                                      Navigator.of(context).pop(context);
                                    },
                                        child: new Text("close"))
                                  ]
                              );
                            });

                      },
                      color: Colors.white,
                      textColor: Colors.grey,
                      child: Row(
                          children: <Widget>[
                            Expanded(
                                child: new Text("Color")
                            ),
                            Expanded(
                                child: new Icon(Icons.arrow_drop_down)
                            ),
                          ]
                      ))
              ),
              Expanded(
                  child: MaterialButton(onPressed: (){

                    showDialog(
                        context: context,
                        builder: (context){
                          return new AlertDialog(
                              title: new Text("Quantity"),
                              content: new Text("Choose the Quantity"),
                              actions: <Widget>[
                                new MaterialButton(onPressed: (){
                                  Navigator.of(context).pop(context);
                                },
                                    child: new Text("close"))
                              ]
                          );
                        }
                    );
                  },
                      color: Colors.white,
                      textColor: Colors.grey,
                      child: Row(
                          children: <Widget>[
                            Expanded(
                                child: new Text("Qty")
                            ),
                            Expanded(
                                child: new Icon(Icons.arrow_drop_down)
                            ),
                          ]
                      )
                  )
              ),
            ],
          ),


          // =======the second buttons==========
          Row(
            children: <Widget>[
              // the size button
              Expanded(
                  child: MaterialButton(onPressed: (){},
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      elevation: 0.2,
                      child: new Text("Buy Now"))
              ),
              new IconButton(icon: Icon(Icons.add_shopping_cart), color: Colors.redAccent,onPressed: (){}),
              new IconButton(icon: Icon(Icons.favorite_border), color: Colors.redAccent, onPressed: (){})


            ],
          ),
          Divider(),
          new ListTile(
            title: new Text("Product Details"),
            subtitle: new Text("Lorem Ipsum is simply dummy text of the printing "
                "and typesetting industry. Lorem Ipsum has been the industry's "
                "standard dummy text ever since the 1500s, when an unknown printer took a galley of type "
                "and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
              child: new Text("Product name", style: TextStyle(color: Colors.grey))),
              Padding(padding: EdgeInsets.all(5),
              child: new Text(widget.product_detail_name),)
            ],
          ),
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                  child: new Text("Product brand", style: TextStyle(color: Colors.grey))),
              Padding(padding: EdgeInsets.all(5),
                child: new Text("?"),)
            ],
          ),
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                  child: new Text("Product condition", style: TextStyle(color: Colors.grey))),
              Padding(padding: EdgeInsets.all(5),
                child: new Text("?"),)
            ],
          )
        ],
      )
    );
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {


  // ignore: non_constant_identifier_names
  List product_list = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'old_price': 120,
      'price': 85,
    },
    {
      'name': 'Dress',
      'picture': 'images/products/dress1.jpeg',
      'old_price': 100,
      'price': 55,
    },
    {
      'name': 'Heels',
      'picture': 'images/products/hills1.jpeg',
      'old_price': 100,
      'price': 55,
    },
    {
      'name': 'Skirt',
      'picture': 'images/products/skt1.jpeg',
      'old_price': 100,
      'price': 55,
    },
    {
      'name': 'Pants',
      'picture': 'images/products/pants1.jpeg',
      'old_price': 100,
      'price': 55,
    },
    {
      'name': 'Blazer - 2',
      'picture': 'images/products/blazer2.jpeg',
      'old_price': 100,
      'price': 55,
    },


  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index){
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

