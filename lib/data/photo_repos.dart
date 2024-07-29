import 'dart:convert';

import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../constants/config.dart';
import '../../models/photo_model.dart';
import '../../services/wrapper/i_service.dart';

abstract interface class IPhotoRepository {
  abstract final PhotoServiceWrapper wrapper;

  Future<PhotoModel> getData({required String title, required String page});
}

class PhotoRepository implements IPhotoRepository {
  PhotoRepository() : wrapper = PhotoServiceWrapper(dio: _dio);

  static final _dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  final PhotoServiceWrapper wrapper;

  @override
  Future<PhotoModel> getData(
      {required String title, required String page}) async {
    String response = await wrapper.request(
      ApiCons.photoPath(),
      queryParameters: ApiCons.photoParams(
        page: page,
        query: title,
      ),
      headers: {
        'Authorization':
            'Client-ID ojNI4f10LVhCQvcQLHcQaIB-vMmr32ZSGeK7F2NR_Ew',
        'Content-Type': 'application/json',
      },
    );

    return PhotoModel.fromJson(jsonDecode(response));
  }
}
