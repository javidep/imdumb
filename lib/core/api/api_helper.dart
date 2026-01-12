import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imdumb/core/api/interceptor.dart';
import 'package:imdumb/core/error/errors.dart';

class ApiBaseHelper {
  Dio dio = Dio();
  final performanceInterceptor = DioFirebasePerformanceInterceptor();

  ApiBaseHelper() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      responseType: ResponseType.json,
      //connectTimeout: const Duration(), // 10 seconds
    );
    dio = Dio(options);
  }

  Future<dynamic> get(String? url) async {
    dynamic responseJson;
    try {
      dio.interceptors.add(performanceInterceptor);
      final Response response = await dio.get(url!);
      responseJson = _returnResponse(response);
    } on DioException catch (error) {
      print('DioError status get-> ${error.response}');
      if (error.type == DioExceptionType.badResponse) {
        throw BadRequestException(error.response?.data['code']);
      }
      if (error.type == DioExceptionType.connectionTimeout) {
        throw FetchDataException('Comprueba la conexión a Internet');
      }
      if (error.type == DioExceptionType.receiveTimeout) {
        throw FetchDataException('Comprueba la conexión a Internet');
      }
      if (error.error is SocketException) {
        throw const SocketException('Comprueba la conexión a Internet');
      }
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 201:
        var responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException('el servidor no pudo interpretar la solicitud dada una sintaxis inválida');
      case 401:
        throw UnauthorisedException('Es necesario autenticar para obtener la respuesta solicitada.');
      case 403:
        throw UnauthorisedException('El cliente no posee los permisos necesarios para cierto contenido, por lo que el servidor está rechazando otorgar una respuesta apropiada');
      case 404:
        throw UnauthorisedException('El servidor no pudo encontrar el contenido solicitado');
      case 500:

      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}
