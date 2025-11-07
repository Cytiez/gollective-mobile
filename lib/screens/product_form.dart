import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gollective/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _description = "";
  int _price = 0;
  String _thumbnail = "";
  bool _isFeatured = false; // default
  String _clubname = "";
  String _season = "";
  int _release_year = 0;
  String _condition = "Mint";
  bool _authenticity = true;
  String _category = "Home Jersey";

  final List<String> _categories = [
    'Home Jersey',
    'Away Jersey',
    'Third Jersey',
  ];

  final List<String> _conditions = ['Mint', 'Second'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add News Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ], // max 50
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) =>
                      setState(() => _name = value?.trim() ?? ""),
                  validator: (String? value) {
                    final v = (value ?? "").trim();
                    if (v.isEmpty) return "Product Name can't be empty";
                    if (v.length < 3) return "Min length is 3 characters";
                    if (v.length > 50) return "Max length is 50 characters";
                    return null;
                  },
                ),
              ),

              // === description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(500),
                  ], // max 500
                  decoration: InputDecoration(
                    hintText: "Product Description",
                    labelText: "Product Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) =>
                      setState(() => _description = value?.trim() ?? ""),
                  validator: (String? value) {
                    final v = (value ?? "").trim();
                    if (v.isEmpty) return "Product Description can't be empty";
                    if (v.length < 10) return "Min length is 10 characters";
                    if (v.length > 500) return "Max length is 500 characters";
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _categories.contains(_category)
                      ? _category
                      : null, // guard
                  items: _categories
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat, // value harus persis sama dgn list
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() => _category = newValue ?? 'home');
                  },
                ),
              ),

              // === price (IDR) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Price (IDR)",
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // cegah minus
                    LengthLimitingTextInputFormatter(
                      9,
                    ), // batasi 9 digit (opsional)
                  ],
                  onChanged: (String? value) =>
                      setState(() => _price = int.tryParse(value ?? "0") ?? 0),
                  validator: (String? value) {
                    // Non-negative: >= 0
                    final n = int.tryParse(value ?? "");
                    if (n == null) return "Enter a valid number";
                    if (n < 0) return "Price cannot be negative";
                    return null;
                  },
                ),
              ),

              // === club name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ], // max 50
                  decoration: InputDecoration(
                    hintText: "Club Name",
                    labelText: "Club Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) =>
                      setState(() => _clubname = value?.trim() ?? ""),
                  validator: (String? value) {
                    final v = (value ?? "").trim();
                    if (v.isEmpty) return "Club Name can't be empty";
                    if (v.length < 2) return "Min length is 2 characters";
                    if (v.length > 50) return "Max length is 50 characters";
                    return null;
                  },
                ),
              ),

              // === season (e.g., 2024/25) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                  ], // YYYY/YY
                  decoration: InputDecoration(
                    hintText: "Season (e.g., 2024/25)",
                    labelText: "Season",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) =>
                      setState(() => _season = value?.trim() ?? ""),
                  validator: (String? value) {
                    final v = (value ?? "").trim();
                    if (v.isEmpty) return "Season can't be empty";
                    final reg = RegExp(r'^\d{4}/\d{2}$');
                    if (!reg.hasMatch(v))
                      return "Use format YYYY/YY (e.g., 2024/25)";
                    return null;
                  },
                ),
              ),

              // === release year ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Release Year (e.g., 2025)",
                    labelText: "Release Year",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (String? value) {
                    setState(() {
                      _release_year = int.tryParse(value ?? "0") ?? 0;
                    });
                  },
                  validator: (String? value) {
                    final y = int.tryParse(value ?? "");
                    if (y == null) return "Enter a valid year";
                    if (y < 1900 || y > DateTime.now().year) {
                      return "Year must be between 1900 and ${DateTime.now().year}";
                    }
                    return null;
                  },
                ),
              ),

              // === condition ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Condition",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _conditions.contains(_condition)
                      ? _condition
                      : null, // guard
                  items: _conditions
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c[0].toUpperCase() + c.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() => _condition = newValue ?? 'mint');
                  },
                ),
              ),

              // === authenticity ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Authentic (Original)"),
                  subtitle: const Text("Matikan jika replika"),
                  value: _authenticity,
                  onChanged: (bool value) {
                    setState(() {
                      _authenticity = value;
                    });
                  },
                ),
              ),

              // === Thumbnail URL (opsional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ], // max 200
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail (optional)",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) =>
                      setState(() => _thumbnail = value?.trim() ?? ""),
                  validator: (String? value) {
                    final v = (value ?? "").trim();
                    if (v.isEmpty) return null; // opsional
                    final uri = Uri.tryParse(v);
                    final valid =
                        uri != null &&
                        (uri.isScheme("http") || uri.isScheme("https"));
                    if (!valid) return "Enter a valid http/https URL";
                    if (v.length > 200) return "Max length is 200 characters";
                    return null;
                  },
                ),
              ),

              // === Is Featured ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Featured Product"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),
              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil tersimpan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Product Name: $_name'),
                                    Text('Description: $_description'),
                                    Text(
                                      'Category: ${_category[0].toUpperCase() + _category.substring(1)}',
                                    ),
                                    Text('Price: $_price'),
                                    Text('Club: $_clubname'),
                                    Text('Season: $_season'),
                                    Text('Release Year: $_release_year'),
                                    Text(
                                      'Condition: ${_condition[0].toUpperCase() + _condition.substring(1)}',
                                    ),
                                    Text(
                                      'Authentic: ${_authenticity ? "Yes" : "No"}',
                                    ),
                                    Text('Thumbnail: $_thumbnail'),
                                    Text(
                                      'Featured: ${_isFeatured ? "Yes" : "No"}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
