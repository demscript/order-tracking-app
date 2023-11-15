import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/data/repository/order_service.dart';
import 'package:order_tracking/order/logic/order_states.dart';

class PublishOrderVM extends StateNotifier<OrderStates> {
  final Ref ref;
  PublishOrderVM(this.ref) : super(OrderInitial());

  void publishOrder() {
    state = OrderLoading();
    try {
      ref.read(orderServiceProvider).publishToChannel();
      state = OrderPublished();
    } catch (e, s) {
      state = OrderError(e.toString());
    }
  }
}

final publishOrderVM = StateNotifierProvider((ref) => PublishOrderVM(ref));
