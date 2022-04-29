import 'dart:convert';

import 'models/complexModel.dart';
import 'package:http/http.dart';

class Services {
  List<ComplexModel> data = [];
  Future<List<ComplexModel>> getData() async {
    try {
      final res = await get(
        Uri.parse("https://khejuria.com/api/v2/products?page=*"),
      );
      if (res.statusCode == 200) {
        List<ComplexModel> data = jsonDecode(res.body);
        return data;
      } else {
        return data = [];
      }
    } catch (e) {
      return data = [];
    }
  }
}
