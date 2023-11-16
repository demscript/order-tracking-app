import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/presentation/utils/track_order_enum.dart';
import 'package:order_tracking/utils/app_extension.dart';
import '../../data/model/order_model.dart';
import '../../logic/fetch_order_details_vm.dart';
import '../../logic/order_states.dart';

class TrackYourOrderScreen extends ConsumerWidget {
  const TrackYourOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Order Timeline",
          style: context.textTheme.headlineLarge,
        ),
      ),
      body: Builder(
        builder: (context) {
          final orderDetailsStream = ref.watch(fetchOrderDetailsStreamVM);
          if (orderDetailsStream is OrderLoading) {
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
          }
          if (orderDetailsStream is OrderError) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                child: const Text("Sorry An Error Occurred"));
          }
          if (orderDetailsStream is OrderFetched) {
            final data = orderDetailsStream.fetchedOrder;
            return ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 10),
                buildStatusRow(
                    widgetStatus: TrackingOrderStatus.orderPlaced,
                    selectedStatus: data.statusEnum!,
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
          }

          return const Text("No Data Found");
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
                    orderModel.orderStatusTime ?? "---",
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
            widgetStatus.getString,
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
