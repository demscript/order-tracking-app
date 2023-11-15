import 'package:flutter/material.dart';
import 'package:order_tracking/utils/app_extension.dart';

class TrackYourOrderScreen extends StatelessWidget {
  const TrackYourOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Timeline",
          style: context.textTheme.headlineLarge,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Builder(builder: (context) {
                    // if (widgetStatus.index == selectedStatus.index) {
                    return SizedBox(
                      //  width: context.deviceHeight() / 25,
                      child: Text(
                        "5th January 2023",
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: context.themeData.colorScheme.secondary,
                          fontSize: 12,
                        ),
                      ),
                    );
                    // }
                    // return SizedBox(
                    //   width: context.deviceHeight()/25,
                    //   child: Text(
                    //     "-- --",
                    //     style: context.textTheme.titleLarge?.copyWith(color: Colors.white.withOpacity(0.5), fontSize: context.deviceWidth()/34),
                    //   ),
                    // );
                  }),
                  const SizedBox(width: 25),
                  Builder(builder: (context) {
                    //    if (widgetStatus.index == selectedStatus.index) {
                    return Icon(
                      Icons.circle,
                      size: context.deviceWidth() / 30,
                      color: context.primaryColor,
                    );
                    //}
                    // if (widgetStatus.index > selectedStatus.index) {
                    //    return  Icon(
                    //      Icons.circle,
                    //      size: context.deviceWidth()/30,
                    //      color: Colors.white,
                    //    );
                    //}
                    // return Icon(
                    //   Icons.circle,
                    //   size:context.deviceWidth()/30,
                    //   color: context.themeData.cardColor.withOpacity(0.3),
                    // );
                  }),
                  const SizedBox(width: 15),
                  Text(
                    "ORDER PLACED",
                    style: context.textTheme.titleLarge?.copyWith(fontSize: 10),
                  ),
                ],
              ),
              Builder(builder: (context) {
                return Text(
                  "10:24 AM",
                  style: context.textTheme.titleLarge?.copyWith(fontSize: 9),
                );
                // return Text(
                //   "-- --",
                //   textAlign: TextAlign.center,
                //   style: context.textTheme.titleLarge?.copyWith(color: Colors.white.withOpacity(0.5), fontSize: 9),
                // );
              }),
            ]),
          ),
        ],
      ),
    );
  }
}
