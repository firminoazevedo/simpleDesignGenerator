import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:example_meme_generator/controllers/obter_imagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/salvar_imagem.dart';

class Parabens extends StatefulWidget {
  @override
  _ParabensState createState() => _ParabensState();
}

class _ParabensState extends State<Parabens> {
  final GlobalKey globalKey = new GlobalKey();

  String bg = "assets/parabens.jpg";
  String headerText = "";
  String footerText = "";
  String centerText = "";

  int mxLine = 1;

  double mxFontSize = 30;

  double txtTopMargin;

  double imageRatio = 1.0;

  bool _switchValue = true;

  File _image;
  File _imageFile;

  bool imageSelected = false;

  Random rng = new Random();

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
                  alignment: Alignment.center,
                  children: <Widget>[
                    // image background
                    _image != null
                        ? AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.asset(
                              bg,
                            ),
                          )
                        : Container(),

                    //
                    //
                    Column(
                      children: [
                        _image != null
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.41,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(_image))),
                              )
                            : Container(),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.003,
                        ),

                        // Nome do aniversariante
                        Center(
                          child: AutoSizeText(
                            centerText,
                            textAlign: TextAlign.center,
                            maxLines: mxLine,
                            maxFontSize: mxFontSize *
                                MediaQuery.of(context).textScaleFactor,
                            style: GoogleFonts.fredokaOne(
                              fontWeight: FontWeight.w500,
                              fontSize: mxFontSize *
                                  MediaQuery.of(context).textScaleFactor,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            onChanged: (val) {
                              if (val.length > 13) {
                                setState(() {
                                  mxFontSize--;
                                  mxLine = 2;
                                });
                              } else {
                                mxFontSize = 35;
                                mxLine = 1;
                              }
                              setState(() {
                                centerText = val;
                              });
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.text_fields),
                                hintText: "Nome"),
                          ),

                          /*TextField(
                            
                            onChanged: (val) {
                              setState(() {
                                headerText = val;
                              });
                            },
                            decoration:
                                InputDecoration(
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
                            decoration:
                                InputDecoration(
                                  icon: Icon(Icons.mode_edit),
                                  hintText: "Especialidade"),
                          ),
                          SizedBox(
                            height: 20,
                          ), */

                          SizedBox(
                            height: 50,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _imageFile = await SalvarImage()
                                      .takeScreenshot(globalKey);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text('Imagem salva!'),
                                            content:
                                                Text('Verique sua galeria '),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Fechar'))
                                            ],
                                          ));
                                  setState(() {});
                                },
                                child: Text("Salvar"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
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
      //  FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _image = await ObterImagem().getImage();
          setState(() {
            imageSelected = true;
          });
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
}
