import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/constantes/local_storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthIterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = 'Autorization';
    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sp = await SharedPreferences.getInstance();
      headers.addAll({
        authHeaderKey:
            'Barear ${sp.getString(LocalStorageConstants.acesssToken)}'
      });
    }
    handler.next(options);
  }
}
