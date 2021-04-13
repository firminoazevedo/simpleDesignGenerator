import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:example_meme_generator/controllers/obter_imagem.dart';
import 'package:example_meme_generator/controllers/salvar_imagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class GreenFooter extends StatefulWidget {
  @override
  _GreenFooterState createState() => _GreenFooterState();
}

class _GreenFooterState extends State<GreenFooter> {
  final GlobalKey globalKey = GlobalKey();
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
                    // Textos
                    Positioned(
                      top: MediaQuery.of(context).size.width / 1.75,
                      left: 70,
                      right: 70,
                      bottom: 20,
                      child: Column(
                        children: [
                          // especialidade
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                centerText.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                wrapWords: false,
                                overflow: TextOverflow.visible,
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

                          // Nome do Médico
                          if (!headerText.isEmpty)
                          Container(
                            padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: Colors.white),
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
                          ) ,
                          // Registro no conselho
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
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Divider(),
              imageSelected
                  ? Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                        children: <Widget>[
                          Container(
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
                                      hintText: "Especialidade"),
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
                                      hintText: "Conselho regional"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RaisedButton(
                                      onPressed: () async {
                                        _imageFile =  await SalvarImage().takeScreenshot(globalKey);
                                        showDialog(context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                          title: Text('Imagem salva!'),
                                          content: Text('Verique sua galeria '),
                                          actions: [
                                            FlatButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: Text('Fechar'))
                                          ],
                                        ));
                                        setState(() {
                                          
                                        });
                                      },
                                      child: Text("Salvar"),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
        onPressed: () async {
          try {
            _image = await ObterImagem().getImage();
            setState(() {
              imageSelected = true;
            });
          } catch (e) {
            }
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
