import 'package:http/http.dart' as http;

main() async {
  final response = await http.get("https://httpbin.org/ip");
  if (response.statusCode == 200) {
    print(response.body);
  }
}
