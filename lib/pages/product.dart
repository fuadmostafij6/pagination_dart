import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/productProvider.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  ProductProvider productProvider = ProductProvider();
  @override
  void initState() {
    // TODO: implement initState
    productProvider.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.productModel!.data!.isEmpty) {
            return value.productModel!.data!.isEmpty && !value.error
                ? const Center(child: CircularProgressIndicator())
                : value.error
                    ? Text(value.errorMessage)
                    : ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.productModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                              elevation: 10,
                              child: Text(value.productModel!.data![index].name
                                  .toString()));
                        });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
