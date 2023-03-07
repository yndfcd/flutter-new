
import 'package:neos_post/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  NetworkInfoImpl networkInfoImpl;

  setUp(() {
    networkInfoImpl = NetworkInfoImpl();
  });

  group('isConnected', () {
    test(
      'must call the DataConnectionChecker.hasConnection function and the connection is connected to the internet (online)',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);


        // act
        final result = networkInfoImpl.isConnected;

        // assert
        expect(result, tHasConnectionFuture);
      },
    );

    test(
      'must call the DataConnectionChecker.hasConnection function and the connection is not connected to the internet (offline)',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(false);

        // act
        final result = networkInfoImpl.isConnected;

        // assert
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
