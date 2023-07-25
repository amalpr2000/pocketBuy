class ProductModel {
  final String productImg1;
  final String productImg2;
  final String productImg3;

  final String productName;
  final String productBrand;

  final String productPrice;
  final String productDescription;

  ProductModel(
      {
        required this.productImg1,
        required this.productImg2,
        required this.productImg3,
      required this.productName,
      required this.productBrand,
      required this.productPrice,
      required this.productDescription});

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'productBrand': productBrand,
        'productPrice': productPrice,
        'productDescription': productDescription,
        'productImg1': productImg1,
        'productImg2': productImg2,
        'productImg3': productImg3,
      };
}
