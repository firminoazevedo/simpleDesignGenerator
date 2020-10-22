import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GreenFooter extends StatefulWidget {
  @override
  _GreenFooterState createState() => _GreenFooterState();
}

class _GreenFooterState extends State<GreenFooter> {
  final GlobalKey globalKey = new GlobalKey();

  String bg = "assets/bg03.png";
  String headerText = "";
  String footerText = "";
  String centerText = "";

  int mxLine = 1;

  double mxFontSize = 42;

  double txtTopMargin;

  double imageRatio = 1.0;

  bool _switchValue = true;

  File _image;
  File _imageFile;

  bool imageSelected = false;

  Random rng = new Random();

  Future getImage() async {
    var image;
    var croppedFile;
    try {
      image = await ImagePicker.pickImage(
          source: ImageSource.gallery); // Obter imagem da galeria
      // Cortar imagem
      croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cortar',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
    } catch (platformException) {
      print("NÃO PERMITIDO " + platformException);
    }

    setState(() {
      if (image != null) {
        imageSelected = true;
      } else {}
      _image = croppedFile;
    });
    new Directory('storage/emulated/0/' + 'MemeGenerator')
        .create(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: _switchValue ? 1.0 : 1.7,
                      child: _image != null
                          ? Image.file(_image, fit: BoxFit.cover)
                          : Container(),
                    ),

                    // image background
                    _image != null
                        ? AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.asset(
                              bg,
                            ),
                          )
                        : Container(),

                    Positioned(
                      top: MediaQuery.of(context).size.width / 1.75,
                      left: 80,
                      right: 80,
                      bottom: 0,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              //color: Colors.white,
                            ),
                            child: Center(
                              child: AutoSizeText(
                                centerText.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: mxLine,
                                maxFontSize: mxFontSize,
                                style: GoogleFonts.fredokaOne(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 3.0,
                                        color: Colors.grey,
                                      ),
                                      Shadow(
                                        offset: Offset(6, 6),
                                        blurRadius: 8.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                    fontWeight: FontWeight.w500,
                                    fontSize: mxFontSize,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: AutoSizeText(
                                headerText,
                                maxLines: 1,
                                style: GoogleFonts.oleoScript(
                                    //fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color.fromRGBO(11, 56, 40, 1)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(),
                            child: Center(
                              child: AutoSizeText(
                                footerText.toUpperCase(),
                                maxLines: 1,
                                style: GoogleFonts.abel(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //buildText(headerText),
                          Spacer(),
                          //buildText(footerText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              imageSelected
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            onChanged: (val) {
                              if (val.length > 13) {
                                setState(() {
                                  mxFontSize = 24;
                                  mxLine = 2;
                                });
                              } else {
                                mxFontSize = 42;
                                mxLine = 1;
                              }
                              setState(() {
                                centerText = val;
                              });
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.text_fields),
                                hintText: "Texto central"),
                          ),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                headerText = val;
                              });
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.account_circle),
                                hintText: "Nome do Profissional"),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                footerText = val;
                              });
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.mode_edit),
                                hintText: "Especialidade"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  takeScreenshot();
                                },
                                child: Text("Salvar"),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text("Clique no botão adicionar imagem"),
                      ),
                    ),
              _imageFile != null ? Image.file(_imageFile) : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget buildText(String text) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ));
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 2.2);
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    //print(pngBytes);
    File imgFile = File('$directory/screenshot${rng.nextInt(200)}.png');
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile);
    //saveFileLocal();
    imgFile.writeAsBytes(pngBytes);
  }

  _savefile(File file) async {
    await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
  }

  _askPermission() async {
    // ignore: unused_local_variable
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions(
            [PermissionGroup.photos, PermissionGroup.storage]);
  }
}
