import '../../models/photo_model.dart';
import '../../utils/custom_exception.dart';
import '../data/photo_repos.dart';

class MainController {
  MainController({
    required this.photoRepository,
  });

  final PhotoRepository photoRepository;
  PhotoModel? photoModel;

  Future<PhotoModel?> getPhoto(
      {required String title, required String page}) async {
    try {
      photoModel = await photoRepository.getData(page: page, title: title);
    } on UnknownException catch (error, stackTrace) {
      print('Unknown Exception: $error');
      print('Stack Trace: $stackTrace');
    } on ClientException catch (error, stackTrace) {
      print('Client Exception: $error');
      print('Stack Trace: $stackTrace');
    } on ServerException catch (error, stackTrace) {
      print('Server Exception: $error');
      print('Stack Trace: $stackTrace');
    } on Object catch (error, stackTrace) {
      print('General Exception: $error');
      print('Stack Trace: $stackTrace');
    }
    return photoModel;
  }
}
