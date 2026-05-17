import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing/Models/post.dart';

class ApiService {
  static const String url =
      "https://simpbb.technosmart.id/api/rpc/objekPajak/listDetails";
  
  static const Duration timeout = Duration(seconds: 30);

  static Future<List<Post>> fetchData({
    required Map<String, dynamic> payload,
  }) async {
    try {
      print("Fetching from: $url");
      print("Payload: $payload");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(payload),
      ).timeout(timeout, onTimeout: () {
        throw Exception("Request timeout after ${timeout.inSeconds}s");
      });

      print("✅ Response Status: ${response.statusCode}");
      print("📄 Response Body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(
          "HTTP Error ${response.statusCode}: ${response.reasonPhrase}",
        );
      }

      final decoded = jsonDecode(response.body);
      print("Decoded Response: $decoded");

      // Handle the nested structure
      if (decoded == null) {
        throw Exception("Response is null");
      }

      final json = decoded['json'];
      if (json == null) {
        throw Exception("'json' field not found in response");
      }

      final rows = json['rows'];
      if (rows == null) {
        throw Exception("'rows' field not found in response");
      }

      if (rows is! List) {
        throw Exception("'rows' is not a list");
      }

      final posts = rows.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
      print("Successfully parsed ${posts.length} posts");

      return posts;
    } on http.ClientException catch (e) {
      print("Network Error: $e");
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }
}