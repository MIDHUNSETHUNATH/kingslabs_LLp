import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductPage({required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _discountPercentageController;
  late TextEditingController _ratingController;
  late TextEditingController _stockController;
  late TextEditingController _tagsController;
  late TextEditingController _brandController;
  late TextEditingController _skuController;
  late TextEditingController _weightController;
  late TextEditingController _dimensionsController;
  late TextEditingController _warrantyInformationController;
  late TextEditingController _shippingInformationController;
  late TextEditingController _availabilityStatusController;
  late TextEditingController _returnPolicyController;
  late TextEditingController _minimumOrderQuantityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product['title']);
    _descriptionController = TextEditingController(text: widget.product['description']);
    _priceController = TextEditingController(text: widget.product['price'].toString());
    _discountPercentageController = TextEditingController(text: widget.product['discountPercentage'].toString());
    _ratingController = TextEditingController(text: widget.product['rating'].toString());
    _stockController = TextEditingController(text: widget.product['stock'].toString());
    _tagsController = TextEditingController(text: widget.product['tags'].join(', '));
    _brandController = TextEditingController(text: widget.product['brand']);
    _skuController = TextEditingController(text: widget.product['sku']);
    _weightController = TextEditingController(text: widget.product['weight'].toString());
    _dimensionsController = TextEditingController(text: '${widget.product['dimensions']['width']}, ${widget.product['dimensions']['height']}, ${widget.product['dimensions']['depth']}');
    _warrantyInformationController = TextEditingController(text: widget.product['warrantyInformation']);
    _shippingInformationController = TextEditingController(text: widget.product['shippingInformation']);
    _availabilityStatusController = TextEditingController(text: widget.product['availabilityStatus']);
    _returnPolicyController = TextEditingController(text: widget.product['returnPolicy']);
    _minimumOrderQuantityController = TextEditingController(text: widget.product['minimumOrderQuantity'].toString());
  }

  Future<void> _updateProduct() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('https://dummyjson.com/products/${widget.product['id']}'),
      body: jsonEncode({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': double.tryParse(_priceController.text),
        'discountPercentage': double.tryParse(_discountPercentageController.text),
        'rating': double.tryParse(_ratingController.text),
        'stock': int.tryParse(_stockController.text),
        'tags': _tagsController.text.split(', '),
        'brand': _brandController.text,
        'sku': _skuController.text,
        'weight': double.tryParse(_weightController.text),
        'dimensions': {
          'width': double.tryParse(_dimensionsController.text.split(',')[0]),
          'height': double.tryParse(_dimensionsController.text.split(',')[1]),
          'depth': double.tryParse(_dimensionsController.text.split(',')[2]),
        },
        'warrantyInformation': _warrantyInformationController.text,
        'shippingInformation': _shippingInformationController.text,
        'availabilityStatus': _availabilityStatusController.text,
        'returnPolicy': _returnPolicyController.text,
        'minimumOrderQuantity': int.tryParse(_minimumOrderQuantityController.text),
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 173, 75, 218),
        title: Text('Edit Product',style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title',labelStyle:  TextStyle(color: Colors.green,fontSize: 20.h)),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description',labelStyle:  TextStyle(color: Colors.green,fontSize: 18.h)),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price',labelStyle:  TextStyle(color: Colors.red,fontSize: 20.h)),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _discountPercentageController,
                decoration: InputDecoration(labelText: 'Discount Percentage',labelStyle:  TextStyle(color: Colors.green,fontSize: 20.h)),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: 'Rating',labelStyle:  TextStyle(color: Colors.blue,fontSize: 18.h)),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stock',labelStyle:  TextStyle(color: Colors.red,fontSize: 18.h)),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _tagsController,
                decoration: InputDecoration(labelText: 'Tags (comma separated)',labelStyle:  TextStyle(color: Colors.green,fontSize: 18.h)),
              ),
              TextField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Brand',labelStyle:  TextStyle(color: const Color.fromARGB(255, 216, 148, 30),fontSize: 18.h)),
              ),
              TextField(
                controller: _skuController,
                decoration: InputDecoration(labelText: 'SKU',labelStyle:  TextStyle(color: const Color.fromARGB(255, 216, 46, 157),fontSize: 20.h)),
              ),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight',labelStyle:  TextStyle(color: const Color.fromARGB(255, 228, 139, 139),fontSize: 17.h)),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _dimensionsController,
                decoration: InputDecoration(labelText: 'Dimensions (width,height,depth)',labelStyle:  TextStyle(color: const Color.fromARGB(255, 29, 193, 187),fontSize: 17.h)),
              ),
              TextField(
                controller: _warrantyInformationController,
                decoration: InputDecoration(labelText: 'Warranty Information',labelStyle:  TextStyle(color: const Color.fromARGB(255, 31, 54, 228),fontSize: 18.h)),
              ),
              TextField(
                controller: _shippingInformationController,
                decoration: InputDecoration(labelText: 'Shipping Information',labelStyle:  TextStyle(color: const Color.fromARGB(255, 33, 99, 2),fontSize: 17.h)),
              ),
              TextField(
                controller: _availabilityStatusController,
                decoration: InputDecoration(labelText: 'Availability Status',labelStyle:  TextStyle(color: const Color.fromARGB(255, 79, 49, 49),fontSize: 18.h)),
              ),
              TextField(
                controller: _returnPolicyController,
                decoration: InputDecoration(labelText: 'Return Policy',labelStyle:  TextStyle(color: const Color.fromARGB(255, 91, 48, 222),fontSize: 18.h)),
              ),
              TextField(
                controller: _minimumOrderQuantityController,
                decoration: InputDecoration(labelText: 'Minimum Order Quantity',labelStyle:  TextStyle(color: const Color.fromARGB(255, 155, 199, 67),fontSize: 16.h)),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                ),
                onPressed: _updateProduct,
                child: Text('Update',style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
    
    }
    );
  }
}