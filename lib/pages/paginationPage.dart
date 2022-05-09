import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/paginationModel.dart';
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
  List<PaginationModel> _list = [];
  @override
  void initState() {
    productProvider.fetchData();
    _list.addAll(productProvider.list);
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        productProvider.fetchData();

        _list.addAll(productProvider.list);
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
              return _list.isEmpty && !value.error
                  ? const Center(child: CircularProgressIndicator())
                  : value.error
                      ? Text(value.errorMessage)
                      : ListView.builder(
                          controller: _controller,
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: _list.length + 1,
                          itemBuilder: (context, index) {
                            if (index < _list.length) {
                              return SizedBox(
                                  height: 100,
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    elevation: 10,
                                    child: Center(
                                      child: Text(
                                        _list[index].id.toString(),
                                      ),
                                    ),
                                  ));
                            } else {
                              return Center(
                                child: index > _list.length
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
