import 'package:get/get.dart';
import 'package:jual_rugi_app/core/domain/model/store_model.dart';
import 'package:jual_rugi_app/data/repositories/store_repository.dart';

class StoreController extends GetxController {
  final StoreRepository _storeRepository = StoreRepository();
  Rx<Store?> storeResult = Rx<Store?>(null);

  Future<void> registerStore(String name, String location) async {
    try {
      final Store? result =
          await _storeRepository.registerStore(name, location);

      if (result != null) {
        storeResult.value = result;
        Get.snackbar('Sukses', 'Toko berhasil didaftarkan');
      } else {
        Get.snackbar('Error', 'Gagal mendaftarkan toko');
      }
    } catch (error) {
      print('Error in StoreController: $error');
      Get.snackbar('Error', 'Terjadi kesalahan: $error');
    }
  }

  Future<void> fetchStoreProfile(int userId) async {
    try {
      final Store? profile = await _storeRepository.getStoreProfile(userId);

      if (profile != null) {
        // Display store name, email, and location
        print('Store Name: ${profile.name}');
        print('Location: ${profile.address}'); // Assuming address field contains location information
        
        // Update storeResult to trigger UI update
        storeResult.value = profile;
      } else {
        Get.snackbar('Error', 'Profil toko tidak ditemukan');
      }
    } catch (error) {
      print('Error fetching store profile: $error');
      Get.snackbar('Error', 'Terjadi kesalahan: $error');
    }
  }
}
