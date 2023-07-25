import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import '../WebPages/test.dart';

import 'dart:convert';
// import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:image_zoom_on_move/image_zoom_on_move.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'package:file_picker/file_picker.dart';

import 'dart:html' as html;

import 'package:dotted_border/dotted_border.dart';
import 'package:traion/ColorThemes/appColors.dart';

String api = "https://2943-35-227-160-142.ngrok-free.app";

class TraionStudio extends StatefulWidget {
  const TraionStudio({super.key});

  @override
  State<TraionStudio> createState() => _TraionStudioState();

  // final ValueChanged<DroppedFile> onDroppedFile;
}

late String personImageDownloadURL = '';

class _TraionStudioState extends State<TraionStudio> {
  String selectFile = '';
  String droppedFile = '';
  bool _isLoading = false;

  late DropzoneViewController controller;

  Uint8List? selectedImageInBytes = null;
  Uint8List? imageData = null;
  Uint8List? clothImageInBytes = null;
  late ByteData clothImageBytes;

  late String clothImageURL =
      'https://firebasestorage.googleapis.com/v0/b/traion-9e904.appspot.com/o/Clothings%2F00017_00.jpg?alt=media&token=77f7cc9c-c215-496a-937b-bafd22ee8330';
  String uniqueFileName =
      DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
  // Image.memory(imageData!);
//get the ref to storage root

  void initState() {
    super.initState();
    FirebaseStorage storage =
        FirebaseStorage.instanceFor(bucket: 'gs://traion-9e904.appspot.com');

    // FirebaseStorage storage =
    //     FirebaseStorage.instanceFor(bucket: 'gs://traion-9e904.appspot.com');
    // Replace this with the path to your image in Firebase Storage
    String imagePath = 'gs://traion-9e904.appspot.com/Clothings/00017_00.jpg';

    // Get the download URL for the image
    storage.ref().child(imagePath).getDownloadURL().then((url) {
      // print(url);
      clothImageURL = url;
      setState(() {
        clothImageURL = url;
      });
      // print(clothImageURL);
    });
  }

  String url =
      "https://firebasestorage.googleapis.com/v0/b/traion-9e904.appspot.com/o/Clothings%2F00484_00.jpg?alt=media&token=5ddd14d1-c8ec-493a-a233-14768116ccf7";
  String url2 =
      "https://firebasestorage.googleapis.com/v0/b/traion-9e904.appspot.com/o/Clothings%2F02198_00.jpg?alt=media&token=60f69ac9-9587-405f-b2ff-616dd547639b"; //  MyImage(this.imageData);

  String url3 =
      "https://firebasestorage.googleapis.com/v0/b/traion-9e904.appspot.com/o/Clothings%2F02534_00.jpg?alt=media&token=12bcd7f2-d78e-4ed6-a10e-aac5a9a3ef25";
  String url1 =
      "https://firebasestorage.googleapis.com/v0/b/traion-9e904.appspot.com/o/Clothings%2Fitem4.jpg?alt=media&token=7e11d459-2548-4628-9f3f-599603bfaa62";
  String url4 =
      "https://firebasestorage.googleapis.com/v0/b/traion-9e904.appspot.com/o/Clothings%2F00126_00.jpg?alt=media&token=24303a7c-a6eb-416d-9d29-35f64dbdb106"; // Image clothImg = Image.asset(

  //   'images/item1.png',
  //   fit: BoxFit.cover,
  // );
  Future<Uint8List> _readFileData(dynamic file) async {
    final reader = html.FileReader();
    reader.readAsDataUrl(file);
    await reader.onLoad.first;
    final dataUrl = reader.result as String;
    final bytes = base64.decode(dataUrl.split(',')[1]);
    return Uint8List.fromList(bytes);
  }

