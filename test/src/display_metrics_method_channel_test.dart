import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:display_metrics/src/display_metrics_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelDisplayMetrics();
  const channel = MethodChannel('display_metrics');

  setUp(
    () {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getResolution') {
            return {'width': 480, 'height': 640};
          } else if (methodCall.method == 'getSize') {
            return {'width': 3, 'height': 4};
          }
          return null;
        },
      );
    },
  );

  tearDown(
    () {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    },
  );

  test('getResolution', () async {
    expect(await platform.getResolution(), const Size(480, 640));
  });

  test(
    'getSize',
    () async {
      expect(await platform.getSize(), const Size(3, 4));
    },
  );
}
