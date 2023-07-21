const myProtocol = "http";
const myDomain = "localhost";
const myPort = 8090;

class MyUrl {
  late Uri uri;

  MyUrl(String myPath) {
    uri = Uri(scheme: myProtocol, host: myDomain, port: myPort, path: myPath);
  }

  Uri getUrl() { return uri;}
}
