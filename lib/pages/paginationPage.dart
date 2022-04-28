import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/paginationProvider.dart';
import 'home.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({Key? key}) : super(key: key);

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  PaginationProvider productProvider = PaginationProvider();
  final _controller = ScrollController();
  @override
  void initState() {
    productProvider.fetchData();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        productProvider.fetchData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PaginationProvider>().fetchData();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Pagination"),
        ),
        body: Center(
          child: Consumer<PaginationProvider>(
            builder: (context, value, child) {
              return value.list.isEmpty && !value.error
                  ? const Center(child: CircularProgressIndicator())
                  : value.error
                      ? Text(value.errorMessage)
                      : ListView.builder(
                          controller: _controller,
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: value.list.length + 1,
                          itemBuilder: (context, index) {
                            if (index < value.list.length) {
                              return SizedBox(
                                height: 100,
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15.0),
                                  elevation: 10,
                                  child: Center(
                                    child: Text(
                                        value.list[index]["author"].toString()),
                                  ),
                                ),
                              );
                            } else {
                              print(productProvider.hasMore);
                              return Center(
                                child: productProvider.hasMore
                                    ? const CircularProgressIndicator()
                                    : const Text("No More Data"),
                              );
                            }
                          });
            },
          ),
        ));
  }
}
