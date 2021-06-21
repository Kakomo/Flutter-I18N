import 'package:bytebank/components/localization.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bytebank_logo.png'),
          fit: BoxFit.fill,
        )),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocalizationContainer(
                                  child: DashboardContainer('LANGUAGE_EN'),
                                )));
                  },
                  child: Text(
                    'ENGLISH',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style:  ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocalizationContainer(
                              child: DashboardContainer('LANGUAGE_PT'),
                            )));
                  },
                  child: Text(
                    'PORTUGUÊS',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style:  ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
