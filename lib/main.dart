import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(){
  runApp(MaterialApp(home: HomePage()));
}

var _url = '';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25),),
        ),
        centerTitle: true,
        title: Text(
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
              buildImageButton(context,'https://www.kullananvar.com','images/kullananvar.png','Kullanan Var'),
              buildImageButton(context,'https://www.kullananlar.xyz','images/kullananvar.png','Kullananlar'),
              buildImageButton(context,'https://www.rivlus.com','images/kullananvar.png','Rivlus'),
            ],
          ),
        ),
      ),
    );
  }

  ImageButton buildImageButton(BuildContext context, String urlGit, String imageGoster, String yaziGoster) {
    return ImageButton(
      onPressed: () {
        _url = urlGit;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WebViewer()));
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

class WebViewer extends StatefulWidget {
  @override
  WebViewerState createState() => WebViewerState();
}

class WebViewerState extends State<WebViewer> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          backgroundColor: Color(0xFF2d2a6d),
          title: Text(
            'Rivlus WebView App',
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: WebView(
          initialUrl: _url.toString(),
        ),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ImageProvider image;
  double imageHeight;
  final double radius;
  final Widget text;

  ImageButton({
    required this.onPressed,
    required this.image,
    this.imageHeight = 150,
    this.radius = 10,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    imageHeight = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 90 : 135;
    return Card(
      elevation: 8,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image: image,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 8,
            ),
            text,
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
