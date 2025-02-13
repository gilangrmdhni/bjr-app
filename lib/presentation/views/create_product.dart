import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProductView extends StatefulWidget {
  @override
  _CreateProductViewState createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController minOrderController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController marketPriceController = TextEditingController();
  final TextEditingController marketUrlController = TextEditingController();

  List<Asset> _pickedImages = [];
  List<Map<String, dynamic>> _categories = [];
  Map<String, dynamic>? _selectedCategory;
  String? _token;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchToken();
    _selectedCategory;
  }

  Future<void> _fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
  }

  Future<void> _fetchCategories() async {
    try {
      var response = await http.get(
        Uri.parse('https://api.bjr-dev.nuncorp.id/ps/api/v1/categories'),
      );

      print('API Response: ${response.body}');

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        if (responseData != null &&
            responseData['body'] != null &&
            responseData['body'].isNotEmpty) {
          List<dynamic> categoriesData = responseData['body'];

          setState(() {
            _categories = categoriesData
                .map((category) => {
                      'id': category['id'],
                      'name': category['name'],
                    })
                .toList();

            _selectedCategory = _categories.isNotEmpty ? _categories[0] : null;
          });
        } else {
          print('Response data or data array is null or empty');
        }
      } else {
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _uploadImagesToMediaApi() async {
    List<Map<String, dynamic>> imageInfoList = [];

    for (var image in _pickedImages) {
      ByteData byteData = await image.getByteData(quality: 50);
      List<int> imageData = byteData.buffer.asUint8List();

      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://api.bjr-dev.nuncorp.id/ms/api/v1/media'),
        );

        request.files.add(http.MultipartFile.fromBytes(
          'file',
          imageData,
          filename: 'image.jpg',
          contentType: MediaType('application', 'octet-stream'),
        ));

        // Change destination to "storage"
        request.fields['destination'] = 'storage';

        var response = await request.send();

        if (response.statusCode == 200) {
          // Read response from media API
          String responseString = await response.stream.bytesToString();
          Map<String, dynamic> responseData = json.decode(responseString);

          if (responseData != null && responseData['body'] != null) {
            // Add entire body from API response, which already contains all required information
            imageInfoList.add(responseData['body']);
          } else {
            print('Error: Image information is missing in the response');
          }
        } else {
          print('Error uploading image. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    if (imageInfoList.isEmpty) {
      print('Error: Image information list is empty.');
    }

    return imageInfoList;
  }

  Map<String, dynamic> _prepareProductData(
      List<Map<String, dynamic>> imageInfoList) {
    print('Category id: ${_selectedCategory}');
    print('Original Price Controller Value: ${originalPriceController.text}');
    print('Discount Controller Value: ${discountController.text}');
    print('Min Order Controller Value: ${minOrderController.text}');
    print('Stock Controller Value: ${stockController.text}');
    print('Weight Controller Value: ${weightController.text}');
    print('Market Price Controller Value: ${marketPriceController.text}');
    print('Market URL Controller Value: ${marketUrlController.text}');

    String name = nameController.text;
    int originalPrice = int.tryParse(originalPriceController.text) ?? 0;

    // Mendapatkan nilai persentase diskon dari input pengguna
    double discountPercentage = double.tryParse(discountController.text) ?? 0.0;
    // Mengonversi persentase diskon menjadi format desimal antara 0 dan 1
    double discount = discountPercentage / 100;

    int categoryId = _selectedCategory?['id'] ?? 0;
    int minOrder = int.tryParse(minOrderController.text) ?? 1;
    int stock = int.tryParse(stockController.text) ?? 1;
    int weight = (double.tryParse(weightController.text) ?? 6.0).round();
    String companyName = companyNameController.text;
    double marketPrice = double.tryParse(marketPriceController.text) ?? 0.0;
    String marketUrl = marketUrlController.text;

    List<Map<String, dynamic>> marketPrices = [
      {
        "company_name": companyName,
        "price": marketPrice,
        "url": marketUrl,
      },
    ];

    List<Map<String, dynamic>> productImages = imageInfoList.map((imageInfo) {
      return {
        'content_type': imageInfo['content_type'],
        'file_name': imageInfo['file_name'],
        'file_size': imageInfo['file_size'],
        'file_path': imageInfo['file_path'],
      };
    }).toList();

    Map<String, dynamic> productData = {
      'name': name,
      'original_price': originalPrice,
      'discount': discount,
      'category_id': categoryId,
      'min_order': minOrder,
      'stock': stock,
      'store_id': 'aa81e33c-0c5c-4e2c-a9e4-a0fd500f5002',
      'weight': weight,
      'market_prices': marketPrices,
      'images': productImages,
    };

    return productData;
  }

  Future<void> _sendProductDataToOtherApi(
      Map<String, dynamic> productData) async {
    try {
      var url = Uri.parse('https://api.bjr-dev.nuncorp.id/ps/api/v1/products');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$_token',
      };
      var body = jsonEncode(productData);

      print('Sending product data to API:');
      print('URL: $url');
      print('Headers: $headers');
      print('Body: $body');

      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      print('API Response Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode != 200) {
        Map<String, dynamic> errorResponse = json.decode(response.body);

        print('Server Response Status Code: ${response.statusCode}');
        print('Server Response Body: ${response.body}');

        throw Exception(
          'Failed to add product. Status code: ${response.statusCode}, '
          'Error message: ${errorResponse["detail"]}',
        );
      }
    } catch (e) {
      print('Error sending product data: $e');
      rethrow;
    }
  }

  Future<void> _pickImages() async {
    List<Asset> images = [];
    try {
      images = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: _pickedImages,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Pilih Gambar",
          allViewTitle: "Semua Gambar",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } catch (e) {
      print('Error picking images: $e');
    }

    if (!mounted) return;

    setState(() {
      _pickedImages = images;
    });
  }

  Future<void> _saveProduct(BuildContext context) async {
    try {
      if (_pickedImages.isEmpty) {
        throw Exception("Please select at least one image.");
      }

      List<Map<String, dynamic>> imageInfoList =
          await _uploadImagesToMediaApi();

      print('Uploaded Image Info: $imageInfoList');

      if (imageInfoList.isEmpty) {
        print('Error: Image info list is empty.');
        return;
      }

      // Use imageInfoList (image information) to prepare product data
      Map<String, dynamic> productData = _prepareProductData(imageInfoList);

      print('Prepared Product Data: $productData');

      await _sendProductDataToOtherApi(productData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: originalPriceController,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true), // Allow decimal input
                decoration: InputDecoration(labelText: 'Original Price'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: discountController,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true), // Allow decimal input
                decoration: InputDecoration(labelText: 'Discount (%)'),
              ),
              SizedBox(height: 16),
              DropdownButton<Map<String, dynamic>>(
                hint: Text('Select Category'),
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value as Map<String, dynamic>?;
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: category,
                    child: Text(category['name']),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              TextField(
                controller: minOrderController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Minimum Order'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Stock'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Weight'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: companyNameController,
                decoration: InputDecoration(labelText: 'Company Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: marketPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Market Price'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: marketUrlController,
                decoration: InputDecoration(labelText: 'Market URL'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Select Product Images'),
              ),
              SizedBox(height: 16),
              if (_pickedImages.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _pickedImages.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _pickedImages.removeAt(index);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder<Uint8List>(
                            future: _getAssetBytes(_pickedImages[index]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return Image.memory(
                                  snapshot.data!,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _saveProduct(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _getAssetBytes(Asset asset) async {
    ByteData byteData = await asset.getByteData(quality: 50);
    return byteData.buffer.asUint8List();
  }
}
