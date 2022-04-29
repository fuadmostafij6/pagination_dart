import 'dart:convert';
import 'package:fetch/Services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/complexModel.dart';

class Complex with ChangeNotifier {
  BuildContext? context;
  ComplexModel? complexModel;
  Map<String, dynamic> _map = {};
  bool _error = false;
  List<ComplexModel> _list = [];
  String _errorMessage = "";
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  List<ComplexModel> get list => _list;
  RefreshController refreshController = RefreshController();
  // Complex() {
  //   fetchData();
  // }

  void setView(BuildContext context) => this.context = context;
  Future fetchData() async {
    final res = await get(
      Uri.parse("https://khejuria.com/api/v2/products?page=*"),
    );
    _map = json.decode(res.body);
    if (res.statusCode == 200) {
      try {
        complexModel = ComplexModel.fromJson(_map);

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
