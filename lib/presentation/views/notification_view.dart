import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jual_rugi_app/presentation/controllers/notification_controller.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationController notificationController =
      Get.put(NotificationController());

  String selectedAccount = 'Dini Ramadanti'; // Default akun dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: [
            Icon(Icons.account_circle, color: Colors.black),
            SizedBox(width: 8),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedAccount,
                items:
                    <String>['Dini Ramadanti', 'Toko DIni'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAccount = newValue!; // Simpan akun yang dipilih
                  });
                },
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(70.0), // Sesuaikan tinggi sesuai kebutuhan
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0), // Atur jarak vertikal
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton('Semua'),
                _buildFilterButton('Transaksi'),
                _buildFilterButton('Promo'),
                _buildFilterButton('Info'),
                IconButton(
                  icon: Icon(Icons.settings,
                      color: Colors.grey.shade800), // Tambahkan ikon setting
                  onPressed: () {
                    // Tambahkan aksi ketika ikon setting ditekan
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            var notification = notificationController.notifications[index];
            return Column(
              children: [
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  leading: Container(
                    margin: EdgeInsets.only(right: 8),
                    child: _buildNotificationIcon(notification.name),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        notification.date,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3),
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF3C3C43),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String name) {
    IconData iconData;
    double iconSize = 18.0;
    switch (name) {
      case 'Pembayaran':
        iconData = Icons.payment;
        break;
      case 'Info':
        iconData = Icons.info;
        break;
      default:
        iconData = Icons.notification_important;
    }
    return Icon(iconData, color: Colors.blue, size: iconSize);
  }

  Widget _buildFilterButton(String text) {
    return TextButton(
      onPressed: () {
        // Aksi ketika tombol filter ditekan
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
              color: Colors.grey.shade400, width: 1.0), // Tambahkan border
        ),
      ),
      child: Text(
        text,
        style:
            TextStyle(fontWeight: FontWeight.w400, color: Colors.grey.shade800),
      ),
    );
  }
}
