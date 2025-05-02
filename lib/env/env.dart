import 'package:envied/envied.dart';

import '../src/core/util/api_service_constants.dart';

part 'env.g.dart';

@Envied(path: 'assets/env/.env')
abstract class Env {
  @EnviedField(varName: ApiServiceConstants.apiKey, obfuscate: true)
  static final String movieApiKey = _Env.movieApiKey;
}
