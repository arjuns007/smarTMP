import 'package:flutter/material.dart';
import './product.dart';
import 'package:provider/provider.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'P1',
      title: 'Bread Pakora',
      price: 40.0,
      imageUrl:
          'https://i1.wp.com/www.muhmelo.com/wp-content/uploads/2019/06/Bread-Pakora.jpg?fit=500%2C500&ssl=1',
      description: 'Try Our Exclusive and Most Selling Item: BREAD PAKORA! VEG/NONVEG: VEG',
    ),
    Product(
      id: 'P2',
      title: 'Chicken Momos',
      price: 50.0,
      imageUrl: 'http://spicyworld.in/recipeimages/chicken-momo.jpg',
      description: 'Try Our Exclusive and Most Selling Item: CHICKEN MOMOS! VEG/NONVEG: NONVEG',
    ),
    Product(
      id: 'P3',
      title: 'Bread Omlette',
      price: 40.0,
      imageUrl:
          'https://3.bp.blogspot.com/-fMORhUjs_fY/T_xoPGg_6bI/AAAAAAAARCg/52tP98WybGc/s1600/bo+s+good.jpg',
      description: 'Try Our Exclusive and Most Selling Item: BREAD OMLETTE! VEG/NONVEG: NONVEG',
    ),
    Product(
      id: 'P4',
      title: 'Oreo Shake',
      price: 60.0,
      imageUrl:
          'https://tastesbetterfromscratch.com/wp-content/uploads/2020/03/Oreo-Milkshake-10.jpg',
      description: 'Try Our Exclusive and Most Selling Item: OREO SHAKE! VEG/NONVEG: VEG',
    ),
  ];
  var _showFavoritesOnly = false;
  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((prodItem) => prodItem.isFavourite).toList();
    }
    return [..._items];
  }

  List<Product> get favoriteItems {
    //Alternative Getter*
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

   void showFavoritesOnly() {
     _showFavoritesOnly = true;
     notifyListeners(); //rebuilds the parts that are intersted
   }

   void showAll() {
     _showFavoritesOnly = false;
     notifyListeners(); //rebuilds the parts that are intersted
   }

  void addProduct() {
//    _items.add(value);
    notifyListeners();
  }
}
