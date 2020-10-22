import 'dart:ui';
import 'package:example_meme_generator/green_footer.dart';
import 'package:example_meme_generator/medicos.dart';
import 'package:example_meme_generator/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.orange,
      primaryColor: Colors.purple,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _darkTheme,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18.0,
              left: 18.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/memegenratorF.png",
                  height: 70,
                ),
                SizedBox(
                  height: 30,
                ),
                buildCardWidget(Colors.amber, 'Posts', Posts(), 'assets/bg01.png'),
                buildCardWidget(Colors.green, 'Médicos', Medicos(), 'assets/medicos.png'),
                buildCardWidget(Colors.deepOrange, 'Posts', GreenFooter(), 'assets/bg03.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildCardWidget(Color _color, String texto, Widget page, String imageasset) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(_color.withOpacity(0.9), BlendMode.color),
                    image: AssetImage(imageasset),
                      )),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  child: Center(
                      child: Text(
                    texto,
                    style: GoogleFonts.fredokaOne(
                                fontWeight: FontWeight.w500,
                                fontSize: 32,
                                color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
