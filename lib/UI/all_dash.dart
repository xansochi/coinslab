import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './piechart_dash.dart';
import './graph_dash.dart';
import '../const/themes_const.dart';
import '../models/singlton.dart';

List testArray = [{'totalsumm':0}];

class DashboardTopUi extends StatelessWidget {
  const DashboardTopUi({super.key});
  @override

  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ThemesConstants.dashboardBackgrounGradientOne,
                  ThemesConstants.dashboardBackgrounGradientTwo,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
                child:
                  SizedBox(
                    child:
                   CarouselSlider(
                    options: CarouselOptions(height: 150.0),
                    items:<Widget>[
                      Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: const BoxDecoration(
                            borderRadius:BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                            image: AssetImage("images/asset1.jpg"),
                            fit: BoxFit.cover,
                          ),
                            ),
                            child: 
                            // BackdropFilter(
                            // filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            Column(
                             children: [
                               const Padding (padding: EdgeInsets.only(left:0, bottom: 0, right: 0, top:6),
                               child: Text('ВСЕГО  В  СДЕЛКАХ',style: TextStyle(color: Color.fromARGB(255, 78, 78, 78),letterSpacing:1))),
                               Padding (padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top:15),
                               child: Text("\$ ${appData.summ}",style: const TextStyle(color: Color.fromARGB(255, 37, 37, 37),letterSpacing:2,fontSize: 40,fontWeight: FontWeight.w300))),
                               Padding (padding: const EdgeInsets.only(left:0, bottom: 0, right: 0, top:0),
                                child:
                               appData.incomePercent().isNaN ? const Text("Данные устарели.Обновите цены в вашем портфеле",
                               textAlign:TextAlign.center,
                               style: TextStyle(color: Color.fromARGB(255, 167, 23, 13),letterSpacing:1,fontSize: 12))
                               :
                               Text("↟ ${appData.incomePercent().toStringAsFixed(2)}% (${appData.income}\$)",
                               style: const TextStyle(color: Color.fromARGB(255, 13, 167, 38),letterSpacing:1,fontSize: 15))),
                               const Padding (padding: EdgeInsets.only(left:0, bottom: 0, right: 0, top:0),
                               child: Text("за последние 24 часа",
                               style: TextStyle(color: Color.fromARGB(255, 34, 34, 34),letterSpacing:1,fontSize: 10))),
                            ],
                            )
                            ),
                      Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: const BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 255, 255, 255)
                            ),
                            child: const PieChartSample2() ),
                      Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: const BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 255, 255, 255)
                            ),
                            child: const LineChartSample2()),
                      ]
                    ),
                )
          );
  }
}