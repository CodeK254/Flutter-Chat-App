
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

main() {
  // Dart client
  IO.Socket socket = IO.io('http://localhost:4000', 
    IO.OptionBuilder()
    .setTransports(["websocket"])
    .enableAutoConnect()
    .build()
  );
  socket.connect();
  socket.onConnectError((_) {
    print('connect error');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.on('connection', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
}