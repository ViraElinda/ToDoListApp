import 'package:logging/logging.dart';

final log = Logger('AppLogger');

void initializeLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log.info('${record.level.name}: ${record.time}: ${record.message}');
  });
  log.info('Log initialized');
}
