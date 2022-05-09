import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.data,
    this.success,
    this.status,
  });

  List<Datum>? data;
  bool? success;
  int? status;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.thumbnailImage,
    this.hasDiscount,
    this.strokedPrice,
    this.maxQty,
    this.mainPrice,
    this.strokedPriceWu,
    this.mainPriceWu,
    this.rating,
    this.sales,
    this.inCart,
    this.unit,
    this.quantity,
    this.links,
  });

  int? id;
  String? name;
  String? thumbnailImage;
  bool? hasDiscount;
  String? strokedPrice;
  int? maxQty;
  String? mainPrice;
  int? strokedPriceWu;
  int? mainPriceWu;
  int? sales;
  int? rating;
  int? inCart;
  String? unit;
  int? quantity;
  Links? links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        thumbnailImage: json["thumbnail_image"],
        hasDiscount: json["has_discount"],
        strokedPrice: json["stroked_price"],
        maxQty: json["max_qty"] == null ? null : json["max_qty"],
        mainPrice: json["main_price"],
        strokedPriceWu: json["stroked_price_wu"],
        mainPriceWu: json["main_price_wu"],
        rating: json["rating"],
        sales: json["sales"],
        inCart: json["in_cart"],
        unit: json["unit"],
        quantity: json["quantity"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail_image": thumbnailImage,
        "has_discount": hasDiscount,
        "stroked_price": strokedPrice,
        "max_qty": maxQty == null ? null : maxQty,
        "main_price": mainPrice,
        "stroked_price_wu": strokedPriceWu,
        "main_price_wu": mainPriceWu,
        "rating": rating,
        "sales": sales,
        "in_cart": inCart,
        "unit": unit,
        "quantity": quantity,
        "links": links!.toJson(),
      };
}

class Links {
  Links({
    this.details,
  });

  String? details;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
      };
}
