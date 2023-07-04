/*
Android Integration 
In order to use this plugin, please update the Gradle, Kotlin and Kotlin Gradle Plugin:

In android/build.gradle change ext.kotlin_version = '1.3.50' to ext.kotlin_version = '1.5.10'

In android/build.gradle change classpath 'com.android.tools.build:gradle:3.5.0' to classpath 'com.android.tools.build:gradle:4.2.0'

In android/gradle/wrapper/gradle-wrapper.properties change distributionUrl=https\://services.gradle.org/distributions/gradle-5.6.2-all.zip to distributionUrl=https\://services.gradle.org/distributions/gradle-6.9-all.zip

In android/app/build.gradle change defaultConfig{ ... minSdkVersion 16 } to defaultConfig{ ... minSdkVersion 20 }

Warning 
If you are using Flutter Beta or Dev channel (1.25 or 1.26) you can get the following error:

java.lang.AbstractMethodError: abstract method "void io.flutter.plugin.platform.PlatformView.onFlutterViewAttached(android.view.View)"

This is a bug in Flutter which is being tracked here: https://github.com/flutter/flutter/issues/72185

There is a workaround by adding android.enableDexingArtifactTransform=false to your gradle.properties file.

iOS Integration 
In order to use this plugin, add the following to your Info.plist file:

<key>io.flutter.embedded_views_preview</key>
<true/>
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan QR codes</string>
Web Integration 
Add this to web/index.html:

<script src="https://cdn.jsdelivr.net/npm/jsqr@1.3.1/dist/jsQR.min.js"></script>


Flip Camera (Back/Front) 
The default camera is the back camera.

await controller.flipCamera();
Flash (Off/On) 
By default, flash is OFF.

await controller.toggleFlash();
Resume/Pause 
Pause camera stream and scanner.

await controller.pauseCamera();
Resume camera stream and scanner.

await controller.resumeCamera();
SDK 
Requires at least SDK 20. Requires at least iOS 8.
*/

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({super.key});

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }
}
