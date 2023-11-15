import 'package:order_tracking/order/data/model/order_model.dart';

abstract class OrderStates {}

class OrderInitial extends OrderStates {}

class OrderLoading extends OrderStates {}

class OrderPublished extends OrderStates {}

class OrderFetched extends OrderStates {
  final Stream<OrderModel> fetchedOrder;

  OrderFetched(this.fetchedOrder);
}

class OrderError extends OrderStates {
  final String error;
  OrderError(this.error);
}
