import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/complexModel.dart';
import '../providers/complexJsonProvider.dart';
import 'home.dart';

class FetchingComplexData extends StatefulWidget {
  const FetchingComplexData({Key? key}) : super(key: key);

  @override
  State<FetchingComplexData> createState() => _FetchingComplexDataState();
}

class _FetchingComplexDataState extends State<FetchingComplexData> {
  Complex productProvider = Complex();

  @override
  void initState() {
    productProvider.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<Complex>().fetchData();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Fetch data"),
          centerTitle: true,
        ),
        body: Consumer<Complex>(
          builder: (context, value, child) {
            return swipeRefresh(
                controller: productProvider.refreshController,
                onRefresh: productProvider.refreshPage,
                onLoading: productProvider.onLoading,
                children: [
                  value.complexModel!.data.isEmpty && !value.error
                      ? const Center(child: CircularProgressIndicator())
                      : value.error
                          ? Text(value.errorMessage)
                          : ListView.builder(
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value.complexModel!.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 15.0),
                                    elevation: 10,
                                    child: Text(value
                                        .complexModel!.data[index].id
                                        .toString()));
                              }),
                ]);
          },
        ));
  }
}
