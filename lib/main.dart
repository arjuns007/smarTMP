//The original and any copies of the Licensed Programs, made by Licensee, including translations, compilations, partial copies, modifications, and updates, are the property of ARJUN SETH.
//© 2020 ARJUN SETH.All rights reserved.
import 'package:flutter/material.dart';
import 'package:smartmp/Screens/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartmp/Screens/Menu.dart';
import 'package:smartmp/Screens/cart_screen.dart';
import 'package:smartmp/Screens/products_overview_screen.dart';
import 'package:smartmp/Screens/product_detail_screen.dart';
import 'package:smartmp/Widgets/Login_Form.dart';
import 'package:smartmp/Widgets/products_grid.dart';
import 'package:smartmp/Widgets/products_item.dart';
import 'package:smartmp/providers/products.dart';
import 'package:provider/provider.dart';
import 'providers/cart.dart';
import './providers/orders.dart';
import './Screens/orders_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'smarTMP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.green,
          accentColor: Colors.blue,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.green,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return ProductsOverviewScreen();
            }
            return Login();
          },
        ),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
