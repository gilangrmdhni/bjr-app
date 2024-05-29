import 'package:get/get.dart';
import 'package:jual_rugi_app/core/domain/model/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Tambahkan data dummy saat controller diinisialisasi
    addDummyData();
  }

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
  }

  // Method untuk menambahkan data dummy
  void addDummyData() {
    addNotification(NotificationModel(
      name: 'Pembayaran',
      title: 'Pembayaran Berhasil',
      message:
          'Transaksi berhasil. Sedang menunggu konfirmasi penerimaan dari penjual.',
      date: '15 Nov 2023 12:09',
    ));
    addNotification(NotificationModel(
      name: 'Info',
      title: 'Pemberitahuan Penting',
      message:
          'Ada pembaruan aplikasi yang perlu Anda perhatikan. Pastikan untuk memperbarui segera.',
      date: '16 Nov 2023 10:30',
    ));
    addNotification(NotificationModel(
      name: 'Info',
      title: 'Nomor rekening berhasil ditambahkan',
      message:
          'Rekening 1570010832153 sudah dapat digunakan untuk penarikan dana.',
      date: '12 Nov 2023 10:30',
    ));
  }
}