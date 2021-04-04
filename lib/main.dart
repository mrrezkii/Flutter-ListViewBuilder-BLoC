import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listviewbuilder_bloc/product_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          BlocProvider(create: (context) => ProductBloc([]), child: MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    ProductBloc bloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF44336),
        title: Text("Demo ListView Builder"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
              color: Color(0xffF44336),
              child: Text(
                "Create Product",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                bloc.add(random.nextInt(4) + 2);
              }),
          SizedBox(height: 20),
          BlocBuilder<ProductBloc, List<Product>>(
            builder: (context, products) => Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      (index == 0)
                          ? SizedBox(
                              width: 20,
                            )
                          : Container(),
                      ProductCard(
                        imageUrl: products[index].imageURL,
                        name: products[index].name,
                        price: products[index].price.toString(),
                        onAddCartTap: () {},
                        onIncTap: () {},
                        onDecTap: () {},
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Product {
  String imageURL;
  String name;
  int price;

  Product({this.imageURL = "", this.name = "", this.price = 0});
}

class ProductBloc extends Bloc<int, List<Product>> {
  ProductBloc(List<Product> initialState) : super(initialState);

  @override
  Stream<List<Product>> mapEventToState(int event) async* {
    List<Product> products = [];
    for (int i = 0; i < event; i++) {
      products.add(Product(
          imageURL:
              "https://cdna.artstation.com/p/assets/images/images/018/441/380/large/arden-galdones-brianna-filo-commission-low-res.jpg",
          name: "Produk " + i.toString(),
          price: (i + 1) * 5000));
    }
    yield products;
  }
}
