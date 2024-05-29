import 'package:flutter/material.dart';

class GroupWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Grup Wishlist kamu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGroupListThumbnail(
                'Handphone',
                [
                  'assets/images/products/iphone_12_blue.png',
                  'assets/images/products/samsung_s9_mobile_back.png',
                ],
                [
                  'assets/images/products/samsung_s9_mobile_withback.png',
                  'assets/images/products/iphone_14_pro.png',
                ],
              ),
              _buildGroupListThumbnail(
                'Sepatu',
                [
                  'assets/images/products/NikeAirJOrdonWhiteRed.png',
                  'assets/images/products/NikeAirMax.png',
                ],
                [
                  'assets/images/products/NikeBasketballShoeGreenBlack.png',
                  'assets/images/products/NikeWildhorse.png',
                ],
              ),
            ],
          ),
          SizedBox(height: 8), // Spacer
          _buildCustomButton(),
        ],
      ),
    );
  }

  Widget _buildGroupListThumbnail(
      String groupName, List<String> imagesTop, List<String> imagesBottom) {
    return SizedBox(
      width: 167,
      height: 204,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Color(0xFF2E91FF),
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: imagesTop
                          .map((image) => _buildThumbnailImage(image))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: imagesBottom
                          .map((image) => _buildThumbnailImage(image))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                groupName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnailImage(String imagePath) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          // Action when the button is pressed
        },
        icon: Icon(Icons.add, color: Colors.blue),
        label: Text(
          'Buat list baru',
          style: TextStyle(color: Colors.blue),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
