import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:example_meme_generator/controllers/obter_imagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/salvar_imagem.dart';

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
  double mxFontSize = 39;
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
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 3,
                          top: MediaQuery.of(context).size.height / 8),
                      width: MediaQuery.of(context).size.width / 2,
                      child: AspectRatio(
                        aspectRatio: _switchValue ? 1.0 : 1.9,
                        child: _image != null
                            ? Image.file(_image, fit: BoxFit.cover)
                            : Container(),
                      ),
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

                    Container(
                      width: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
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
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),

                          // nome do médico
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              //color: Colors.white,
                            ),
                            child: Center(
                              child: AutoSizeText(
                                centerText.toUpperCase(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                maxFontSize: mxFontSize,
                                style: GoogleFonts.fredokaOne(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 40,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
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
                        ],
                      ),
                    ),

                    // texto de data
                    (headerText.length > 0)
                        ? Positioned(
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
                          )
                        : Container(),

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
                                hintText: "Nome do Médico"),
                          ),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                headerText = val;
                              });
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                hintText: "Data de atendimento"),
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
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                crmText = val;
                              });
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.category), hintText: "CRM"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Switch(
                                  value: _switchValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _switchValue = newValue;
                                    });
                                  }),
                              ElevatedButton(
                                onPressed: () async {
                                  _imageFile =  await SalvarImage().takeScreenshot(globalKey);
                                  showDialog(context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                    title: Text('Imagem salva!'),
                                    content: Text('Verique sua galeria '),
                                    actions: [
                                      TextButton(onPressed: (){
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
