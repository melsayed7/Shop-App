class FavoritesModel {
   late bool status;
   Null message;
   Data? data;


  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status']??false;
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<FavouritesData> data = [];
 /* late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  void nextPageUrl;
  late String path;
  late int perPage;
  void prevPageUrl;
  late int to;
  late int total;*/

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
       json['data'].forEach((v) {
        data.add(FavouritesData.fromJson(v));
      });
    }
   /* firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];*/
  }

}

class FavouritesData {
  late int id;
  late Product product;


  FavouritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null ? Product.fromJson(json['product']) : null)!;
  }


}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
