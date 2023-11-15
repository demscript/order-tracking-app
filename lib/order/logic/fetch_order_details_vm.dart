import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/order/data/repository/order_service.dart';
import 'package:order_tracking/order/logic/order_states.dart';

class FetchOrderDetailsVM {
  final Ref ref;

  FetchOrderDetailsVM(this.ref);

  AutoDisposeStreamProvider<OrderStates> fetchOrderDetailsStreamProvider() {
    return StreamProvider.autoDispose<OrderStates>((ref) async* {
      yield OrderLoading();
      try {
        final response = ref.read(orderServiceProvider).fetchOrderDetails();
        yield OrderFetched(response);
      } catch (e, s) {
        yield OrderError(e.toString());
      }
    });
  }
}
  final fetchOrderDetailsVM = StreamProvider((ref) {
    final streamRep = ref.watch(orderServiceProvider);

  return streamRep.fetchOrderDetails();
});
