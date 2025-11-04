import 'dart:io';

import 'package:dio/dio.dart';

import '../network/datastate.dart';
import 'package:retrofit/retrofit.dart';

Future<DataState<T>> getCheckedResponse<T>(Future<HttpResponse<T>> Function() func) async {
  try {
    final HttpResponse<T> response = await func();

    if (response.response.statusCode == 200 || response.response.statusCode == 201) {
      return DataSuccess(response.data);
    } else {
      final DioException e = errorHandler(
        DioException(
          requestOptions: response.response.requestOptions,
          response: response.response,
          error: response.response.data,
        ),
      );
      return DataError(e);
    }
  } on DioException catch (e) {
    return DataError(errorHandler(e));
  } catch (e) {
    return DataError(
      DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: ''),
      ),
    );
  }
}

DioException errorHandler(DioException e) {
  final requestOptions = e.requestOptions;

  if (e.error is SocketException) {
    return DioException(error: 'No Internet connection', requestOptions: requestOptions);
  }
  if (e.error is HttpException) {
    return DioException(error: 'HTTP error', requestOptions: requestOptions);
  }
  if (e.error is FormatException) {
    return DioException(error: 'Invalid response format', requestOptions: requestOptions);
  }

  if (e.response?.statusCode == 401) {
    return DioException(error: 'Unauthorized', requestOptions: requestOptions);
  }

  if (e.type == DioExceptionType.connectionTimeout) {
    return DioException(error: 'Connection timeout', requestOptions: requestOptions);
  }

  if (e.response?.statusCode == null) {
    return DioException(error: e.message, requestOptions: requestOptions);
  }

  return DioException(error: 'Error occurred', requestOptions: requestOptions);
}
