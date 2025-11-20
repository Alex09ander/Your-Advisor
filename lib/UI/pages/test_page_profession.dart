import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:your_advisor/UI/custom_widgets/custom_circle_btn.dart';
import 'package:your_advisor/UI/custom_widgets/progress_bar.dart';
import 'package:your_advisor/domain/app_colors.dart';

import '../../domain/app_routes.dart';
import '../custom_widgets/custom_rounded_btn.dart';

class TestPageProfession extends StatefulWidget {
  @override
  State<TestPageProfession> createState() => TestPageState();
}

class TestPageState extends State<TestPageProfession> {
  final myController = TextEditingController();

  String txt = "Dobrze odnajduję się w pracy grupowej";
  String btnNext = "Dalej";
  int btn = 0;
  int clickCount = 0;
  int answer1 = 0;
  int answer2 = 0;
  int answer3 = 0;
  int answer4 = 0;
  int answer5 = 0;
  int answer6 = 0;
  int answer7 = 0;
  int answer8 = 0;
  int answer9 = 0;
  int answer10 = 0;
  int answer11 = 0;
  int answer12 = 0;
  int answer13 = 0;
  int answer14 = 0;
  int answer15 = 0;
  int answer16 = 0;
  int answer17 = 0;
  int answer18 = 0;
  int answer19 = 0;
  int answer20 = 0;
  int answer21 = 0;
  int answer22 = 0;
  int answer23 = 0;

