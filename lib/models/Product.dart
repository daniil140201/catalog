import 'dart:collection';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String place;
  final String description;
  final num price;
  final String imgUrl;
  final color;

  Product({
    @required this.id,
    @required this.title,
    @required this.place,
    @required this.description,
    @required this.price,
    @required this.imgUrl,
    @required this.color
  });
}

class ProductDataProvider with ChangeNotifier{

  List<Product> _items = [
    Product(
      id: '1',
      title: 'Острів Хортиця',
      place: 'Запоріжжя',
      description: ' Старовінний острів козаків!',
      price: 200.00,
      imgUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/%D0%94%D0%BD%D1%96%D0%BF%D1%80%D0%BE_%D0%A5%D0%BE%D1%80%D1%82%D0%B8%D1%86%D1%8F.jpg/200px-%D0%94%D0%BD%D1%96%D0%BF%D1%80%D0%BE_%D0%A5%D0%BE%D1%80%D1%82%D0%B8%D1%86%D1%8F.jpg',
      color: '0xFFFFF59D',
    ),
    Product(
      id: '2',
      title: 'Актовський каньйон',
      place: 'Миколаїв',
      description: 'Актовський каньйон – це унікальний симбіоз водної та лісової екосистем, які в сумі дають чисте повітря і мрійливий настрій. Ансамбль скель і гранітних валунів, які розташовані на території каньйону – унікальне місце у всій Європі. Це неймовірно красиво!',
      price: 77.99,
      imgUrl: 'https://www.ukraine-is.com/wp-content/uploads/2017/01/trikraty_6.jpg',
      color: '0xFFBBDEFB',
    ),
    Product(
      id: '3',
      title: 'Водоспад Гук ',
      place: 'Карпати',
      description: ' Найбільший водоспад в Карпатах, його ще називають Женецький',
      price: 99.99,
      imgUrl: 'https://www.ukraine-is.com/wp-content/uploads/2017/01/%D0%92%D0%BE%D0%B4%D0%BE%D0%BF%D0%B0%D0%B4-%D0%96%D0%B5%D0%BD%D0%B5%D1%86%D0%BA%D0%B8%D0%B9-%D0%93%D1%83%D0%BA.jpg',
      color: '0xFFF8BBD0',
    ),
    Product(
      id: '4',
      title: 'Загадковий тунель любові',
      place: 'Клевань',
      description: ' Українська Волинь сповнена загадками не менше, ніж Карпати. У Клевані розташувався таємничий тунель кохання, де щороку беруть шлюб люблячі серця.',
      price: 35.99,
      imgUrl: 'https://www.ukraine-is.com/wp-content/uploads/2016/08/tonel.jpg',
      color: '0xFFCCFF90',
    ),
  ];

  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);

  getElementByID(String id) => _items.singleWhere((value) => value.id == id);

}