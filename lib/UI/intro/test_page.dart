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
  String txt = "W jakim stopniu uważasz się\nza osobę społeczną?";
  String btnNext = "Dalej";
  double btn = 0;
  double clickCount = 0;
  double answer1 = 0;
  double answer2 = 0;
  double answer3 = 0;
  double answer4 = 0;
  double answer5 = 0;
  double answer6 = 0;

  TestPageState({
    this.answer1 = 0,
    this.answer2 = 0,
    this.answer3 = 0,
    this.answer4 = 0,
    this.answer5 = 0,
    this.answer6 = 0,
  });

  get file => null;

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
              progress: (clickCount / 6) * 350,
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("$txt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'PatrickHand',
                      color: AppColors.textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
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
                )),
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
                            answer1 = 0;
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.start_page);
                            clickCount--;
                          });
                        } else if (clickCount == 1) {
                          setState(() {
                            answer2 = 0;
                            txt =
                                "W jakim stopniu uważasz się\nza osobę społeczną?";
                            clickCount--;
                          });
                        } else if (clickCount == 2) {
                          setState(() {
                            answer3 = 0;
                            txt =
                                "W jakim stopniu uważasz się\nza osobę społeczną? 2";
                            clickCount--;
                          });
                        } else if (clickCount == 3) {
                          setState(() {
                            answer4 = 0;
                            txt =
                                "W jakim stopniu uważasz się\nza osobę społeczną? 3";
                            clickCount--;
                          });
                        } else if (clickCount == 4) {
                          setState(() {
                            answer5 = 0;
                            txt =
                                "W jakim stopniu uważasz się\nza osobę społeczną? 4";
                            clickCount--;
                          });
                        } else if (clickCount == 5) {
                          setState(() {
                            answer6 = 0;
                            txt =
                                "W jakim stopniu uważasz się\nza osobę społeczną? 5";
                            clickCount--;
                            btnNext = "Dalej";
                          });
                        }
                        btn = 0;
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
                              txt =
                                  "W jakim stopniu uważasz się\nza osobę społeczną? 2";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 1 && btn != 0) {
                            setState(() {
                              answer2 = btn;
                              txt =
                                  "W jakim stopniu uważasz się\nza osobę społeczną? 3";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 2 && btn != 0) {
                            setState(() {
                              answer3 = btn;
                              txt =
                                  "W jakim stopniu uważasz się\nza osobę społeczną? 4";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 3 && btn != 0) {
                            setState(() {
                              answer4 = btn;
                              txt =
                                  "W jakim stopniu uważasz się\nza osobę społeczną? 5";
                              clickCount++;
                              btn = 0;
                            });
                          } else if (clickCount == 4 && btn != 0) {
                            setState(() {
                              answer5 = btn;
                              txt =
                                  "W jakim stopniu uważasz się\nza osobę społeczną? 6";
                              clickCount++;
                              btn = 0;
                              btnNext = "Zakończ";
                            });
                          } else if (clickCount == 5 && btn != 0) {
                            setState(() {
                              answer6 = btn;
                              Navigator.pop(context);
                              Navigator.pushNamed(context, AppRoutes.menu_page);
                              clickCount++;
                              btn = 0;
                              //txt = "Odp1: $answer1, Odp2: $answer2, Odp3: $answer3, Odp4: $answer4, Odp5: $answer5,  Odp6: $answer6, ";
                            });

                            Map<String, dynamic> dane = {
                              'Pytanie': {
                                'Pytanie 1',
                                'Pytanie 2',
                                'Pytanie 3',
                                'Pytanie 4',
                                'Pytanie 5',
                                'Pytanie 6'
                              },
                              'Odpowiedź': {
                                answer1,
                                answer2,
                                answer3,
                                answer4,
                                answer5,
                                answer6
                              },
                            };

                            String jsonString = jsonEncode(
                                dane); // Konwertuj mapę na String JSON

                            await file.writeAsString(
                                jsonString); // Zapisz JSON do pliku
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
