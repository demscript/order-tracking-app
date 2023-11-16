import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/data/repository/order_service.dart';
import 'package:order_tracking/order/logic/order_states.dart';

class FetchOrderDetailsVM extends StateNotifier<OrderStates> {
  final Ref ref;

  FetchOrderDetailsVM(this.ref) : super(OrderInitial());
  OrderService get streamRep => ref.read(orderServiceProvider);
  StreamSubscription? orderSubscription;
  subscribeToOrder() {
    state = OrderLoading();
    orderSubscription = streamRep.getOrderStream().listen(
      (event) {
        state = OrderFetched(event);
      },
      onError: (e, s) {
        state = OrderError(e.toString());
      },
    );
  }

  cancelOrderSubscription() async {
    await orderSubscription?.cancel();
  }
}

final fetchOrderDetailsStreamVM =
    StateNotifierProvider<FetchOrderDetailsVM, OrderStates>(
        (ref) => FetchOrderDetailsVM(ref));
