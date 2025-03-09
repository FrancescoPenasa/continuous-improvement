
import 'package:http/http.dart' as http;

class UserRepository {
  Future<http.Response> getUser() async {
    final url = Uri.parse('https://dummyapi.io/data/api/user');
    final response = await http.get(url);
    await Future.delayed(const Duration(seconds: 2));
    return response;
  }

  // static final String messagesPath = 'assets/data/json/messages.json';
  //
  // Future<http.Response> getMessages() async {
  //   // Load JSON from the assets folder
  //   final String jsonString = await rootBundle.loadString(messagesPath);
  //   final dummyResponse = http.Response(
  //     jsonString,
  //     200,
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //   await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
  //   return dummyResponse;
  // }
}