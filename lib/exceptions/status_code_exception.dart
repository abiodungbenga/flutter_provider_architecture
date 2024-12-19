import 'package:dio/dio.dart';
import 'package:functional_status_codes/functional_status_codes.dart';

class StatusCodeException{
  static dynamic handleStatusCode({
    required Response data,
    required Function(String clientErrorStatusCode)? onClientError,
    required Function(dynamic successStatusCode,)? onSuccess,
    Function(dynamic elseStatusCode, dynamic number)? onElse,
  }) {
    final code  = data.statusCode;
    return code?.maybeMapToRegisteredStatusCode(
      isClientError: (clientErrorStatusCode) {
        if (onClientError != null) {
          onClientError(clientErrorStatusCode.toString());
        }
      },
      isSuccess: (successStatusCode) {
        final registeredCode = code.toRegisteredStatusCode();
        registeredCode?.maybeMap(
          createdHttp201: (createdHttp201) {
            return createdHttp201.code;
          },
          okHttp200: (okHttp200) {
            if (onSuccess != null) {
              onSuccess(successStatusCode,);
            }
          },
          orElse: () {},
        );
      },
      orElse: (elseStatusCode, number) {
        if (onElse != null) {
          onElse(elseStatusCode, number);
        }
      },
    );
  }
}