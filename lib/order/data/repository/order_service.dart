import 'dart:async';
import 'dart:convert';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/data/model/order_model.dart';

class OrderService {
  ///converts the data coming from streams from one form to another
  final streamConverter = StreamTransformer<ably.Message, OrderModel>.fromHandlers(
    handleData: (message, sink) {
      final model = OrderModel.fromJson(json.decode(message.data.toString()));
      sink.add(model);
    },
  );
  static get clientOptions => ably.ClientOptions(
      clientId: "Cindy",
      key: 'zVOzHA.2ZRJmQ:G55DktnZZe9DLIh-aA10NMlzdg2DurtyzJYLLfK7H6g');
  static ably.Realtime realtime = ably.Realtime(options: clientOptions);
  final ably.RealtimeChannel orderChannel =
      realtime.channels.get('order_channel');

  void publishToChannel() async {
    try {
      Map<String, dynamic> orderData = {
        "order_id": "1235",
        "order_image":
            "https://media.istockphoto.com/id/623423666/photo/beauty-blond-model-woman-in-evening-red-dress.jpg?s=1024x1024&w=is&k=20&c=0Vs2Hd38fnp5dxRZps0XKDECw0mOMVTT_d9xhfngliI=",
        "order_date": "16th Nov. 2023",
        "order_item": "Zara dress",
        "order_quantity": "50",
        "order_price": "50,000",
        "order_status_time": "10:00AM",
        "order_status": "ORDER PLACED"
      };

      // Convert the Map data to a JSON string
      final jsonString = jsonEncode(orderData);

      // Publish the JSON string data
      await orderChannel.publish(data: jsonString);
    } catch (e) {
      throw e;
    }
  }


 Stream<OrderModel> getOrderStream() {
    return orderChannel.subscribe().transform(streamConverter);
  }
}

final orderServiceProvider = Provider((ref) => OrderService());
