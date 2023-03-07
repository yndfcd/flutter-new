import 'package:neos_post/core/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'make sure that the props of NoParams is []',
    () async {
      // assert
      expect(NoParams().props, []);
    },
  );
}
