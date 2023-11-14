import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AblyServices {
  final clientOptions = ably.ClientOptions(key: 'zVOzHA.2ZRJmQ:G55DktnZZe9DLIh-aA10NMlzdg2DurtyzJYLLfK7H6g');

  connectToAbly() {
    final realtime = ably.Realtime(options: clientOptions);
    realtime.connection
        .on(ably.ConnectionEvent.connected)
        .listen((ably.ConnectionStateChange stateChange) async {
      print('New state is: ${stateChange.current}');
      switch (stateChange.current) {
        case ably.ConnectionState.connected:
          // Successful connection
          print('Connected to Ably!');
          break;
        case ably.ConnectionState.failed:
          print('Failed to Connect!');
          break;
        case ably.ConnectionState.initialized:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.connecting:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.disconnected:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.suspended:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.closing:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.closed:
          // TODO: Handle this case.
          break;
      }
    });
  }

  StreamSubscription<ably.Message> subscribeToAChannel() {
    final realtime = ably.Realtime(options: clientOptions);
    final channel = realtime.channels.get('quickstart'); // Subscribe to the channel and return the StreamSubscription
    StreamSubscription<ably.Message> streamData;
    streamData = channel.subscribe().listen((message) {
      print('Received a greeting message in realtime: ${message.data}');
    });

    return streamData;
  }
  publishAMessage() async {
    final realtime = ably.Realtime(options: clientOptions);
    final channel = realtime.channels.get('quickstart');
    await channel.publish(name: 'greeting', data: 'hello!');
  }

  closeAConnection(){
    final realtime = ably.Realtime(options: clientOptions);
    realtime.connection.close();
    realtime.connection
        .on(ably.ConnectionEvent.closed)
        .listen((ably.ConnectionStateChange stateChange) async {
      print('New state is: ${stateChange.current}');
      switch (stateChange.current) {
        case ably.ConnectionState.closed:
        // Connection closed
          print('Closed the connection to Ably.');
          break;
        case ably.ConnectionState.failed:
          print('Failed to Close!');
          break;
        case ably.ConnectionState.initialized:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.connecting:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.connected:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.disconnected:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.suspended:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.closing:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.closed:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.failed:
          // TODO: Handle this case.
          break;
      }
    });


  }

}

final ablyServicesProvider = Provider((ref) => AblyServices());


