import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/logic/publish_order_vm.dart';
import 'package:order_tracking/utils/app_extension.dart';
import 'package:order_tracking/utils/app_routes.dart';
import '../../logic/fetch_order_details_vm.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(publishOrderVM.notifier).publishOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Container(),
        centerTitle: true,
        title: Text(
          "Order Detail",
          style: context.textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.primaryColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Your order was successful",
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Track your order",
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.trackOrderScreen),
                          child: const Icon(Icons.keyboard_arrow_down_rounded))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Builder(builder: (context) {
              final orderDetailsStream = ref.watch(fetchOrderDetailsVM);

              return orderDetailsStream.when(data: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //data['orderId']
                      "Order ID:${data.orderId} ",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Order Date: ${data.orderDate}",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 26),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (data.orderImage.isNotEmpty)
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          NetworkImage(data.orderImage),
                                    ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.orderItem,
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Qty: ${data.orderQuantity}",
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "₦${data.orderQuantity}",
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(data.orderStatus,
                                          style: context.textTheme.displayMedium
                                              ?.copyWith(
                                            fontSize: 12,
                                            // color: statusColor(
                                            //     e.status ??
                                            //         "")),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }, error: (e, s) {
                print(e);
                print(s);
                return const Text("Sorry An Error Occurred");
              }, loading: () {
                return SizedBox(
                    height: 25,
                    width: 15,
                    child: CupertinoActivityIndicator(
                      color: context.themeData.shadowColor.withOpacity(0.5),
                    ));
              });
            }),
          ],
        ),
      ),
    );
  }
}
