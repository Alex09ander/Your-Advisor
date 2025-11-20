import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:your_advisor/UI/custom_widgets/custom_circle_btn.dart';
import 'package:your_advisor/UI/custom_widgets/progress_bar.dart';
import 'package:your_advisor/domain/app_colors.dart';

import '../../domain/app_routes.dart';
import '../custom_widgets/custom_rounded_btn.dart';

class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  final myController = TextEditingController();

  String txt = "Pasuje mi bycie w centrum zainteresowania";
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
  String answer18 = "";
  String answer19 = "";
  String answer20 = "";
  String answer21 = "";

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
              progress: (clickCount / 20) * 350,
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
            clickCount < 17
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
                            Navigator.pushNamed(context, AppRoutes.start_page);
                          });
                        }
                        else if (clickCount == 1) {
                          setState(() {
                            answer1 = 0;
                            txt = "Pasuje mi bycie w centrum zainteresowania";
                            clickCount--;
                          });
                        }
                        else if (clickCount == 2) {
                          setState(() {
                            answer2 = 0;
                            txt = "Łatwo dogaduje się z nowymi osobami";
                            clickCount--;
                          });
                        } else if (clickCount == 3) {
                          setState(() {
                            answer3 = 0;
                            txt =
                            "Muszę zaplanować pracę przed jej rozpoczęciem";
                            clickCount--;
                          });
                        } else if (clickCount == 4) {
                          setState(() {
                            answer4 = 0;
                            txt = "Mam problem z dotrzymywaniem terminów";
                            clickCount--;
                          });
                        } else if (clickCount == 5) {
                          setState(() {
                            answer5 = 0;
                            txt =
                            "W sporze ważniejsze są uczucia, niż dotarcie do prawdy";
                            clickCount--;
                          });
                        } else if (clickCount == 6) {
                          setState(() {
                            answer6 = 0;
                            txt = "Jestem bezkompromisowy i walczę o swoje";
                            clickCount--;
                          });
                        } else if (clickCount == 7) {
                          setState(() {
                            answer7 = 0;
                            txt = "Miewam częste wahania nastroju";
                            clickCount--;
                          });
                        } else if (clickCount == 8) {
                          setState(() {
                            answer8 = 0;
                            txt = "Dobrze radzę sobie z emocjami";
                            clickCount--;
                          });
                        } else if (clickCount == 9) {
                          setState(() {
                            answer9 = 0;
                            txt = "Nie mam problemu z uzależnieniami";
                            clickCount--;
                          });
                        } else if (clickCount == 10) {
                          setState(() {
                            answer10 = 0;
                            txt = "Lubię nieszablonowe rozwiązania";
                            clickCount--;
                          });
                        } else if (clickCount == 11) {
                          setState(() {
                            answer11 = 0;
                            txt = "Mam predyspozycje do bycia artystą";
                            clickCount--;
                          });
                        } else if (clickCount == 12) {
                          setState(() {
                            answer12 = 0;
                            txt =
                            "Swoje działania kieruję rozumem i logicznym myśleniem, bardziej niż emocjami";
                            clickCount--;
                          });
                        } else if (clickCount == 13) {
                          setState(() {
                            answer13 = 0;
                            txt =
                            "Jestem w stanie w coś uwierzyć, dając się swoim emocjom";
                            clickCount--;
                          });
                        } else if (clickCount == 14) {
                          setState(() {
                            answer14 = 0;
                            txt = "Trudno mi utrzymać uwagę na jednej rzeczy";
                            clickCount--;
                          });
                        } else if (clickCount == 15) {
                          setState(() {
                            answer15 = 0;
                            txt = "Często zmieniam kierunek działania";
                            clickCount--;
                          });
                        } else if (clickCount == 16) {
                          setState(() {
                            answer16 = 0;
                            txt = "Grupa często widzi we mnie lidera";
                            clickCount--;
                          });
                        } else if (clickCount == 17) {
                          setState(() {
                            answer17 = 0;
                            txt =
                            "Uważam że byłbym dobrym dyrektorem albo przywódcą politycznym";
                            clickCount--;
                          });
                        } else if (clickCount == 18) {
                          setState(() {
                            answer18 = "";
                            txt = "Czego brakuje ci do pełni szczęścia?";
                            clickCount--;
                          });
                        } else if (clickCount == 19) {
                          setState(() {
                            answer19 = "";
                            clickCount--;
                            txt =
                            "Jaki byłby twój wymarzony partner życiowy?";
                          });
                        } else if (clickCount == 20) {
                          setState(() {
                            answer20 = "";
                            clickCount--;
                            txt =
                            "Jaki byłby Twój wymarzony dzień?";
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
                              txt = "Łatwo dogaduje się z nowymi osobami";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 1 && btn != 0) {
                            setState(() {
                              answer2 = btn;
                              txt =
                                  "Muszę zaplanować pracę przed jej rozpoczęciem";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 2 && btn != 0) {
                            setState(() {
                              answer3 = btn;
                              txt = "Mam problem z dotrzymywaniem terminów";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 3 && btn != 0) {
                            setState(() {
                              answer4 = btn;
                              txt =
                                  "W sporze ważniejsze są uczucia, niż dotarcie do prawdy";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 4 && btn != 0) {
                            setState(() {
                              answer5 = btn;
                              txt = "Jestem bezkompromisowy i walczę o swoje";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 5 && btn != 0) {
                            setState(() {
                              answer6 = btn;
                              txt = "Miewam częste wahania nastroju";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 6 && btn != 0) {
                            setState(() {
                              answer7 = btn;
                              txt = "Dobrze radzę sobie z emocjami";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 7 && btn != 0) {
                            setState(() {
                              answer8 = btn;
                              txt = "Nie mam problemu z uzależnieniami";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 8 && btn != 0) {
                            setState(() {
                              answer9 = btn;
                              txt = "Lubię nieszablonowe rozwiązania";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 9 && btn != 0) {
                            setState(() {
                              answer10 = btn;
                              txt = "Mam predyspozycje do bycia artystą";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 10 && btn != 0) {
                            setState(() {
                              answer11 = btn;
                              txt =
                                  "Swoje działania kieruję rozumem i logicznym myśleniem, bardziej niż emocjami";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 11 && btn != 0) {
                            setState(() {
                              answer12 = btn;
                              txt =
                                  "Jestem w stanie w coś uwierzyć, dając się swoim emocjom";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 12 && btn != 0) {
                            setState(() {
                              answer13 = btn;
                              txt = "Trudno mi utrzymać uwagę na jednej rzeczy";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 13 && btn != 0) {
                            setState(() {
                              answer14 = btn;
                              txt = "Często zmieniam kierunek działania";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 14 && btn != 0) {
                            setState(() {
                              answer15 = btn;
                              txt = "Grupa często widzi we mnie lidera";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 15 && btn != 0) {
                            setState(() {
                              answer16 = btn;
                              txt =
                                  "Uważam że byłbym dobrym dyrektorem albo przywódcą politycznym";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 16 && btn != 0) {
                            setState(() {
                              answer17 = btn;
                              txt = "Czego brakuje ci do pełni szczęścia?";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 17 && myController.text != "") {
                            setState(() {
                              answer18 = myController.text;
                              clickCount++;
                              txt =
                                  "Jaki byłby twój wymarzony partner życiowy?";
                              myController.text = "";
                            });
                            } else if (clickCount == 18 && myController.text != "") {
                            setState(() {
                              answer19 = myController.text;
                              clickCount++;
                              txt =
                                  "Jaki byłby Twój wymarzony dzień?";
                              myController.text = "";
                            });

                            } else if (clickCount == 19 && myController.text != "") {
                            setState(() {
                              answer20 = myController.text;
                              clickCount++;
                              txt =
                                  "Czego w życiu najbardziej się boisz?";
                              myController.text = "";
                              btnNext = "Zakończ";
                            });

                            } else if (clickCount == 20 && myController.text != "") {
                            setState(() {
                              answer21 = myController.text;
                              Navigator.pop(context);
                              Navigator.pushNamed(context, AppRoutes.menu_page);
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
            )
          ],
        ),
      ),
    );
  }
}
