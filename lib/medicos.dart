import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Medicos extends StatefulWidget {
  @override
  _MedicosState createState() => _MedicosState();
}

class _MedicosState extends State<Medicos> {


  final GlobalKey globalKey = new GlobalKey();

  String bg = "assets/medicos.png";
  String headerText = "";
  String footerText = "";
  String centerText = "";
  String crmText = "";

  int mxLine = 1;

  double mxFontSize = 36;

  double txtTopMargin;

  double imageRatio = 1.0;

  bool _switchValue = true;

  File _image;
  File _imageFile;

  bool imageSelected = false;

  Random rng = new Random();

  Future getImage() async {
    var image;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (platformException) {
      print("not allowing " + platformException);
    }
    setState(() {
      if (image != null) {
        imageSelected = true;
      } else {}
      _image = image;
    });
    
    new Directory('storage/emulated/0/' + 'MemeGenerator')
        .create(recursive: true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicos'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/3,
                                              top: MediaQuery.of(context).size.height/7
                                                    ),
                      width: MediaQuery.of(context).size.width/2,
                      child: AspectRatio(
                        aspectRatio: _switchValue ? 1.0 : 1.7,
                        child: _image != null
                            ? Image.file(_image, fit: BoxFit.cover)
                            : Container(),
                      ),
                    ),

                    // image background
                    _image != null ? AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(
                        bg,
                      ),
                    ) : Container(),

                    // texto de especialidade
                    Positioned(
                      top: 15,
                      left: 10,
                      right: 190,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(),
                        child: Center(
                          child: AutoSizeText(
                            footerText.toUpperCase(),
                            maxLines: 1,
                            style: GoogleFonts.abel(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),


                    // texto de especialidade especifica
                    Positioned(
                      top: 65,
                      left: 10,
                      right: 190,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(),
                        child: Center(
                          child: AutoSizeText(
                            crmText.toUpperCase(),
                            maxLines: 1,
                            style: GoogleFonts.abel(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    

                    Positioned(
                      top: 30,
                      left: 20,
                      right: 180,
                      bottom: 300,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          //color: Colors.white,
                        ),
                        child: Center(
                        child: AutoSizeText(
                          centerText.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          maxFontSize: mxFontSize,
                          style: GoogleFonts.fredokaOne(
                              fontWeight: FontWeight.w500,
                              fontSize: mxFontSize,
                              color: Colors.white),
                        ),
                          ),
                      ),
                    ),

                    // texto do meio
                    (headerText.length > 0) ?  Positioned(
                      top: 180,
                      left: 20,
                      right: 250,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 1, 6, 1),
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
                    ) : Container(),

                    
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

                              if (val.length > 13){
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
                            decoration:
                                InputDecoration(
                                  icon: Icon(Icons.text_fields),
                                  hintText: "Nome do Médico"),
                          ),

                          TextField(
                            
                            onChanged: (val) {
                              setState(() {
                                headerText = val;
                              });
                            },
                            decoration:
                                InputDecoration(
                                  icon: Icon(Icons.calendar_today),
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
                            decoration:
                                InputDecoration(
                                  icon: Icon(Icons.mode_edit),
                                  hintText: "Especialidade"),
                          ),

                          TextField(
                            onChanged: (val) {
                              setState(() {
                                crmText = val;
                              });
                            },
                            decoration:
                                InputDecoration(
                                  icon: Icon(Icons.category),
                                  hintText: "CRM"),
                          ), 
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Switch(
                              value: _switchValue,
                              onChanged: (newValue){
                                setState(() {
                                  _switchValue = newValue;
                                });
                              }),
                              
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
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage( pixelRatio: 2.2);
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