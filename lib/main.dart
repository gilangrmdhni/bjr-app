// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/app_routes.dart';
import 'package:jual_rugi_app/core/usecases/auth_usecase_impl.dart';
import 'package:jual_rugi_app/data/api/auth_api.dart';
import 'package:jual_rugi_app/data/repositories/auth_repository_impl.dart';
import 'package:jual_rugi_app/presentation/controllers/auth_controller.dart';
import 'package:jual_rugi_app/presentation/controllers/store_controller.dart';
import 'package:jual_rugi_app/presentation/views/auth/login_view.dart';
import 'package:jual_rugi_app/presentation/views/auth/otp_verification_view.dart';
import 'package:jual_rugi_app/presentation/views/auth/register_view.dart';
import 'package:jual_rugi_app/presentation/views/create_product.dart';
import 'package:jual_rugi_app/presentation/views/home_view.dart';
import 'package:jual_rugi_app/presentation/views/notification_view.dart';
import 'package:jual_rugi_app/presentation/views/profile/main_view.dart';
import 'package:jual_rugi_app/presentation/views/store/store_main_view.dart';
import 'package:jual_rugi_app/presentation/views/store/store_name_input_view.dart';
import 'package:jual_rugi_app/presentation/views/transaction/failure_payment_view.dart';
import 'package:jual_rugi_app/presentation/views/transaction/success_payment_view.dart';
import 'package:jual_rugi_app/presentation/views/transaction/transaksi_view.dart';
import 'package:jual_rugi_app/presentation/views/utils/dynamic_link_handler.dart';
import 'package:jual_rugi_app/presentation/views/utils/navigation_controller.dart';
import 'package:jual_rugi_app/presentation/views/widgets/compare_view.dart';
import 'package:jual_rugi_app/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:jual_rugi_app/presentation/views/wishlist_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());
  final StoreController storeController = Get.put(StoreController());
  final AuthController authController = Get.put(
    AuthController(
      authUseCase: AuthUseCaseImpl(
        authRepository: AuthRepositoryImpl(
          authRemoteDataSource: AuthApi(),
        ),
      ),
    ),
  );
  final DynamicLinkHandler dynamicLinkHandler = DynamicLinkHandler();

  @override
  Widget build(BuildContext context) {
    dynamicLinkHandler.initDynamicLinks();
    return GetMaterialApp(
      title: 'Jual Rugi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.home,
      getPages: [
        GetPage(name: AppRoutes.login, page: () => LoginView()),
        GetPage(name: AppRoutes.register, page: () => RegisterView()),
        GetPage(
            name: AppRoutes.otpVerification, page: () => OtpVerificationView()),
        GetPage(name: AppRoutes.home, page: () => HomeView()),
        GetPage(name: AppRoutes.wishlist, page: () => WishlistView()),
        GetPage(name: AppRoutes.profile, page: () => MainView()),
        GetPage(name: AppRoutes.transaksi, page: () => TransaksiView()),
        GetPage(
            name: AppRoutes.successPayment, page: () => SuccessPaymentView()),
        GetPage(
            name: AppRoutes.failurePayment, page: () => FailurePaymentView()),
        GetPage(name: AppRoutes.notification, page: () => NotificationView()),

        // store -------------------------------------------------------------
        GetPage(
            name: AppRoutes.storeNameInput, page: () => StoreNameInputView()),
        GetPage(name: AppRoutes.StoreView, page: () => StoreView()),
        GetPage(name: AppRoutes.createProduct, page: () => CreateProductView()),
        // product details
        GetPage(name: AppRoutes.comparePage, page: () => ComparePage()),
      ],
      home: Scaffold(
        body: Obx(() => navigationController
            .buildScreen(navigationController.selectedIndex.value)),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