  String droppedImageInBytes = '';
  // File newImage;
  _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      setState(() {
        selectFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
        imageData = fileResult.files.first.bytes!;
        // print(imageData);
        Image.memory(imageData!);

        // post(
        //   Uri.parse("https://0248-35-202-217-147.ngrok-free.app/personImage"),
        //   headers: <String, String>{
        //     'Content-Type': 'application/json; charset=UTF-8',
        //   },
        //   body: jsonEncode(
        //     <String, String>{
        //       "img": imageData
        //           .toString()
        //           .substring(1, imageData.toString().length - 1),
        //     },
        //   ),
        // );
      });
      FirebaseStorage storage =
          FirebaseStorage.instanceFor(bucket: 'gs://traion-9e904.appspot.com');
      Reference referenceRoot = storage.ref();
      Reference imageRef = referenceRoot.child('personImage/$uniqueFileName');
      try {
        UploadTask uploadTask = imageRef.putData(imageData!);

        // Set a callback to handle when the upload is complete
        uploadTask.whenComplete(() async {
          // Get the download URL for the uploaded image
          String downloadURL = await (await uploadTask).ref.getDownloadURL();
          // print('Image uploaded. Download URL: $personImageDownloadURL');
          setState(() {
            personImageDownloadURL = downloadURL;
          });
          print('Image uploaded. Download URL: $personImageDownloadURL');
        });
      } catch (error) {}
    }
  }

  Future<void> loadResultingImage() async {
    final response = await get(Uri.parse('$api/getImage'));
    if (response.statusCode == 200) {
      setState(() {
        imageData = response.bodyBytes;
        selectedImageInBytes = response.bodyBytes;
        Image.memory(imageData!);
        // print(imageData);
        print('image loaded');
      });
      // Do something with imageData, e.g. display it in an Image widget
      // final imageWidget = Image.memory(imageData);
      // ...
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    // Initial Selected Value
    String shirtSizes = 'Small';

    // List of items in our dropdown menu
    var items = [
      'Small',
      'Medium',
      'Large',
    ];
    // Image clothImg = Image.asset(
    //   'images/item1.png',
    //   fit: BoxFit.cover,
    // );
    // Blob imageBlob;
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        title:Container(
          height: 100,
          width: 110,
          child: Image(
                        image: AssetImage('images/trAIon logo.png'),
                       
                      ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: secondaryBackgroundColor,
                ),
                onPressed: () async {
                  // Response response = await get(
                  //   Uri.parse("$api/runModel/"),
                  //   headers: <String, String>{
                  //     'Content-Type': 'application/json; charset=UTF-8',
                  //   },
                  // ).onError((error, stackTrace) {
                  //   print(error.toString());
                  //   print(stackTrace.toString());
                  //   return Response('Failed', 500);
                  // });
                  // print("response.body");
                  // print(response.body);
                  Navigator.pushNamed(context, '/Home');
                },
                icon: Icon(
                  Icons.home,
                  color: mainTextColor,
                ),
                label: Text(
                  'Home',
                  style: TextStyle(color: mainTextColor),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: secondaryBackgroundColor,
                ),
                onPressed: () => {
                      // Navigator.pushNamed(context, '/TraionStudio'),
                    },
                icon: Icon(
                  Icons.remove_from_queue_sharp,
                  color: mainTextColor,
                ),
                label: Text(
                  'trAIon Studio',
                  style: TextStyle(color: mainTextColor),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: TextButton.icon(
              onPressed: () => {},
              icon: Icon(
                Icons.person,
                color: mainTextColor,
              ),
              label: Text('Profile', style: TextStyle(color: mainTextColor)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 30),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: secondaryBackgroundColor,
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(
                  Icons.logout_sharp,
                  color: mainTextColor,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: mainTextColor),
                )),
          )
        ],
      ),
      body: Row(
        children: [
          Container(
            height: currentHeight * 90 / 100,
            width: currentWidth * 40 / 100,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: mainBackgroundColor,
                  ),
                  height: (currentHeight * 30) / 100,
                  width: (currentWidth * 37) / 100,
                  child: Card(
                    // width
                    color: secondaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: mainTextColor,
                        width: 0.3,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: mainTextColor,
                                    ),
                                height: (currentHeight * 31) / 100,
                                width: (currentWidth * 15) / 100,
                                // child: Image.network("$api/getImage/"),
                                // ignore: unnecessary_null_comparison
                                child:
                                    //  clothImageURL != null
                                    //     ? Image.network(clothImageURL)
                                    //     : CircularProgressIndicator(),
                                    Image.asset(
                                  'images/item1.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            SizedBox(
                              // height: (currentHeight * 1) / 100,
                              width: (currentWidth * 0.5) / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text('Blue Floral Top',
                                            style: TextStyle(
                                                color: mainTextColor,
                                                fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('A cotton shirt',
                                        style: TextStyle(
                                            color: mainTextColor,
                                            fontSize: 15)),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(4.0),
                                  //       child: Text('Size: ',
                                  //           style: TextStyle(
                                  //               color: mainTextColor,
                                  //               fontSize: 15)),
                                  //     ),
                                  //     Container(
                                  //       height: currentHeight * 5 / 100,
                                  //       width: currentWidth * 6 / 100,
                                  //       decoration: BoxDecoration(
                                  //         color: secondaryBackgroundColor,
                                  //       ),
                                  //       child: DropdownButton(
                                  //         // Initial Value
                                  //         value: shirtSizes,
                                  //         dropdownColor:
                                  //             secondaryBackgroundColor,
                                  //         style: TextStyle(
                                  //             color: mainTextColor,
                                  //             fontSize: 15),
                                  //         // Down Arrow Icon
                                  //         icon: const Icon(
                                  //           Icons.arrow_drop_down,
                                  //           color: mainTextColor,
                                  //         ),

                                  //         // Array list of items
                                  //         items: items.map((String items) {
                                  //           return DropdownMenuItem(
                                  //             value: items,
                                  //             child: Text(
                                  //               items,
                                  //               style: TextStyle(
                                  //                   color: mainTextColor,
                                  //                   fontSize: 15),
                                  //             ),
                                  //           );
                                  //         }).toList(),
                                  //         // After selecting the desired option,it will
                                  //         // change button value to selected value
                                  //         onChanged: (String? shirtSize) {
                                  //           setState(() async {
                                  //             shirtSizes = shirtSize!;
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: currentHeight * 10 / 100,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: currentWidth * 10 / 100,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            height: currentHeight * 5 / 100,
                            width: currentWidth * 8 / 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainButtonsColor,
                                ),
                                onPressed: () async {
                                  clothImageBytes =
                                      await rootBundle.load('images/item1.png');
                                  clothImageInBytes =
                                      clothImageBytes.buffer.asUint8List();
                                  Image.asset(
                                    'images/item1.png',
                                    fit: BoxFit.cover,
                                  );

                                  // post(
                                  //   Uri.parse(
                                  //       "https://0248-35-202-217-147.ngrok-free.app/personImage"),
                                  //   headers: <String, String>{
                                  //     'Content-Type':
                                  //         'application/json; charset=UTF-8',
                                  //   },
                                  //   body: jsonEncode(
                                  //     <String, String>{
                                  //       "img": imageData.toString().substring(
                                  //           1, imageData.toString().length - 1),
                                  //     },
                                  //   ),
                                  // );
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Response response = await post(
                                      Uri.parse("$api/runModel/"),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, String>{
                                        'cloth': url,
                                        'person': personImageDownloadURL
                                      })).onError((error, stackTrace) {
                                    print(error.toString());
                                    print(stackTrace.toString());
                                    return Response('Failed', 500);
                                  });
                                  if (response.body == "done") {
                                    print("done");
                                  } else {
                                    print("Failed");
                                  }

                                  await loadResultingImage();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  // child: Image.network("$api/getImage/"),

                                  // Future<void> _loadImage() async {
                                  //   var response = await http.get(Uri.parse('https://example.com/image.jpg'));
                                  //   setState(() {
                                  //     imageBytes = response.bodyBytes;
                                  //   });
                                  // }
                                  // post(
                                  //   Uri.parse(
                                  //       "http://df77-35-221-27-77.ngrok.io/clothImage"),

                                  //   // Uri.parse(
                                  //   // "http://535d-35-201-199-70.ngrok.io/clothImage"),
                                  //   headers: <String, String>{
                                  //     'Content-Type':
                                  //         'application/json; charset=UTF-8',
                                  //   },
                                  //   body: jsonEncode(
                                  //     <String, String>{
                                  //       "img": clothImageInBytes
                                  //           .toString()
                                  //           .substring(
                                  //               1,
                                  //               clothImageInBytes
                                  //                       .toString()
                                  //                       .length -
                                  //                   1),
                                  //     },
                                  //   ),
                                  // ),
                                },
                                child: Text('Try on',
                                    style: TextStyle(
                                      color: mainTextColor,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: mainBackgroundColor,
                  ),
                  height: (currentHeight * 30) / 100,
                  width: (currentWidth * 37) / 100,
                  child: Card(
                    // width
                    color: secondaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: mainTextColor,
                        width: 0.3,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: mainTextColor,
                                    ),
                                height: (currentHeight * 31) / 100,
                                width: (currentWidth * 15) / 100,
                                child: Image.asset(
                                  'images/item2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              // height: (currentHeight * 1) / 100,
                              width: (currentWidth * 0.5) / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text('Blue Floral Top',
                                            style: TextStyle(
                                                color: mainTextColor,
                                                fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('A cotton shirt',
                                        style: TextStyle(
                                            color: mainTextColor,
                                            fontSize: 15)),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(4.0),
                                  //       child: Text('Size: ',
                                  //           style: TextStyle(
                                  //               color: mainTextColor,
                                  //               fontSize: 15)),
                                  //     ),
                                  //     Container(
                                  //       height: currentHeight * 5 / 100,
                                  //       width: currentWidth * 6 / 100,
                                  //       decoration: BoxDecoration(
                                  //         color: secondaryBackgroundColor,
                                  //       ),
                                  //       child: DropdownButton(
                                  //         // Initial Value
                                  //         value: shirtSizes,
                                  //         dropdownColor:
                                  //             secondaryBackgroundColor,
                                  //         style: TextStyle(
                                  //             color: mainTextColor,
                                  //             fontSize: 15),
                                  //         // Down Arrow Icon
                                  //         icon: const Icon(
                                  //           Icons.arrow_drop_down,
                                  //           color: mainTextColor,
                                  //         ),

                                  //         // Array list of items
                                  //         items: items.map((String items) {
                                  //           return DropdownMenuItem(
                                  //             value: items,
                                  //             child: Text(
                                  //               items,
                                  //               style: TextStyle(
                                  //                   color: mainTextColor,
                                  //                   fontSize: 15),
                                  //             ),
                                  //           );
                                  //         }).toList(),
                                  //         // After selecting the desired option,it will
                                  //         // change button value to selected value
                                  //         onChanged: (String? shirtSize) {
                                  //           setState(() {
                                  //             shirtSizes = shirtSize!;
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: currentHeight * 10 / 100,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: currentWidth * 10 / 100,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            height: currentHeight * 5 / 100,
                            width: currentWidth * 8 / 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainButtonsColor,
                                ),
                                onPressed: () async {
                                  // clothImageBytes =
                                  //     await rootBundle.load('images/item2.png');
                                  // clothImageInBytes =
                                  //     clothImageBytes.buffer.asUint8List();
                                  Image.asset(
                                    'images/item2.png',
                                    fit: BoxFit.cover,
                                  );

                                  // post(
                                  //   Uri.parse(
                                  //       "https://0248-35-202-217-147.ngrok-free.app/personImage"),
                                  //   headers: <String, String>{
                                  //     'Content-Type':
                                  //         'application/json; charset=UTF-8',
                                  //   },
                                  //   body: jsonEncode(
                                  //     <String, String>{
                                  //       "img": imageData.toString().substring(
                                  //           1, imageData.toString().length - 1),
                                  //     },
                                  //   ),
                                  // );
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Response response =
                                      await post(Uri.parse("$api/runModel/"),
                                          headers: <String, String>{
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: jsonEncode(<String, String>{
                                            'cloth': url1,
                                            'person': personImageDownloadURL
                                            // "https://firebasestorage.googleapis.com/v0/b/raidiologist-54507.appspot.com/o/origin_web.jpg?alt=media&token=68141d47-6cd3-4703-9050-6a8ca201e2bb",
                                          })).onError((error, stackTrace) {
                                    print(error.toString());
                                    print(stackTrace.toString());
                                    return Response('Failed', 500);
                                  });
                                  if (response.body == "done") {
                                    print("done");
                                  } else {
                                    print("Failed");
                                  }

                                  await loadResultingImage();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  // child: Image.network("$api/getImage/"),

                                  // Future<void> _loadImage() async {
                                  //   var response = await http.get(Uri.parse('https://example.com/image.jpg'));
                                  //   setState(() {
                                  //     imageBytes = response.bodyBytes;
                                  //   });
                                  // }
                                  // post(
                                  //   Uri.parse(
                                  //       "http://df77-35-221-27-77.ngrok.io/clothImage"),

                                  //   // Uri.parse(
                                  //   // "http://535d-35-201-199-70.ngrok.io/clothImage"),
                                  //   headers: <String, String>{
                                  //     'Content-Type':
                                  //         'application/json; charset=UTF-8',
                                  //   },
                                  //   body: jsonEncode(
                                  //     <String, String>{
                                  //       "img": clothImageInBytes
                                  //           .toString()
                                  //           .substring(
                                  //               1,
                                  //               clothImageInBytes
                                  //                       .toString()
                                  //                       .length -
                                  //                   1),
                                  //     },
                                  //   ),
                                  // ),
                                },
                                child: Text('Try on',
                                    style: TextStyle(
                                      color: mainTextColor,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: mainBackgroundColor,
                  ),
                  height: (currentHeight * 30) / 100,
                  width: (currentWidth * 37) / 100,
                  child: Card(
                    // width
                    color: secondaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: mainTextColor,
                        width: 0.3,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: mainTextColor,
                                    ),
                                height: (currentHeight * 31) / 100,
                                width: (currentWidth * 15) / 100,
                                child: Image.asset(
                                  'images/item3.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            SizedBox(
                              // height: (currentHeight * 1) / 100,
                              width: (currentWidth * 0.5) / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text('Blue Floral Top',
                                            style: TextStyle(
                                                color: mainTextColor,
                                                fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('A cotton shirt',
                                        style: TextStyle(
                                            color: mainTextColor,
                                            fontSize: 15)),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(4.0),
                                  //       child: Text('Size: ',
                                  //           style: TextStyle(
                                  //               color: mainTextColor,
                                  //               fontSize: 15)),
                                  //     ),
                                  //     Container(
                                  //       height: currentHeight * 5 / 100,
                                  //       width: currentWidth * 6 / 100,
                                  //       decoration: BoxDecoration(
                                  //         color: secondaryBackgroundColor,
                                  //       ),
                                  //       child: DropdownButton(
                                  //         // Initial Value
                                  //         value: shirtSizes,
                                  //         dropdownColor:
                                  //             secondaryBackgroundColor,
                                  //         style: TextStyle(
                                  //             color: mainTextColor,
                                  //             fontSize: 15),
                                  //         // Down Arrow Icon
                                  //         icon: const Icon(
                                  //           Icons.arrow_drop_down,
                                  //           color: mainTextColor,
                                  //         ),

                                  //         // Array list of items
                                  //         items: items.map((String items) {
                                  //           return DropdownMenuItem(
                                  //             value: items,
                                  //             child: Text(
                                  //               items,
                                  //               style: TextStyle(
                                  //                   color: mainTextColor,
                                  //                   fontSize: 15),
                                  //             ),
                                  //           );
                                  //         }).toList(),
                                  //         // After selecting the desired option,it will
                                  //         // change button value to selected value
                                  //         onChanged: (String? shirtSize) {
                                  //           setState(() {
                                  //             shirtSizes = shirtSize!;
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: currentHeight * 10 / 100,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: currentWidth * 10 / 100,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            height: currentHeight * 5 / 100,
                            width: currentWidth * 8 / 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainButtonsColor,
                                ),
                                onPressed: () async {
                                  // clothImageBytes =
                                  //     await rootBundle.load('images/item3.png');
                                  // clothImageInBytes =
                                  //     clothImageBytes.buffer.asUint8List();
                                  Image.asset(
                                    'images/item3.png',
                                    fit: BoxFit.cover,
                                  );
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Response response = await post(
                                      Uri.parse("$api/runModel/"),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, String>{
                                        'cloth': url2,
                                        'person': personImageDownloadURL
                                      })).onError((error, stackTrace) {
                                    print(error.toString());
                                    print(stackTrace.toString());
                                    return Response('Failed', 500);
                                  });
                                  if (response.body == "done") {
                                    print("done");
                                  } else {
                                    print("Failed");
                                  }

                                  await loadResultingImage();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                child: Text('Try on',
                                    style: TextStyle(
                                      color: mainTextColor,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: mainBackgroundColor,
                  ),
                  height: (currentHeight * 30) / 100,
                  width: (currentWidth * 37) / 100,
                  child: Card(
                    // width
                    color: secondaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: mainTextColor,
                        width: 0.3,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: mainTextColor,
                                    ),
                                height: (currentHeight * 31) / 100,
                                width: (currentWidth * 15) / 100,
                                child: Image.asset(
                                  'images/item4.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              // height: (currentHeight * 1) / 100,
                              width: (currentWidth * 0.5) / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text('Blue Floral Top',
                                            style: TextStyle(
                                                color: mainTextColor,
                                                fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('A cotton shirt',
                                        style: TextStyle(
                                            color: mainTextColor,
                                            fontSize: 15)),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(4.0),
                                  //       child: Text('Size: ',
                                  //           style: TextStyle(
                                  //               color: mainTextColor,
                                  //               fontSize: 15)),
                                  //     ),
                                  //     Container(
                                  //       height: currentHeight * 5 / 100,
                                  //       width: currentWidth * 6 / 100,
                                  //       decoration: BoxDecoration(
                                  //         color: secondaryBackgroundColor,
                                  //       ),
                                  //       child: DropdownButton(
                                  //         // Initial Value
                                  //         value: shirtSizes,
                                  //         dropdownColor:
                                  //             secondaryBackgroundColor,
                                  //         style: TextStyle(
                                  //             color: mainTextColor,
                                  //             fontSize: 15),
                                  //         // Down Arrow Icon
                                  //         icon: const Icon(
                                  //           Icons.arrow_drop_down,
                                  //           color: mainTextColor,
                                  //         ),

                                  //         // Array list of items
                                  //         items: items.map((String items) {
                                  //           return DropdownMenuItem(
                                  //             value: items,
                                  //             child: Text(
                                  //               items,
                                  //               style: TextStyle(
                                  //                   color: mainTextColor,
                                  //                   fontSize: 15),
                                  //             ),
                                  //           );
                                  //         }).toList(),
                                  //         // After selecting the desired option,it will
                                  //         // change button value to selected value
                                  //         onChanged: (String? shirtSize) {
                                  //           setState(() {
                                  //             shirtSizes = shirtSize!;
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: currentHeight * 10 / 100,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: currentWidth * 10 / 100,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            height: currentHeight * 5 / 100,
                            width: currentWidth * 8 / 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainButtonsColor,
                                ),
                                onPressed: () async {
                                  // clothImageBytes =
                                  //     await rootBundle.load('images/item4.png');
                                  // clothImageInBytes =
                                  //     clothImageBytes.buffer.asUint8List();
                                  Image.asset(
                                    'images/item4.png',
                                    fit: BoxFit.fitHeight,
                                  );
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Response response = await post(
                                      Uri.parse("$api/runModel/"),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, String>{
                                        'cloth': url3,
                                        'person': personImageDownloadURL
                                      })).onError((error, stackTrace) {
                                    print(error.toString());
                                    print(stackTrace.toString());
                                    return Response('Failed', 500);
                                  });
                                  if (response.body == "done") {
                                    print("done");
                                  } else {
                                    print("Failed");
                                  }

                                  await loadResultingImage();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                child: Text('Try on',
                                    style: TextStyle(
                                      color: mainTextColor,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: mainBackgroundColor,
                  ),
                  height: (currentHeight * 30) / 100,
                  width: (currentWidth * 37) / 100,
                  child: Card(
                    // width
                    color: secondaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: mainTextColor,
                        width: 0.3,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: mainTextColor,
                                    ),
                                height: (currentHeight * 31) / 100,
                                width: (currentWidth * 15) / 100,
                                child: Image.asset(
                                  'images/item5.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              // height: (currentHeight * 1) / 100,
                              width: (currentWidth * 0.5) / 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text('Blue Floral Top',
                                            style: TextStyle(
                                                color: mainTextColor,
                                                fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('A cotton shirt',
                                        style: TextStyle(
                                            color: mainTextColor,
                                            fontSize: 15)),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.all(4.0),
                                  //       child: Text('Size: ',
                                  //           style: TextStyle(
                                  //               color: mainTextColor,
                                  //               fontSize: 15)),
                                  //     ),
                                  //     Container(
                                  //       height: currentHeight * 5 / 100,
                                  //       width: currentWidth * 6 / 100,
                                  //       decoration: BoxDecoration(
                                  //         color: secondaryBackgroundColor,
                                  //       ),
                                  //       child: DropdownButton(
                                  //         // Initial Value
                                  //         value: shirtSizes,
                                  //         dropdownColor:
                                  //             secondaryBackgroundColor,
                                  //         style: TextStyle(
                                  //             color: mainTextColor,
                                  //             fontSize: 15),
                                  //         // Down Arrow Icon
                                  //         icon: const Icon(
                                  //           Icons.arrow_drop_down,
                                  //           color: mainTextColor,
                                  //         ),

                                  //         // Array list of items
                                  //         items: items.map((String items) {
                                  //           return DropdownMenuItem(
                                  //             value: items,
                                  //             child: Text(
                                  //               items,
                                  //               style: TextStyle(
                                  //                   color: mainTextColor,
                                  //                   fontSize: 15),
                                  //             ),
                                  //           );
                                  //         }).toList(),
                                  //         // After selecting the desired option,it will
                                  //         // change button value to selected value
                                  //         onChanged: (String? shirtSize) {
                                  //           setState(() {
                                  //             shirtSizes = shirtSize!;
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: currentHeight * 10 / 100,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: currentWidth * 10 / 100,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            height: currentHeight * 5 / 100,
                            width: currentWidth * 8 / 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainButtonsColor,
                                ),
                                onPressed: () async {
                                  // clothImageBytes =
                                  //     await rootBundle.load('images/item5.png');
                                  // clothImageInBytes =
                                  //     clothImageBytes.buffer.asUint8List();
                                  Image.asset(
                                    'images/item5.png',
                                    fit: BoxFit.fitHeight,
                                  );
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Response response =
                                      await post(Uri.parse("$api/runModel/"),
                                          headers: <String, String>{
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: jsonEncode(<String, String>{
                                            'cloth':
                                                "https://firebasestorage.googleapis.com/v0/b/traion-9e904.appspot.com/o/Clothings%2Fitem5.png?alt=media&token=510d1150-ec52-4064-9023-c5065751fcde",
                                            'person': personImageDownloadURL
                                          })).onError((error, stackTrace) {
                                    print(error.toString());
                                    print(stackTrace.toString());
                                    return Response('Failed', 500);
                                  });
                                  if (response.body == "done") {
                                    print("done");
                                  } else {
                                    print("Failed");
                                  }

                                  await loadResultingImage();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                child: Text('Try on',
                                    style: TextStyle(
                                      color: mainTextColor,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: currentHeight * 91 / 100,
            width: currentWidth * 51 / 100,
            decoration: BoxDecoration(
              color: secondaryBackgroundColor,
              border: Border.all(color: mainTextColor, width: 0.2),
            ),

            child: _isLoading
                ? Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()))
                : selectedImageInBytes == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DottedBorder(
                              color: mainTextColor, //color of dotted/dash line
                              strokeWidth: 0.3, //thickness of dash/dots
                              dashPattern: [7, 3],
                              radius: Radius.circular(10),

                              child: Container(
                                height: currentHeight * 8 / 100,
                                width: currentWidth * 15 / 100,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    //*************API
                                    //*************API
                                    //*************API
                                    //*************API
                                    // Response response =
                                    //     await post(Uri.parse("$api/runModel/"),
                                    //         headers: <String, String>{
                                    //           'Content-Type':
                                    //               'application/json; charset=UTF-8',
                                    //         },
                                    //         body: jsonEncode(<String, String>{
                                    //           'cloth':
                                    //               "https://firebasestorage.googleapis.com/v0/b/raidiologist-54507.appspot.com/o/cloth_web.jpg?alt=media&token=19f9f43e-7aee-4210-83c0-80bd848991f3",
                                    //           'person':
                                    //               "https://firebasestorage.googleapis.com/v0/b/raidiologist-54507.appspot.com/o/origin_web.jpg?alt=media&token=68141d47-6cd3-4703-9050-6a8ca201e2bb",
                                    //         })).onError((error, stackTrace) {
                                    //   print(error.toString());
                                    //   print(stackTrace.toString());
                                    //   return Response('Failed', 500);
                                    // });
                                    // if (response.body == "done") {
                                    //   print("done");
                                    // } else {
                                    //   print("Failed");
                                    // }
                                    _selectFile(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainButtonsColor,
                                  ),
                                  icon:
                                      Icon(Icons.add_photo_alternate_outlined),
                                  label: Text('Upload your photo',
                                      style: TextStyle(
                                        color: mainTextColor,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DottedBorder(
                              color: mainTextColor, //color of dotted/dash line
                              strokeWidth: 0.3, //thickness of dash/dots
                              dashPattern: [7, 3],
                              radius: Radius.circular(10),

                              child: Stack(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: currentHeight * 8 / 100,
                                        width: currentWidth * 15 / 100,
                                        decoration: BoxDecoration(
                                          color: mainButtonsColor,
                                        ),
                                        child: DropzoneView(
                                          onCreated: (controller) =>
                                              this.controller = controller,
                                          onDrop: (file) async {
                                            final data =
                                                await _readFileData(file);
                                            setState(() {
                                              selectedImageInBytes = data;
                                              imageData = data;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25, top: 15),
                                        child: Icon(
                                          Icons.filter,
                                          color: mainTextColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 54, top: 18),
                                        child: Text(
                                          'Drop image file here',
                                          style: TextStyle(
                                            color: mainTextColor,
                                          ),
                                        ),
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   children: [
                                      //     Icon(
                                      //       Icons.filter,
                                      //       color: mainTextColor,
                                      //     ),
                                      //     Text('Drop image file here',
                                      //         style: TextStyle(
                                      //           color: mainTextColor,
                                      //         ))
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  // Container(
                                  //   height: currentHeight * 8 / 100,
                                  //   width: currentWidth * 15 / 100,
                                  //   child: DropzoneView(
                                  //     child: ElevatedButton.icon(
                                  //       onPressed: () => {},
                                  //       style: ElevatedButton.styleFrom(
                                  //         backgroundColor: mainButtonsColor,
                                  //       ),
                                  //       icon: Icon(Icons.filter),
                                  //       label: Text('Drag and Drop here',
                                  //           style: TextStyle(
                                  //             color: mainTextColor,
                                  //           )),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   child: selectFile.isEmpty
//                          //       ? Image.asset('images/item1.png')//
                          //       : ImageZoomOnMove(
                          //           cursor: SystemMouseCursors.grab,
                          //           image: Image.memory(selectedImageInBytes!),
                          //         ),
                          // ),
                        ],
                      )
                    : ImageZoomOnMove(
                        cursor: SystemMouseCursors.grab,
                        image: Image.memory(selectedImageInBytes!)),

            // child:
            // ImageZoomOnMove(
            //     cursor: SystemMouseCursors.grab,
            //     image: Image.memory(imageBytes!),
            //   ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, top: 0.0, bottom: 0.0),
            child: Container(
              height: currentHeight * 65.15 / 100,
              width: currentWidth * 8 / 100,
              decoration: BoxDecoration(
                border: Border.all(color: mainTextColor, width: 0.2),
                color: secondaryBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),

                  // borderC
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        // decoration: BoxDecoration(color: mainBackgroundColor),
                        height: 65,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Iconify.iconName("mdi-home"),

                              // Svg('icons/reset-image'),
                              IconButton(
                                onPressed: () => {
                                  selectedImageInBytes = null,
                                  imageData != null,
                                  setState(() {}),
                                },
                                icon: Icon(
                                  Icons.settings_backup_restore_outlined,
                                  size: 30,
                                  color: mainTextColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 2),
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                      color: mainTextColor, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: mainTextColor,
                    thickness: 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        height: 65,
                        child: Center(
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  _selectFile(true);
                                  // final events = await controller.pickFiles();
                                  // if (events.isEmpty) return;
                                  // _acceptFile(events.first);
                                },
                                icon: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 30,
                                  color: mainTextColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 2),
                                child: Text(
                                  'Upload',
                                  style: TextStyle(
                                      color: mainTextColor, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: mainTextColor,
                    thickness: 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        height: 65,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final blob = Blob([imageData], 'image/png');
                                    final url =
                                        Url.createObjectUrlFromBlob(blob);
                                    final anchor = document.createElement('a')
                                        as AnchorElement
                                      ..href = url
                                      ..download = 'tryonResult.png';
                                    document.body!.append(anchor);
                                    anchor.click();
                                    Url.revokeObjectUrl(url);
                                  },
                                  //
                                  //onPressed: () => {
                                  // if (imageData != null)
                                  // {
                                  // Convert the image data to a Blob
                                  // imageBlob = Blob([imageData], 'image/png'),
                                  //  FileSaver.saveAs(imageData, 'image.png');
                                  // } // Save the image to the user's gallery using file_saver
                                  // await FileSaver.saveAs(imageBlob, 'image.png');
                                  // },
                                  icon: Icon(
                                    Icons.save_alt_outlined,
                                    size: 30,
                                    color: mainTextColor,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 2),
                                  child: Text(
                                    'Download',
                                    style: TextStyle(
                                        color: mainTextColor, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: mainTextColor,
                    thickness: 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => {},
                      child: Container(
                        height: 65,
                        child: Center(
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () => {
                                  setState(() {
                                    imageData != null;
                                    selectedImageInBytes = null;
                                  }),
                                },
                                icon: Icon(
                                  Icons.delete_outlined,
                                  size: 30,
                                  color: mainTextColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 2),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: mainTextColor, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: mainTextColor,
                    thickness: 0.3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // appBar: Appbar(Title(color: mainTextColor, child: Text("trAIon"))),
    );
  }

// Future<void> saveImageToGallery() async {
//   // Pick the image from the container using image_picker_web
//   final Uint8List? imageData = await ImagePickerWeb.getImage(outputType: ImageType.bytes);

//   if (imageData != null) {
//     // Convert the image data to a Blob
//     final imageBlob = Blob([imageData], 'image/png');

//     // Save the image to the user's gallery using file_saver
//     await FileSaver.saveAs(imageBlob, 'image.png');
//   }
}
