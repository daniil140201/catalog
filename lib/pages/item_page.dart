import 'package:catalog/models/Product.dart';
import 'package:catalog/models/cart.dart';
import 'package:catalog/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ItemPage extends StatelessWidget {
final String productId;
Future<List<Comment>> futureComments;

  ItemPage({Key key, this.productId, this.futureComments}) : super(key: key);


@override
  Widget build(BuildContext context) {

  futureComments = getComments(productId);

    final data = Provider.of<ProductDataProvider>(context).getElementByID(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title, style: GoogleFonts.marmelad(),),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Hero(
                tag: data.imgUrl,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ) ,
                ),
            ),
            Card(
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Text(data.title, style: TextStyle(fontSize: 26.0),),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text("Price ", style: TextStyle(fontSize: 24.0),),
                        Text('${data.price}' , style: TextStyle(fontSize: 24.0),),
                      ],
                    ),
                    Divider(),
                    Text(data.place),
                    Divider(),
                    Text(data.description),
                    SizedBox(
                      height: 20.0,
                    ),
                    Provider.of<CartDataProvider>(context).cartItems.containsKey(productId) ?
                        Column(
                          children: <Widget>[
                            MaterialButton(
                              color : Color(0xFFCCFF90),
                              child: Text('go to korzina'),
                                onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                ));
                                },
                            ),
                            Text('Товар уже добавлен в корзину ', style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),),
                          ],
                        )
                    : MaterialButton(
                      child: Text('Добавить в корзину'),
                      color: Theme.of(context).primaryColor ,
                      onPressed: (){
                        Provider.of<CartDataProvider>(context, listen: false)
                            .addItem(
                          productId: data.id,
                          price: data.price,
                          title: data.title,
                          imgUrl: data.imgUrl,
                        );
                      } ,
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Comment>>(
              future: futureComments,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      children : <Widget>[
                        ...snapshot.data.map((e) => Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Divider(),
                              ),
                              Container(
                                child: Text('comment id : ${e.id} \n nickname : ${e.name} \n comment : ${e.body}'),
                              )
                            ],
                          ),
                        )
                        )
                      ]
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}




Future<List<Comment>> getComments(String postId) async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/comments?postId=$postId');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return convert.jsonDecode(response.body)
    .map<Comment>((commentJson) => Comment.fromJson(commentJson))
    .toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class Comment{
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  Comment.fromJson(Map<String, dynamic> json){
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String,dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}