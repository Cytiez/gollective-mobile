import 'package:flutter/material.dart';
import 'package:gollective/models/product_entry.dart';
import 'package:gollective/widgets/left_drawer.dart';
import 'package:gollective/widgets/product_entry_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:gollective/screens/product_detail.dart';

class ProductEntryListPage extends StatefulWidget {
  final String filterType;

  const ProductEntryListPage({super.key, this.filterType = 'all'});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<Products>> fetchProducts(CookieRequest request) async {
    // URL endpoint. Ganti 10.0.2.2 dengan localhost jika kamu run di Chrome/Web
    String url = 'http://localhost:8000/json/?filter=${widget.filterType}';
    
    try {
      final response = await request.get(url);

      // Debugging: Print response ke console
      print("Status request ke $url : Berhasil");
      // print("Data: $response"); 

      List<Products> products = [];
      for (var d in response) {
        if (d != null) {
          products.add(Products.fromJson(d));
        }
      }
      return products;
    } catch (e) {
      // Jika error, print ke console
      print("Terjadi kesalahan saat fetch data: $e");
      // Lempar error agar ditangkap FutureBuilder
      throw Exception('Gagal mengambil data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    String title = widget.filterType == 'my' ? 'My Products' : 'Product List';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          // 1. Tampilkan loading jika state masih waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 2. Tampilkan Error jika terjadi masalah koneksi/server
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi kesalahan:',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}', // Menampilkan pesan error asli
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Tampilkan pesan jika data kosong
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada produk.',
                style: TextStyle(fontSize: 18, color: Color(0xff59A5D8)),
              ),
            );
          }

          // 4. Tampilkan Data
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