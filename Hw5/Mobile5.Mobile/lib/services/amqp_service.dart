import 'dart:async';
import 'dart:convert';
import 'package:dart_amqp/dart_amqp.dart';

import '../models/session.dart';

typedef LogoutCallback = void Function();
typedef BroadcastCallback = void Function(String);

class AmqpService {
  final _client = Client(
    settings: ConnectionSettings(
      host: "10.17.35.158",
      port: 5672,
      authProvider: PlainAuthenticator("guest", "guest"),
    ),
  );

  StreamSubscription<AmqpMessage>? _logoutSubscription;
  StreamSubscription<AmqpMessage>? _broadcastSubscription;

  Future<void> listen({
    required Session session,
    required LogoutCallback onLogout,
    required BroadcastCallback onBroadcast,
  }) async {
    final channel = await _client.channel();

    final logoutQueue = await channel.queue(
      "logout-message-queue",
      durable: true,
    );
    await logoutQueue.bind(
      await channel.exchange(
        "Mobile5.Backend.Models:LogoutMessage",
        ExchangeType.FANOUT,
        durable: true,
      ),
      '',
    );
    final logoutConsumer = await logoutQueue.consume();
    _logoutSubscription = logoutConsumer.listen((msg) {
      final data = jsonDecode(msg.payloadAsString);
      if (data["username"] == session.username &&
          data["sessionId"] != session.sessionId) {
        onLogout();
      }
    });

    final broadcastQueue = await channel.queue(
      "broadcast-message-queue",
      durable: true,
    );
    await broadcastQueue.bind(
      await channel.exchange(
        "Mobile5.Backend.Models:BroadcastMessage",
        ExchangeType.FANOUT,
        durable: true,
      ),
      '',
    );
    final broadcastConsumer = await broadcastQueue.consume();
    _broadcastSubscription = broadcastConsumer.listen((msg) {
      final messageData =
          jsonDecode(msg.payloadAsString) as Map<String, dynamic>;
      final messageContent = messageData['message'] as Map<String, dynamic>;
      final text = messageContent['text'];
      onBroadcast(text);
    });
  }

  Future<void> close() async {
    await _logoutSubscription?.cancel();
    await _broadcastSubscription?.cancel();
    await _client.close();
  }
}
