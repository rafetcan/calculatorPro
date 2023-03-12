import 'package:calculator/colors.dart';
import 'package:calculator/service/admob_service.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:unicons/unicons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> buttonList = [
    "AC",
    "+/-",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "t",
    "0",
    ".",
    "="
  ];

  bool isDark = false;
  ThemeData get theme => isDark
      ? ThemeData.dark().copyWith(
          scaffoldBackgroundColor: darkBgColor,
        )
      : ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
        );
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  Widget buildButton(
      {required String buttonText, bool isIcon = false, color = Colors.black}) {
    return GestureDetector(
      onTap: () => buttonPressed(buttonText),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? darkButtonColor : lightButtonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: isIcon
              ? Icon(
                  Icons.undo,
                  color: isDark ? Colors.white : Colors.black,
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                      color: color, fontSize: 25, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "t") {
        // equation = "0";
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget sonucAltiKisim() {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? lightDarkBgColor : lightBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      padding: const EdgeInsets.all(17),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: GridView.builder(
          primary: false,
          itemCount: buttonList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4),
          itemBuilder: (context, index) {
            if (index == 0 || index == 1 || index == 2) {
              return buildButton(
                  buttonText: buttonList[index], color: tealColor);
            }
            if (index == 3 ||
                index == 7 ||
                index == 11 ||
                index == 15 ||
                index == 19) {
              return buildButton(
                  buttonText: buttonList[index], color: redColor);
            }
            if (index == 16) {
              return buildButton(buttonText: buttonList[index], isIcon: true);
            }
            return buildButton(
                buttonText: buttonList[index],
                color: isDark ? Colors.white : Colors.black);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _createBannerAd();
  }

  BannerAd? _bannerAd;
  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: 'Calculator Pro',
      home: SafeArea(
        child: Scaffold(
          // !! Reklam Alanı Kaldırıldı
          // bottomNavigationBar: _bannerAd == null
          //     ? Container()
          //     : Container(
          //         margin: const EdgeInsets.only(bottom: 12),
          //         height: 52,
          //         child: AdWidget(ad: _bannerAd!),
          //       ),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(width: 50),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: isDark ? lightDarkBgColor : lightBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                            });
                          },
                          icon: Icon(
                            UniconsLine.brightness,
                            color: !isDark
                                ? Theme.of(context).iconTheme.color!
                                : Colors.white.withOpacity(0.2),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                            });
                          },
                          icon: Icon(
                            UniconsLine.moon,
                            color: isDark
                                ? Colors.white
                                : Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(top: 15),
                  //   decoration: BoxDecoration(
                  //     color: isDark ? lightDarkBgColor : lightBgColor,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       UniconsLine.info,
                  //       color: isDark
                  //           ? Colors.white
                  //           : Theme.of(context)
                  //               .iconTheme
                  //               .color!
                  //               .withOpacity(0.2),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  equation,
                  style: TextStyle(fontSize: equationFontSize),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(10),
                child: Text(
                  result,
                  style: TextStyle(fontSize: resultFontSize),
                ),
              ),
              // const Spacer(),
              Expanded(child: sonucAltiKisim()),
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   color: Colors.green[900],
              //   // height: 20,
              //   child: Center(
              //     child: Text(
              //       "Reklam Alanı",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 50,
              //           color: isDark
              //               ? Colors.black
              //               : Theme.of(context)
              //                   .iconTheme
              //                   .color!
              //                   .withOpacity(0.8)),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// List<String> buttonList = [
//   "AC",
//   "+/-",
//   "%",
//   "÷",
//   "7",
//   "8",
//   "9",
//   "×",
//   "4",
//   "5",
//   "6",
//   "-",
//   "1",
//   "2",
//   "3",
//   "+",
//   "t",
//   "0",
//   ".",
//   "="
// ];
