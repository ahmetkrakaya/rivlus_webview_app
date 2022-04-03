import 'package:flutter/material.dart';
import 'package:rivlus_webview_app/common_widgets/image_button.dart';
import 'package:rivlus_webview_app/main.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  const <Widget>[
            Text('Ooops', style: TextStyle(fontSize: 64)),
            SizedBox(height: 20,),
            Text('İnternet bağlantısı yok!',style: TextStyle(color: Colors.black45),),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
