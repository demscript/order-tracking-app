import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/data/model/order_model.dart';

class OrderService {
  final clientOptions = ably.ClientOptions(
      key: 'zVOzHA.2ZRJmQ:G55DktnZZe9DLIh-aA10NMlzdg2DurtyzJYLLfK7H6g');

  void publishToChannel() async {
    final realtime = ably.Realtime(options: clientOptions);
    final channel = realtime.channels.get('order_channel');

    try {
      await channel.publish(data: {
        "order_id": "1235",
        "order_image":
            "https://media.istockphoto.com/id/623423666/photo/beauty-blond-model-woman-in-evening-red-dress.jpg?s=1024x1024&w=is&k=20&c=0Vs2Hd38fnp5dxRZps0XKDECw0mOMVTT_d9xhfngliI=",
        "order_date": "2023-11-21",
        "order_item": "Zara dress",
        "order_quantity": "50",
        "order_price": "50,000",
        "order_status": "ORDER PLACED"
      });
      print("Order Published");
    } catch (e) {
      print(e);
      throw e;
    }
    await realtime.close();
  }

  Stream<OrderModel> fetchOrderDetails() {
    final realtime = ably.Realtime(options: clientOptions);
    final channel = realtime.channels.get('order_channel');
    final orderDataStream = channel.subscribe().map((event) {
      if (event is ably.Message) {
        ably.Message message = event as ably.Message;
        // Check if the data is a Map<Object?, Object?>
        if (message.data is Map<Object?, Object?>) {
          Map<Object?, Object?> data = message.data as Map<Object?, Object?>;
          try {
            return OrderModel(
              orderId: data['order_id']?.toString() ?? '',
              orderDate: data['order_date']?.toString() ?? '',
              orderItem: data['order_item']?.toString() ?? '',
              orderQuantity: data['order_quantity']?.toString() ?? '0',
              orderPrice: data['order_price']?.toString() ?? '0.0',
              orderStatus: data['order_status']?.toString() ?? '',
              orderImage: data['order_image']?.toString() ?? '',
            );
          } catch (e) {
            print('Error occured: $e');
          }
        }
      }
      return OrderModel(
        orderId: '',
        orderDate: '',
        orderItem: '',
        orderQuantity: '',
        orderPrice: '',
        orderStatus: '',
        orderImage: '',
      );
    });
    return orderDataStream;
  }
}

final orderServiceProvider = Provider((ref) => OrderService());
