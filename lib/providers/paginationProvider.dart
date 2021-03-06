import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/paginationModel.dart';

class PaginationProvider with ChangeNotifier {
  BuildContext? context;
  PaginationModel? paginationModel;
  List<PaginationModel> _list = [];
  bool _error = false;

  bool _hasMore = true;
  String _errorMessage = "";
  List<PaginationModel> get list => _list;
  bool get error => _error;
  int page = 1;
  String get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  RefreshController refreshController = RefreshController();
  PaginationProvider() {
    fetchData();
  }

  void setView(BuildContext context) => this.context = context;
  setHasMore(bool data) {
    _hasMore = data;
    notifyListeners();
  }

  Future fetchData() async {
    const limit = 10;
    final res = await get(
      Uri.parse("https://picsum.photos/v2/list?page=$page&limit=$limit"),
    );

    if (res.statusCode == 200) {
      try {
        // _map = json.decode(res.body);
        var data = jsonDecode(res.body);
        // paginationModel = PaginationModel.fromJson(_map);

        List<PaginationModel> newList = [];
        data.forEach((element) {
          PaginationModel newData =
              PaginationModel(id: element["id"], author: element["author"]);
          newList.add(newData);
        });
        _list.addAll(newList);
        _error = false;

        page++;
      } catch (e) {
        _list = [];
        _error = true;
        _errorMessage = e.toString();
      }
    } else {
      _errorMessage = "May Be Internet Issue";
      _list = [];
    }
    refreshController.refreshCompleted();

    notifyListeners();
  }

  void refreshPage() {
    _error = true;
    _errorMessage = "May Be Internet Issue";
    _list = [];
    fetchData();
    notifyListeners();
  }

  void onLoading() {
    _error = true;
    _errorMessage = "May Be Internet Issue";
    _list = [];
    fetchData();
    notifyListeners();
  }

  void initialValues() {
    _list = [];
    _errorMessage = "";
    _error = false;
    notifyListeners();
  }
}
