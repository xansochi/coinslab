import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/Coinlist/coin_list.dart';
import '../provider/coinlist_provider.dart';
import '../UI/all_dash.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return
        Flex(
          direction: Axis.vertical,
          children: [
          const DashboardTopUi(),
          const Expanded(flex:0,child: Divider(thickness:16, color: Color.fromARGB(255, 3, 45, 73))),
          Expanded(
                child: ChangeNotifierProvider(
                create: (context) => CoinListProvider(),
                child: const MyList()
                        )),],
                        );
  }
}