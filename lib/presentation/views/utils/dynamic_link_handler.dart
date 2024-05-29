import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/app_routes.dart';

class DynamicLinkHandler {
  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDynamicLink(data);

    try {
      FirebaseDynamicLinks.instance.onLink.listen((pendingDynamicLinkData) {
        if (pendingDynamicLinkData != null) {
          _handleDynamicLink(pendingDynamicLinkData);
        }
      }, onError: (e) {
        print('Error listening to dynamic link: $e');
      });
    } catch (error) {
      print('Error handling dynamic link: $error');
    }
  }

  void _handleDynamicLink(PendingDynamicLinkData? data) {
    try {
      final Uri? deepLink = data?.link;
      if (deepLink != null) {
        print('Received Dynamic Link: $deepLink');

        // Cek apakah dynamic link mengandung parameter 'success'
        if (deepLink.queryParameters.containsKey('success')) {
          // Ambil nilai parameter 'success'
          bool paymentSuccess = deepLink.queryParameters['success'] == 'true';

          // Navigasi ke halaman yang sesuai berdasarkan nilai parameter 'success'
          if (paymentSuccess) {
            _navigateToSuccessPage();
          } else {
            _navigateToFailurePage();
          }
        }
      }
    } catch (error) {
      print('Error handling dynamic link: $error');
    }
  }

  void _navigateToSuccessPage() {
    // Navigasi ke halaman sukses pembayaran
    Get.offNamed(AppRoutes.successPayment);
  }

  void _navigateToFailurePage() {
    // Navigasi ke halaman gagal pembayaran
    Get.offNamed(AppRoutes.failurePayment);
  }
}
