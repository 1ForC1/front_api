import 'package:dio/dio.dart';
import 'locatore_service.dart';

class AuthInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final accessToken = locator.get<AuthCubit>().state.whenOrNull(
    //       success: (userEntity) => userEntity.accessToken,
    //     );

    // if (accessToken == null) {
    //   super.onRequest(options, handler);
    // } else {
    //   final headers = options.headers;
    //   headers['Authourization'] = 'Bearer $accessToken';
    //   super.onRequest(options.copyWith(headers: headers), handler);
    // }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
