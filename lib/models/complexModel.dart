// To parse this JSON data, do
//
//     final complexModel = complexModelFromJson(jsonString);

import 'dart:convert';

ComplexModel complexModelFromJson(String str) =>
    ComplexModel.fromJson(json.decode(str));

String complexModelToJson(ComplexModel data) => json.encode(data.toJson());

class ComplexModel {
  ComplexModel({
    required this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  List<Datum> data;
  ComplexModelLinks? links;
  Meta? meta;
  bool? success;
  int? status;

  factory ComplexModel.fromJson(Map<String, dynamic> json) => ComplexModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: ComplexModelLinks.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
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
    this.mainPrice,
    this.rating,
    this.sales,
    this.links,
  });

  int? id;
  String? name;
  String? thumbnailImage;
  bool? hasDiscount;
  String? strokedPrice;
  String? mainPrice;
  int? rating;
  int? sales;
  DatumLinks? links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        thumbnailImage: json["thumbnail_image"],
        hasDiscount: json["has_discount"],
        strokedPrice: json["stroked_price"],
        mainPrice: json["main_price"],
        rating: json["rating"],
        sales: json["sales"],
        links: DatumLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail_image": thumbnailImage,
        "has_discount": hasDiscount,
        "stroked_price": strokedPrice,
        "main_price": mainPrice,
        "rating": rating,
        "sales": sales,
        "links": links!.toJson(),
      };
}

class DatumLinks {
  DatumLinks({
    this.details,
  });

  String? details;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
      };
}

class ComplexModelLinks {
  ComplexModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  String? next;

  factory ComplexModelLinks.fromJson(Map<String, dynamic> json) =>
      ComplexModelLinks(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
