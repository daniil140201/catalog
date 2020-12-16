import 'package:flutter/material.dart';

class CatalogListTile extends StatelessWidget {
  final imgUrl;

  const CatalogListTile({Key key, this.imgUrl}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Na str kataloga
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text('Летний освежающий набор'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('09:00 - 00:00'),
              Row(
                children: <Widget>[
                  Icon(Icons.star, size: 15, color: Colors.amberAccent,),
                  Text('4.9'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
