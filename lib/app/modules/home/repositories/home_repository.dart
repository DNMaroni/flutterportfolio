import 'package:portfolio/app/services/interfaces/client_http_service_interface.dart';

abstract class IHomeRepository {}

class HomeRepositoryImplementation implements IHomeRepository {
  final IClientHttp clientHttp;

  HomeRepositoryImplementation(this.clientHttp);
}
