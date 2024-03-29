import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIService {

  var public = "http://172.20.10.2:8000";
  // var public = "https://apiservice-d5qtigtmea-as.a.run.app";
  FlutterSecureStorage storage = FlutterSecureStorage();

  Dio dio = Dio();



  PrettyDioLogger logger = PrettyDioLogger(
    request: false,
    requestHeader: false,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: false,
    compact: true,
    maxWidth: 100
  );

  BaseOptions options = new BaseOptions(
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10)
  );

  // Future checkAllUser() async{
  //   try{
  //
  //     print(public);
  //     dio.interceptors.add(logger);
  //
  //     dio.options.headers["authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbiI6ZmFsc2UsInVzZXJuYW1lIjoiRnJhbmsifQ.b2tDz1PyZBMF7IuelehsHvhmD8d2uZt2lrndTB7XMWc";
  //     Response response = await dio.get(public + "/users",);
  //
  //     if (response.statusCode == 200){
  //       return response ;
  //     }
  //
  //   } on DioError catch (e) {
  //     if (e.response != null ){
  //       print(e.message);
  //     } else {
  //       print(e.message);
  //     }
  //   }
  // }

  Future loginUser(String username, String password) async{
    try{
      // dio.interceptors.add(logger);
      Response response = await dio.post(public + "/user/login", data: {
        "username" : username,
        "password" : password
      });

      if (response.statusCode == 200){
        return(response);
      }

    } on DioError catch (e) {
      if (e.response != null ){
        print(e.message);
      } else {
        print(e.message);
      }
    }
  }

  Future registerUser(String username, String password,String firstname, String lastname) async{
    try{


      // dio.interceptors.add(logger);

      Response response = await dio.post(public + "/user/create", data: {
        "username" : username,
        "password" : password,
        "firstname": firstname,
        "lastname": lastname
      });

      if (response.statusCode == 201){
        return(response);
      }

    } on DioError catch (e) {
      if (e.response != null ){
        print(e.message);
      } else {
        print(e.message);
      }
    }
  }

  Future checkIng(String name)async{
    try{
      // dio.interceptors.add(logger);
      String? token = '';
      token = await storage.read(key: 'TOKEN');
      dio.options.headers["authorization"] = "Bearer "+ token!;

      Response response = await dio.post(public + "/ingredient/find", data: {
        "name" : name,
      });

      if (response.statusCode == 200) {
        return response;
        // print(response);
      }}
        on DioError catch (e) {
      if (e.response != null ){
        // print(e.message);
      return e.response!;
            } else {
        // print(e.message);
      }
    }
  }

  Future addCosmetic(dynamic data)async{
    try{
      // dio.interceptors.add(logger);
      String? token = '';
      token = await storage.read(key: 'TOKEN');
      dio.options.headers["authorization"] = "Bearer "+ token!;

      Response response = await dio.post(public + "/cosmetic/create", data: data);

      if (response.statusCode == 200) {
        return response;
        // print(response);
      }}
    on DioError catch (e) {
      if (e.response != null ){
        // print(e.message);
        return e.response!;
      } else {
        // print(e.message);
      }
    }
  }

  Future getAllCosmetic()async{
    try{
      // dio.interceptors.add(logger);
      String? token = '';
      token = await storage.read(key: 'token');
      dio.options.headers["authorization"] = "Bearer "+ token!;

      Response response = await dio.get(public + "/cosmetic/checkall");

      if (response.statusCode == 200) {
        return response;
        // print(response);
      }}
    on DioError catch (e) {
      if (e.response != null ){
        // print(e.message);
        return e.response!;
      } else {
        // print(e.message);
      }
    }
  }
}