import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaginationProvider with ChangeNotifier {
  BuildContext? context;

  List _list = [];
  bool _error = false;
  bool _hasMore = true;
  String _errorMessage = "";
  List get list => _list;
  bool get error => _error;
  int page = 1;
  String get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  RefreshController refreshController = RefreshController();
  PaginationProvider() {
    fetchData();
  }

  void setView(BuildContext context) => this.context = context;
  Future fetchData() async {
    const limit = 10;
    final res = await get(
      Uri.parse("https://picsum.photos/v2/list?page=$page&limit=$limit"),
    );
    if (res.statusCode == 200) {
      try {
        final List newList = jsonDecode(res.body);
        _list.addAll(newList);
        _error = false;

        page++;
        if (newList.length < limit) {
          _hasMore = false;
        }
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
