import 'package:flutter/material.dart';
import 'package:order_tracking/order/data/model/order_model.dart';
import 'package:order_tracking/utils/app_extension.dart';

import '../utils/track_order_enum.dart';

class OrderStatusTrackSlide extends StatelessWidget {
  final OrderModel data;
  const OrderStatusTrackSlide({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildStatusTrack(
            widgetStatus: TrackingOrderStatus.orderPlaced,
            selectedStatus: data.statusEnum),
        buildStatusTrack(
            widgetStatus: TrackingOrderStatus.orderAccepted,
            selectedStatus: data.statusEnum),
        buildStatusTrack(
            widgetStatus: TrackingOrderStatus.orderPickup,
            selectedStatus: data.statusEnum),
        buildStatusTrack(
            widgetStatus: TrackingOrderStatus.orderOnTheWay,
            selectedStatus: data.statusEnum),
        buildStatusTrack(
            widgetStatus: TrackingOrderStatus.orderArrived,
            selectedStatus: data.statusEnum),
        buildStatusTrack(
            widgetStatus: TrackingOrderStatus.orderDelivered,
            selectedStatus: data.statusEnum),
      ],
    );
  }
}

buildStatusTrack({
  required TrackingOrderStatus widgetStatus,
  required TrackingOrderStatus? selectedStatus,
}) {
  return Builder(builder: (context) {
    if (widgetStatus.index == selectedStatus?.index ||
        widgetStatus.index <= selectedStatus!.index) {
      return Flexible(
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: context.themeData.cardColor,
              borderRadius: BorderRadius.circular(20)),
          width: 50,
          height: 5,
        ),
      );
    }
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: context.themeData.shadowColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)),
        width: 50,
        height: 5,
      ),
    );
  });
}
