import 'package:portfolio_app/models/Portfolio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioPref {

  Future<bool> isAvailable(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isContain = pref.containsKey(key);
    return isContain;
  }

  Future<bool> savePortfolio(Portfolio portfolio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool n = await prefs.setString('name', portfolio.name);
    bool e = await prefs.setString('email', portfolio.email);
    bool d = await prefs.setString('desc', portfolio.shortDesc);

    return n && e && d;
  }

  Future<Portfolio> getPortfolio() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final name = pref.getString('name') ?? '';
    final email = pref.getString('email') ?? '';
    final desc = pref.getString('desc') ?? '';
    Portfolio portfolio = Portfolio(name, email, desc);
    return portfolio;
  }
}
