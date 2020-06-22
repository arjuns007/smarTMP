//The original and any copies of the Licensed Programs, made by Licensee, including translations, compilations, partial copies, modifications, and updates, are the property of ARJUN SETH.
//© 2020 ARJUN SETH.All rights reserved.
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });
  void toggleFavoriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
