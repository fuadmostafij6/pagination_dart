import 'package:fetch/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductProvider productProvider = ProductProvider();
  @override
  Widget build(BuildContext context) {
    context.read<ProductProvider>().fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch data"),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<ProductProvider>(
          builder: (context, value, child) {
            return swipeRefresh(
                controller: productProvider.refreshController,
                onRefresh: productProvider.refreshPage,
                onLoading: productProvider.onLoading,
                children: [
                  value.map.isEmpty && !value.error
                      ? const Center(child: CircularProgressIndicator())
                      : value.error
                          ? Text(value.errorMessage)
                          : ListView.builder(
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: value.map["data"].length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15.0),
                                  elevation: 10,
                                  child: Text(value.map["data"][index]["name"]
                                      .toString()),
                                );
                              }),
                ]);
          },
        ),
      ),
    );
  }
}

Widget swipeRefresh(
    {required RefreshController controller,
    required VoidCallback onRefresh,
    required VoidCallback onLoading,
    required List<Widget> children}) {
  return SmartRefresher(
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      children: children,
    ),
    onRefresh: onRefresh,
    onLoading: onLoading,
    //header: AppConstant.swipeIndicator,
    header: const WaterDropMaterialHeader(backgroundColor: Colors.blue),
    enablePullDown: true,
    enablePullUp: false,
    controller: controller,
  );
}
