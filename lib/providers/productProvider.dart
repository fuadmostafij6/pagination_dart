import 'dart:convert';
import 'package:fetch/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/complexModel.dart';

class ProductProvider with ChangeNotifier {
  BuildContext? context;
  ProductModel? productModel;

  Map<String, dynamic> _map = {};
  bool _error = false;

  String _errorMessage = "";
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  RefreshController refreshController = RefreshController();
  ProductProvider() {
    fetchData();
  }

  void setView(BuildContext context) => this.context = context;
  Future fetchData() async {
    final res = await get(
        Uri.parse("https://tajabajar.com/api/v2/flash-deal-products/1"));
    _map = json.decode(res.body);
    if (res.statusCode == 200) {
      try {
        productModel = ProductModel.fromJson(_map);

        _error = false;
      } catch (e) {
        _map = {};
        _error = true;
        _errorMessage = e.toString();
      }
    } else {
      _errorMessage = "May Be Internet Issue";
      _map = {};
    }
    refreshController.refreshCompleted();

    notifyListeners();
  }

  void refreshPage() {
    _error = true;
    _errorMessage = "May Be Internet Issue";
    _map = {};
    fetchData();
    notifyListeners();
  }

  void onLoading() {
    _error = true;
    _errorMessage = "May Be Internet Issue";
    _map = {};
    fetchData();
    notifyListeners();
  }

  void initialValues() {
    _map = {};
    _errorMessage = "";
    _error = false;
    notifyListeners();
  }
}
