import 'dart:convert';
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
      Map<String, dynamic> orderData = {
        "order_id": "1235",
        "order_image":
            "https://media.istockphoto.com/id/623423666/photo/beauty-blond-model-woman-in-evening-red-dress.jpg?s=1024x1024&w=is&k=20&c=0Vs2Hd38fnp5dxRZps0XKDECw0mOMVTT_d9xhfngliI=",
        "order_date": "2023-11-21",
        "order_item": "Zara dress",
        "order_quantity": "50",
        "order_price": "50,000",
        "order_status": "ORDER PLACED"
      };

      // Convert the Map data to a JSON string
      final jsonString = jsonEncode(orderData);

      // Publish the JSON string data
      await channel.publish(data: jsonString);
    } catch (e) {
      throw e;
    }
    await realtime.close();
  }

  Stream<OrderModel?> fetchOrderDetails() {
    final realtime = ably.Realtime(options: clientOptions);
    final channel = realtime.channels.get('order_channel');
    final orderDataStream = channel.subscribe().map((event) {
      if (event is ably.Message) {
        ably.Message message = event as ably.Message;
        if (message.data is String) {
          try {
            Map<String, dynamic> jsonData = json.decode(message.data as String);
            return OrderModel.fromJson(jsonData);
          } catch (e) {
            // Handle JSON decoding error if necessary
            print('Error decoding JSON: $e');
          }
        }
      }
    });
    return orderDataStream;
  }
}

final orderServiceProvider = Provider((ref) => OrderService());