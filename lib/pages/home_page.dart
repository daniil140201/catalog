import 'package:catalog/models/Product.dart';
import 'package:catalog/widgets/bottom_bar.dart';
import 'package:catalog/widgets/catalog.dart';
import 'package:catalog/widgets/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String filter;

  @override
  void initState(){
    filter = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final productData = Provider.of<ProductDataProvider>(context);
    TextEditingController placer = TextEditingController();


    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 85,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft:  Radius.circular(35),
                bottomRight:  Radius.circular(35),
              )
          ),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget> [
                    ListTile(
                    title: Text('Туристичні приманки ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Купівля квитків на екскурсії',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(Icons.panorama_horizontal),
                  ),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: placer,
                        onSubmitted: (String value){
                          setState(() {
                            filter = value;
                          });
                          print(filter);
                        },
                      ),
                    )
                  ]
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 600,
                child: ListView.builder(
                  itemBuilder: (context, int index) =>
                      ChangeNotifierProvider.value(
                        // TODO value: productData.items[index],
                        value: filter == '' ? productData.items[index] : productData.items.where((element) => element.place == filter).toList()[index] ,
                        child: ItemCard(),
                      ),

                  scrollDirection: Axis.vertical,
                  itemCount: filter == '' ? productData.items.length : productData.items.where((element) => element.place == filter).toList().length,
                ) ,
              ),
              //  TODO Padding(padding: const EdgeInsets.all(10.0),
              //   child: Text('katalog kokteyley'),
              // ),
              //TODO ...productData.items.map((value) => CatalogListTile(imgUrl : value.imgUrl)).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
