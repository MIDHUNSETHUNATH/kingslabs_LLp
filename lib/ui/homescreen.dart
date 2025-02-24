import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kingslabs_task/ui/product.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _products = [];
  bool _isLoading = true;

  Future<void> _fetchProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _products = data['products'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch products')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 88, 215, 211),
        title: Text('HOME'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  leading: Container(
                     height: 80.h,
                     width: 70.w,
                    child: Image.network(product['thumbnail'],
                    fit: BoxFit.cover, )),
                  title: Text(product['title'],style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  subtitle: Text(product['description'],style: TextStyle(color: const Color.fromARGB(255, 70, 89, 98)),),
                  trailing: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
     );
  }
}