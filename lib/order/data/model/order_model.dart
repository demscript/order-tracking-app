import '../../presentation/utils/track_order_enum.dart';

class OrderModel {
  String? orderId;
  String? orderDate;
  String? orderItem;
  String? orderQuantity;
  String? orderPrice;
  String? orderStatus;
  String? orderImage;
  String? orderStatusTime;
  TrackingOrderStatus? get statusEnum =>
      getTrackingOrderStatusFromString(orderStatus ?? "");

  OrderModel({
    this.orderId,
    this.orderDate,
    this.orderItem,
    this.orderQuantity,
    this.orderPrice,
    this.orderStatus,
    this.orderImage,
    this.orderStatusTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json["order_id"],
      orderDate: json["order_date"],
      orderItem: json["order_item"],
      orderQuantity: json["order_quantity"],
      orderPrice: json["order_price"],
      orderStatus: json["order_status"],
      orderImage: json["order_image"],
      orderStatusTime: json["order_status_time"]);

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_date": orderDate,
        "order_item": orderItem,
        "order_quantity": orderQuantity,
        "order_price": orderPrice,
        "order_status": orderStatus,
        "order_image": orderImage,
        "order_status_time": orderStatusTime
      };
}
