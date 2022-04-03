import 'package:flutter/material.dart';
import 'package:rivlus_webview_app/common_widgets/image_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rivlus_webview_app/no_connection.dart';
import 'package:rivlus_webview_app/web_view.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Rivlus WebView App',
          style: TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Color(0xFF2d2a6d),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              buildImageButton(context, 'https://www.google.com',
                  'images/kullananvar.png', 'Kullanan Var'),
              buildImageButton(context, 'https://www.google.com',
                  'images/kullananvar.png', 'Kullananlar'),
              buildImageButton(context, 'https://www.google.com',
                  'images/kullananvar.png', 'Rivlus'),
            ],
          ),
        ),
      ),
    );
  }

  ImageButton buildImageButton(BuildContext context, String urlGit,
      String imageGoster, String yaziGoster) {
    return ImageButton(
      onPressed: () async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WebViewer()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => NoConnectionPage()));
        }
      },
      image: AssetImage(imageGoster),
      text: Text(
        yaziGoster,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 17,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
