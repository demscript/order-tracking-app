import 'package:flutter/material.dart';
import 'package:order_tracking/utils/app_extension.dart';
import 'package:order_tracking/utils/app_routes.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          onTap: ()=>Navigator.pushNamed(context, AppRoutes.trackOrderScreen),
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
            Text(
              "Order ID: ",
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              "Order Date: ",
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 12,
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.red,
                            // backgroundImage: NetworkImage(
                            //     e.productImage!),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Biscuit",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Qty: 2",
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "₦500,000",
                                style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text("pending",
                                  style:
                                      context.textTheme.displayMedium?.copyWith(
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
        ),
      ),
    );
  }
}
