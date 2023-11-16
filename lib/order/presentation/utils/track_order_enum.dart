enum TrackingOrderStatus {
  orderPlaced,
  orderAccepted,
  orderPickup,
  orderOnTheWay,
  orderArrived,
  orderDelivered
}

extension TrackingOrderStatusExtension on TrackingOrderStatus {
  String get getString {
    switch (this) {
      case TrackingOrderStatus.orderPlaced:
        return "ORDER PLACED";
      case TrackingOrderStatus.orderAccepted:
        return "ORDER ACCEPTED";
      case TrackingOrderStatus.orderPickup:
        return "ORDER PICK UP IN PROGRESS";
      case TrackingOrderStatus.orderOnTheWay:
        return "ORDER ON THE WAY TO CUSTOMER";
      case TrackingOrderStatus.orderArrived:
        return "ORDER ARRIVED";
      case TrackingOrderStatus.orderDelivered:
        return "ORDER DELIVERED";
      default:
        return "Unknown";
    }
  }

  int get getIndex {
    switch (this) {
      case TrackingOrderStatus.orderDelivered:
        return 5;
      case TrackingOrderStatus.orderArrived:
        return 4;
      case TrackingOrderStatus.orderOnTheWay:
        return 3;
      case TrackingOrderStatus.orderPickup:
        return 2;
      case TrackingOrderStatus.orderAccepted:
        return 1;
      case TrackingOrderStatus.orderPlaced:
        return 0;
    }
  }
}

TrackingOrderStatus? getTrackingOrderStatusFromString(String value) {
  switch (value) {
    case "ORDER PLACED":
      return TrackingOrderStatus.orderPlaced;
    case "ORDER ACCEPTED":
      return TrackingOrderStatus.orderAccepted;
    case "ORDER PICK UP IN PROGRESS":
      return TrackingOrderStatus.orderPickup;
    case "ORDER ON THE WAY TO CUSTOMER":
      return TrackingOrderStatus.orderOnTheWay;
    case "ORDER ARRIVED":
      return TrackingOrderStatus.orderArrived;
    case "ORDER DELIVERED":
      return TrackingOrderStatus.orderDelivered;
    default:
      return null;
  }
}
