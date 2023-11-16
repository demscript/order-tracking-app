import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/presentation/utils/track_order_enum.dart';
import 'package:order_tracking/utils/app_extension.dart';
import '../../data/model/order_model.dart';
import '../../logic/fetch_order_details_vm.dart';

class TrackYourOrderScreen extends ConsumerWidget {
  final OrderModel orderModel;
  const TrackYourOrderScreen({Key? key, required this.orderModel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetailsStream = ref.watch(fetchOrderDetailsVM);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Order Timeline",
          style: context.textTheme.headlineLarge,
        ),
      ),
      body: orderDetailsStream.when(
        data: (data) {
          return ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 10),
              buildStatusRow(
                  widgetStatus: TrackingOrderStatus.orderPlaced,
                  selectedStatus: data!.statusEnum!,
                  orderModel: data,
                  context: context),
              buildStatusRow(
                  widgetStatus: TrackingOrderStatus.orderAccepted,
                  selectedStatus: data.statusEnum!,
                  orderModel: data,
                  context: context),
              buildStatusRow(
                  widgetStatus: TrackingOrderStatus.orderPickup,
                  selectedStatus: data.statusEnum!,
                  orderModel: data,
                  context: context),
              buildStatusRow(
                  widgetStatus: TrackingOrderStatus.orderOnTheWay,
                  selectedStatus: data.statusEnum!,
                  orderModel: data,
                  context: context),
              buildStatusRow(
                  widgetStatus: TrackingOrderStatus.orderArrived,
                  selectedStatus: data.statusEnum!,
                  orderModel: data,
                  context: context),
              buildStatusRow(
                  widgetStatus: TrackingOrderStatus.orderDelivered,
                  selectedStatus: data.statusEnum!,
                  orderModel: data,
                  context: context),
            ],
          );
        },
        error: (e, s) {
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.center,
              child: const Text("Sorry An Error Occurred"));
        },
        loading: () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: CupertinoActivityIndicator(
                  color: context.themeData.shadowColor.withOpacity(0.5),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

buildStatusRow(
    {required TrackingOrderStatus widgetStatus,
    required TrackingOrderStatus selectedStatus,
    required OrderModel orderModel,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15) +
        const EdgeInsets.only(bottom: 30),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          const SizedBox(width: 10),
          Builder(builder: (context) {
            if (widgetStatus.index == selectedStatus.index) {
              return SizedBox(
                width: context.deviceHeight() / 15,
                child: FittedBox(
                  child: Text(
                    orderModel.orderDate ?? "---",
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.themeData.colorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }
            return SizedBox(
              width: context.deviceHeight() / 15,
              child: Text(
                "-- --",
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.themeData.colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
            );
          }),
          const SizedBox(width: 15),
          Builder(builder: (context) {
            if (widgetStatus.index == selectedStatus.index) {
              return Icon(
                Icons.circle,
                size: context.deviceWidth() / 30,
                color: context.primaryColor,
              );
            }
            if (widgetStatus.index < selectedStatus.index) {
              return Icon(
                Icons.circle,
                size: context.deviceWidth() / 30,
                color: context.primaryColor,
              );
            }
            return Icon(
              Icons.circle,
              size: context.deviceWidth() / 30,
              color: context.themeData.shadowColor.withOpacity(0.3),
            );
          }),
          const SizedBox(width: 15),
          Text(
            widgetStatus.getString ?? "----",
            style: context.textTheme.titleLarge?.copyWith(fontSize: 10),
          ),
        ],
      ),
      Builder(builder: (context) {
        if (widgetStatus.index == selectedStatus.index) {
          return const Icon(
            Icons.check,
            color: Colors.green,
          );
        }
        return Container();
      }),
    ]),
  );
}
