import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl;

  OrderService(this.baseUrl);

  Future<Map<String, dynamic>> getAllOrders({
    String? month,
    String? year,
    String? category,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl/orders'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Map<String, dynamic>> getOrderById(String orderId) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/$orderId'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load order');
    }
  }

  Future<Map<String, dynamic>> addOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(Uri.parse('$baseUrl/orders'), headers: {
      'Content-Type': 'application/json',
    }, body: json.encode(orderData));

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add order');
    }
  }

  Future<Map<String, dynamic>> updateOrder(String orderId, Map<String, dynamic> orderData) async {
    final response = await http.put(Uri.parse('$baseUrl/orders/$orderId'), headers: {
      'Content-Type': 'application/json',
    }, body: json.encode(orderData));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update order');
    }
  }

  Future<Map<String, dynamic>> deleteOrder(String orderId) async {
    final response = await http.delete(Uri.parse('$baseUrl/orders/$orderId'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete order');
    }
  }
}
