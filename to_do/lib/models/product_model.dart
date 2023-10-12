class Product {
  int? id;
  String? brand;
  String? name;
  String? price;
  String? imageLink;
  String? productLink;
  String? websiteLink;
  String? description;
  double? rating;
  String? productType;
  String? createdAt;
  String? updatedAt;
  String? productApiUrl;
  String? apiFeaturedImage;
  List<ProductColors>? productColors;

  Product({
    this.id,
    this.brand,
    this.name,
    this.price,
    this.imageLink,
    this.productLink,
    this.websiteLink,
    this.description,
    this.rating,
    this.productType,
    this.createdAt,
    this.updatedAt,
    this.productApiUrl,
    this.apiFeaturedImage,
    this.productColors,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    name = json['name'];
    price = json['price'];
    imageLink = json['image_link'];
    productLink = json['product_link'];
    websiteLink = json['website_link'];
    description = json['description'];
    rating = json['rating'];
    productType = json['product_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productApiUrl = json['product_api_url'];
    apiFeaturedImage = json['api_featured_image'];
    if (json['product_colors'] != null) {
      productColors = <ProductColors>[];
      json['product_colors'].forEach((v) {
        productColors!.add(new ProductColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['brand'] = brand;
    data['name'] = name;
    data['price'] = price;
    data['image_link'] = imageLink;
    data['product_link'] = productLink;
    data['website_link'] = websiteLink;
    data['description'] = description;
    data['rating'] = rating;
    data['product_type'] = productType;
    // if (tagList != null) {
    //   data['tag_list'] = tagList!.map((v) => v.toJson()).toList();
    // }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_api_url'] = productApiUrl;
    data['api_featured_image'] = apiFeaturedImage;
    if (productColors != null) {
      data['product_colors'] = productColors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductColors {
  String? hexValue;
  String? colourName;

  ProductColors({this.hexValue, this.colourName});

  ProductColors.fromJson(Map<String, dynamic> json) {
    hexValue = json['hex_value'];
    colourName = json['colour_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hex_value'] = this.hexValue;
    data['colour_name'] = this.colourName;
    return data;
  }
}
