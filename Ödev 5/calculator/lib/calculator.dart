import 'package:calculator/app_colors.dart';
import 'package:calculator/default_button.dart';
import 'package:calculator/result_text.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = "0", removeString = "AC";
  double fontSize = 60, showResult = 0;
  bool isEqualClicked = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ResultText(
                    result: result,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DefaultButton(
                    color: AppColors.removeColor,
                    name: removeString,
                    onPressed: () {
                      setState(() {
                        removeString = "AC";
                        result = "0";
                        showResult = 0;
                        fontSize = 60;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.removeColor,
                    name: "+/-",
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.removeColor,
                    name: "%",
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.operationColor,
                    name: "÷",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "7",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "7");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "8",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "8");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "9",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "9");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.operationColor,
                    name: "x",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "4",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "4");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "5",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "5");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "6",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "6");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.operationColor,
                    name: "-",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "1",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "1");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "2",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "2");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "3",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "3");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DefaultButton(
                    color: AppColors.operationColor,
                    name: "+",
                    onPressed: () {
                      showResult == 0
                          ? showResult = double.parse(result)
                          : showResult += double.parse(result);

                      result = "0";
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DefaultButton(
                    color: AppColors.numberColor,
                    name: "0",
                    onPressed: () {
                      setState(() {
                        changeUI(width, "0");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: DefaultButton(
                          color: AppColors.numberColor,
                          name: ".",
                          onPressed: () {
                            setState(() {
                              removeString = "C";
                              isEqualClicked
                                  ? result = "0."
                                  : {
                                      if (!result.contains(".")) {result += "."}
                                    };
                              isEqualClicked = false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: DefaultButton(
                          color: AppColors.operationColor,
                          name: "=",
                          onPressed: () {
                            setState(() {
                              isEqualClicked = true;
                              if (result != 0) {
                                result = "${showResult + double.parse(result)}";
                                showResult = 0;
                              } else {
                                result = "$showResult";
                              }
                              resultFormat();
                              checkSize(width);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changeUI(double width, String name) {
    checkSize(width);
    removeString = "C";
    isEqualClicked
        ? result = name
        : (result == "0" ? result = name : result += name);
    isEqualClicked = false;
  }

  void resultFormat() {
    if (result.endsWith(".")) {
      result = result.replaceAll(".", "");
    } else if (result.endsWith(".0")) {
      result = result.replaceAll(".0", "");
    }
  }

  void checkSize(double width) {
    if (result.length * fontSize < width) {
      fontSize = 60;
    } else {
      fontSize = width / result.length;
    }
  }
}
