import 'dart:io';

void main() async {
  final client = HttpClient();
  client.badCertificateCallback = (cert, host, port) => true;

  try {
    final request = await client.getUrl(Uri.parse('https://api.themoviedb.org/3/'));
    final response = await request.close();
    
    // Using a different approach to get certs: 
    // In Dart, getting the cert from HttpClientResponse directly is not easy if the cert is valid (it doesn't trigger the badCertificateCallback).
  } catch (e) {
    print(e);
  }
}
