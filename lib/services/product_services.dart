import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qpi_eng/model/world_api_model/product_model.dart';

class ProductService {
  static Future<ProductModel?> fetchProduct(String barcode) async {
    // 1️⃣ Try FOOD API
    final food = await _fetchFromApi(
      'https://world.openfoodfacts.org/api/v0/product/$barcode.json',
      'Food',
    );
    if (food != null) return food;

    // 2️⃣ Try BEAUTY API
    final beauty = await _fetchFromApi(
      'https://world.openbeautyfacts.org/api/v0/product/$barcode.json',
      'Beauty',
    );
    if (beauty != null) return beauty;

    // 3️⃣ Try GENERAL / ELECTRONICS API (UPCItemDB)
    final electronics = await _fetchFromApi(
      'https://api.upcitemdb.com/prod/trial/lookup?upc=$barcode',
      'Electronics',
    );
    if (electronics != null) return electronics;

    // 4️⃣ Try BARCODE LOOKUP (very limited free)
    final general = await _fetchFromApi(
      'https://api.barcodelookup.com/v3/products?barcode=$barcode&key=YOUR_API_KEY',
      'General',
    );
    if (general != null) return general;

    //🐱‍🏍🐱‍🏍upc database
    final upcDb = await _fetchFromApi(
      'https://upcdatabase.org/api?apikey=YOUR_KEY&upc=$barcode',
      'General',
    );
    if (upcDb != null) return upcDb;

    return null;
  }

  static Future<ProductModel?> _fetchFromApi(String url, String source) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 1) {
          final product = data['product'];

          return ProductModel(
            name: product['product_name'] ?? 'Unknown',
            brand: product['brands'] ?? 'Unknown',
            imageUrl: product['image_front_url'] ?? '',
            source: source,
          );
        }
      }
    } catch (_) {}

    return null;
  }
}
