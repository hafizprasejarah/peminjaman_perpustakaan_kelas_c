
import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelas_c/app/data/model/response_book.dart';
import 'package:dio/dio.dart' as dio;
import '../../../data/constant/endpoint.dart';
import '../../../data/provider/ api_provider.dart';
class BookController extends GetxController with  StateMixin<List<DataBook>>{
  //TODO: Implement BookController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();

  }

  @override
  void onClose() {
    super.onClose();
  }
  getData() async {
    change(null,status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.book);
      if (response.statusCode == 200) {
        final ResponseBook responsebook = ResponseBook.fromJson(response.data);
        if(responsebook.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          change(responsebook.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null)

          change(null, status: RxStatus.error("${e.response?.data['message']}"));
      } else {

        change(null, status: RxStatus.error(e.message ?? ""));

      }
    } catch (e) {

      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
