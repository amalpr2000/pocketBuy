class CartModel {
  String? productId;
  String? name;
  String? imageLink;
  int? price;
  int? totalprice;
  int? quantity;
  CartModel({
   required this.productId,

   required this.price,
   required this.quantity,
   required this.name,
    required this.imageLink,
    required this.totalprice,
  });

  CartModel.fromData({required data}) {
    price = data['price'] ;
    productId = data['productId'];
    quantity = data['quantity'] as int;
    name = data['name'];
    imageLink = data['imageLink'];
    totalprice = (price ?? 0) * (quantity ?? 0);
  }

  CartModel.fromMap({required Map data}){
    price = data['price'] ;
    productId = data['productId'];
    quantity = data['quantity']as int;
    name = data['name'];
    imageLink = data['imageLink'];
    totalprice = data['totalPrice'];
  }
  Map<String,dynamic> toMap() {
    return {
    'price':price ,
    'productId':productId ,
    'quantity':quantity ,
    'name':name,
    'imageLink':imageLink ,
    'totalPrice':totalprice ,
    };
  }
}
