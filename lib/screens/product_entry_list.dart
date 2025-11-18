import 'package:flutter/material.dart';
import 'package:gollective/models/product_entry.dart';
import 'package:gollective/widgets/left_drawer.dart';
import 'package:gollective/widgets/product_entry_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:gollective/screens/product_detail.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<Products>> fetchProducts(CookieRequest request) async {
    // To connect Android emulator with Django on localhost, use URL http://10.0.2.2:8000
    // If using Chrome or iOS simulator, use http://localhost:8000
    final response = await request.get('http://localhost:8000/json/');

    List<Products> products = [];
    for (var d in response) {
      if (d != null) {
        products.add(Products.fromJson(d));
      }
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada produk.',
                style: TextStyle(fontSize: 18, color: Color(0xff59A5D8)),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: snapshot.data![index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: snapshot.data![index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
