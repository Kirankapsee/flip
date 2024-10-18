// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// class PDFScreen extends StatefulWidget {
//   @override
//   _PDFScreenState createState() => _PDFScreenState();
// }

// class _PDFScreenState extends State<PDFScreen> {
//   String url =
//       'https://www.sathyabama.ac.in/sites/default/files/course-material/2020-10/unit1.pdf'; // Replace with your PDF URL
//   String? filePath;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _downloadAndSavePdf();
//   }

//   Future<void> _downloadAndSavePdf() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final dir = await getApplicationDocumentsDirectory();
//         final file = File('${dir.path}/sample.pdf');
//         await file.writeAsBytes(response.bodyBytes, flush: true);

//         setState(() {
//           filePath = file.path;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error downloading PDF: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Network PDF Viewer"),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : PDFView(
//               filePath: filePath!,
//               enableSwipe: true,
//               swipeHorizontal: true,
//               autoSpacing: false,
//               pageFling: false,
//               onError: (error) {
//                 print("Error loading PDF: $error");
//               },
//             ),
//     );
//   }
// }

// void _showNativePageCurl() {
//   const platform = MethodChannel('com.example/pdfpagecurl');

//   try {
//     platform.invokeMethod('showPageCurl');
//   } on PlatformException catch (e) {
//     print("Failed to show page curl: '${e.message}'.");
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PDFScreen extends StatefulWidget {
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String url =
      'https://www.sathyabama.ac.in/sites/default/files/course-material/2020-10/unit1.pdf'; // Replace with your PDF URL
  String? filePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/sample.pdf');
        await file.writeAsBytes(response.bodyBytes, flush: true);

        setState(() {
          filePath = file.path;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network PDF Viewer"),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: _showNativePageCurl,  // Call to invoke the native page curl
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: filePath!,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onError: (error) {
                print("Error loading PDF: $error");
              },
            ),
    );
  }

  void _showNativePageCurl() {
    const platform = MethodChannel('com.example/pdfpagecurl');

    try {
      platform.invokeMethod('showPageCurl');
    } on PlatformException catch (e) {
      print("Failed to show page curl: '${e.message}'.");
    }
  }
}
