import 'dart:io';

class BadHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // if (Platform.isAndroid) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) {
    //       if (cert.pem == PEM) {
    //         // Verify the certificate
    //         return true;
    //       }
    //       return false;
    //     };
    //   };
    // }

    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}