  String answer24 = "";
  String answer25 = "";
  String answer26 = "";
  String answer27 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ProgressBar(
              progress: (clickCount / 26) * 350,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: 120,
              width: 400,
              child: Text("$txt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'PatrickHand',
                      color: AppColors.textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            clickCount < 23
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomCircleBtn(
                                onTap: () {
                                  setState(() {
                                    if (btn == 1) {
                                      btn = 0;
                                    } else if (btn != 1) {
                                      btn = 1;
                                    }
                                  });
                                },
                                bgColor: AppColors.greenColor,
                                mRadius: 70,
                                isOutlined: btn != 1 ? true : false,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                                child: Text("Zdecydowanie się zgadzam",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'PatrickHand',
                                        color: AppColors.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: CustomCircleBtn(
                                  onTap: () {
                                    setState(() {
                                      if (btn == 2) {
                                        btn = 0;
                                      } else if (btn != 2) {
                                        btn = 2;
                                      }
                                    });
                                  },
                                  bgColor: AppColors.greenColor,
                                  mRadius: 60,
                                  isOutlined: btn != 2 ? true : false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(75, 0, 0, 0),
                                child: Text("Zgadzam się",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'PatrickHand',
                                        color: AppColors.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: CustomCircleBtn(
                                  onTap: () {
                                    setState(() {
                                      if (btn == 3) {
                                        btn = 0;
                                      } else if (btn != 3) {
                                        btn = 3;
                                      }
                                    });
                                  },
                                  bgColor: AppColors.greenColor,
                                  mRadius: 50,
                                  isOutlined: btn != 3 ? true : false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                                child: Text("Trochę się zgadzam",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'PatrickHand',
                                        color: AppColors.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: CustomCircleBtn(
                                  onTap: () {
                                    setState(() {
                                      if (btn == 4) {
                                        btn = 0;
                                      } else if (btn != 4) {
                                        btn = 4;
                                      }
                                    });
                                  },
                                  bgColor: AppColors.greyColor,
                                  mRadius: 40,
                                  isOutlined: btn != 4 ? true : false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
                                child: Text("Nie mam zdania",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'PatrickHand',
                                        color: AppColors.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: CustomCircleBtn(
                                  onTap: () {
                                    setState(() {
                                      if (btn == 5) {
                                        btn = 0;
                                      } else if (btn != 5) {
                                        btn = 5;
                                      }
                                    });
                                  },
                                  bgColor: AppColors.purpleColor,
                                  mRadius: 50,
                                  isOutlined: btn != 5 ? true : false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                                child: Text("Trochę się nie zgadzam",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'PatrickHand',
                                        color: AppColors.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: CustomCircleBtn(
                                  onTap: () {
                                    setState(() {
                                      if (btn == 6) {
                                        btn = 0;
                                      } else if (btn != 6) {
                                        btn = 6;
                                      }
                                    });
                                  },
                                  bgColor: AppColors.purpleColor,
                                  mRadius: 60,
                                  isOutlined: btn != 6 ? true : false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(75, 0, 0, 0),
                                child: Text("Nie zgadzam się",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'PatrickHand',
                                        color: AppColors.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: CustomCircleBtn(
                                  onTap: () {
                                    setState(() {
                                      if (btn == 7) {
                                        btn = 0;
                                      } else if (btn != 7) {
                                        btn = 7;
                                      }
                                    });
                                  },
                                  bgColor: AppColors.purpleColor,
                                  mRadius: 70,
                                  isOutlined: btn != 7 ? true : false,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                                child: Text("Zdecydowanie się nie zgadzam",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'PatrickHand',
                                        color: AppColors.textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
                : Container(
                    width: 400,
                    child: TextField(
                      minLines: 5,
                      maxLines: 10,
                      controller: myController,
                      decoration: const InputDecoration(
                        hintMaxLines: 4,
                          labelText: "Wprowadź odpowiedź"),
                    ),
                  ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: CustomRoundedBtn(
                      text: "Wróć",
                      fontSize: 20,
                      mWidth: 160,
                      mHeight: 80,
                      textColor: AppColors.text2Color,
                      bgColor: AppColors.thirdColor,
                      onTap: () {
                        if (clickCount == 0) {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.menu_page);
                          });
                        }
                        else if (clickCount == 1) {
                          setState(() {
                            answer1 = 0;
                            txt = "Dobrze odnajduję się w pracy grupowej";
                            clickCount--;
                          });
                        }
                        else if (clickCount == 2) {
                          setState(() {
                            answer2 = 0;
                            txt = "Efektywniej pracuję, jeśli jestem sam";
                            clickCount--;
                          });
                        } else if (clickCount == 3) {
                          setState(() {
                            answer3 = 0;
                            txt =
                            "Lubię wykonywać drobne naprawy lub inne prace manualne";
                            clickCount--;
                          });
                        } else if (clickCount == 4) {
                          setState(() {
                            answer4 = 0;
                            txt = "Lubię/lubiłem pisać rozprawki lub prace naukowe";
                            clickCount--;
                          });
                        } else if (clickCount == 5) {
                          setState(() {
                            answer5 = 0;
                            txt =
                            "Jestem zaawansowany w ogólnej obsłudze komputera";
                            clickCount--;
                          });
                        } else if (clickCount == 6) {
                          setState(() {
                            answer6 = 0;
                            txt = "Mam wyczucie estetyki";
                            clickCount--;
                          });
                        } else if (clickCount == 7) {
                          setState(() {
                            answer7 = 0;
                            txt = "Lubię wyrażać swoją opinię";
                            clickCount--;
                          });
                        } else if (clickCount == 8) {
                          setState(() {
                            answer8 = 0;
                            txt = "Regularnie obcuję ze sztuką";
                            clickCount--;
                          });
                        } else if (clickCount == 9) {
                          setState(() {
                            answer9 = 0;
                            txt = "Umiem myśleć algorytmicznie";
                            clickCount--;
                          });
                        } else if (clickCount == 10) {
                          setState(() {
                            answer10 = 0;
                            txt = "Lubię rozwiązywać złożone problemy";
                            clickCount--;
                          });
                        } else if (clickCount == 11) {
                          setState(() {
                            answer11 = 0;
                            txt = "Chcę tworzyć coś dla innych użytkowników";
                            clickCount--;
                          });
                        } else if (clickCount == 12) {
                          setState(() {
                            answer12 = 0;
                            txt =
                            "Szybko uczę się języków obcych";
                            clickCount--;
                          });
                        } else if (clickCount == 13) {
                          setState(() {
                            answer13 = 0;
                            txt =
                            "Jestem sprawny fizycznie";
                            clickCount--;
                          });
                        } else if (clickCount == 14) {
                          setState(() {
                            answer14 = 0;
                            txt = "Cenię kontakt z naturą";
                            clickCount--;
                          });
                        } else if (clickCount == 15) {
                          setState(() {
                            answer15 = 0;
                            txt = "Szukam stabilności finansowej i bezpieczeństwa";
                            clickCount--;
                          });
                        } else if (clickCount == 16) {
                          setState(() {
                            answer16 = 0;
                            txt = "Preferuję pracę zdalną";
                            clickCount--;
                          });
                        } else if (clickCount == 17) {
                          setState(() {
                            answer17 = 0;
                            txt = "Jestem słaby w wystąpieniach publicznych i unikam ich";
                            clickCount--;
                          });
                        } else if (clickCount == 18) {
                          setState(() {
                            answer18 = 0;
                            txt =
                            "Bardzo cenię aspekt finansowy pracy";
                            clickCount--;
                          });
                        } else if (clickCount == 19) {
                          setState(() {
                            answer19 = 0;
                            txt =
                            "Chcę, by praca rozwijała mnie nawet kosztem zarobków";
                            clickCount--;
                          });
                        } else if (clickCount == 20) {
                          setState(() {
                            answer20 = 0;
                            txt =
                            "Dobrze wyciągam wnioski na podstawie danych";
                            clickCount--;
                          });
                        } else if (clickCount == 21) {
                          setState(() {
                            answer21 = 0;
                            txt =
                            "Interesuję się anatomią i pracą lekarzy";
                            clickCount--;
                          });
                        } else if (clickCount == 22) {
                          setState(() {
                            answer22 = 0;
                            txt =
                            "Mam dobrą pamięć do pojęć";
                            clickCount--;
                          });
                        } else if (clickCount == 23) {
                          setState(() {
                            answer23 = 0;
                            txt =
                            "Lubię brać udział w zorganizowanych projektach grupowych";
                            clickCount--;
                          });
                        } else if (clickCount == 24) {
                          setState(() {
                            answer24 = "";
                            txt = "Opisz sytuację z pracy, która dała Ci największą satysfakcję";
                            clickCount--;
                          });
                        } else if (clickCount == 25) {
                          setState(() {
                            answer25 = "Jakie umiejętności lub wiedzę chcesz rozwijać?";
                            clickCount--;
                            txt =
                            "Jaki byłby twój wymarzony partner życiowy?";
                          });
                        } else if (clickCount == 26) {
                          setState(() {
                            answer26 = "";
                            clickCount--;
                            txt =
                            "Czego unikasz lub się obawiasz w pracy?";
                            btnNext="Dalej";
                          });
                        }
                        btn = 0;
                        myController.text = "";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: CustomRoundedBtn(
                        text: btnNext,
                        fontSize: 20,
                        mWidth: 160,
                        mHeight: 80,
                        textColor: AppColors.text2Color,
                        bgColor: AppColors.secondaryColor,
                        onTap: () async {
                          if (clickCount == 0 && btn != 0) {
                            setState(() {
                              answer1 = btn;
                              txt = "Efektywniej pracuję, jeśli jestem sam";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 1 && btn != 0) {
                            setState(() {
                              answer2 = btn;
                              txt =
                                  "Lubię wykonywać drobne naprawy lub inne prace manualne";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 2 && btn != 0) {
                            setState(() {
                              answer3 = btn;
                              txt = "Lubię/lubiłem pisać rozprawki lub prace naukowe";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 3 && btn != 0) {
                            setState(() {
                              answer4 = btn;
                              txt =
                                  "Jestem zaawansowany w ogólnej obsłudze komputera";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 4 && btn != 0) {
                            setState(() {
                              answer5 = btn;
                              txt = "Mam wyczucie estetyki";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 5 && btn != 0) {
                            setState(() {
                              answer6 = btn;
                              txt = "Lubię wyrażać swoją opinię";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 6 && btn != 0) {
                            setState(() {
                              answer7 = btn;
                              txt = "Regularnie obcuję ze sztuką";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 7 && btn != 0) {
                            setState(() {
                              answer8 = btn;
                              txt = "Umiem myśleć algorytmicznie";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 8 && btn != 0) {
                            setState(() {
                              answer9 = btn;
                              txt = "Lubię rozwiązywać złożone problemy";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 9 && btn != 0) {
                            setState(() {
                              answer10 = btn;
                              txt = "Chcę tworzyć coś dla innych użytkowników";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 10 && btn != 0) {
                            setState(() {
                              answer11 = btn;
                              txt =
                                  "Szybko uczę się języków obcych";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 11 && btn != 0) {
                            setState(() {
                              answer12 = btn;
                              txt =
                                  "Jestem sprawny fizycznie";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 12 && btn != 0) {
                            setState(() {
                              answer13 = btn;
                              txt = "Cenię kontakt z naturą";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 13 && btn != 0) {
                            setState(() {
                              answer14 = btn;
                              txt = "Szukam stabilności finansowej i bezpieczeństwa";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 14 && btn != 0) {
                            setState(() {
                              answer15 = btn;
                              txt = "Preferuję pracę zdalną";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 15 && btn != 0) {
                            setState(() {
                              answer16 = btn;
                              txt =
                                  "Jestem słaby w wystąpieniach publicznych i unikam ich";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 16 && btn != 0) {
                            setState(() {
                              answer17 = btn;
                              txt = "Bardzo cenię aspekt finansowy pracy";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 17 && btn != 0) {
                            setState(() {
                              answer18 = btn;
                              txt = "Chcę, by praca rozwijała mnie nawet kosztem zarobków";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 18 && btn != 0) {
                            setState(() {
                              answer19 = btn;
                              txt = "Dobrze wyciągam wnioski na podstawie danych";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 19 && btn != 0) {
                            setState(() {
                              answer20 = btn;
                              txt = "Interesuję się anatomią i pracą lekarzy";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 20 && btn != 0) {
                            setState(() {
                              answer21 = btn;
                              txt = "Mam dobrą pamięć do pojęć";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 21 && btn != 0) {
                            setState(() {
                              answer22 = btn;
                              txt = "Lubię brać udział w zorganizowanych projektach grupowych";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 22 && btn != 0) {
                            setState(() {
                              answer23 = btn;
                              txt = "Opisz sytuację z pracy, która dała Ci największą satysfakcję";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 23 && myController.text != "") {
                            setState(() {
                              answer24 = myController.text;
                              clickCount++;
                              txt =
                                  "Jakie umiejętności lub wiedzę chcesz rozwijać?";
                              myController.text = "";
                            });
                          } else if (clickCount == 24 && myController.text != "") {
                            setState(() {
                              answer25 = myController.text;
                              clickCount++;
                              txt =
                                  "Czego unikasz lub się obawiasz w pracy?";
                              myController.text = "";
                            });
                          } else if (clickCount == 25 && myController.text != "") {
                            setState(() {
                              answer26 = myController.text;
                              clickCount++;
                              txt =
                                  "Jak praca ma wpływać na Twoje życie prywatne?";
                              myController.text = "";
                              btnNext = "Zakończ";
                            });
                          } else if (clickCount == 26 && myController.text != "") {
                            setState(() {
                              answer27 = myController.text;
                              Navigator.pop(context);
                              Navigator.pushNamed(context, AppRoutes.advice_page);
                              clickCount++;
                              myController.text = "";
                              //txt =
                              //    "Txt: $answer18, $answer19, $answer20, $answer21";
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
