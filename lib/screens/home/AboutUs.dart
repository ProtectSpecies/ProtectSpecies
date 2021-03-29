import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import 'package:flutterapp/screens/home/profile.dart';

class AboutUs extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget aboutUsText1() {
      return Text(
        'WELCOME TO PROTECT SPECIES',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF103A3E),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget aboutUsText2() {
      return Text(
        'First of all, we thank you for taking a step towards using this application and supporting the protection of animals. ',
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText2_1() {
      return Text(
        "Protect Species is an application developed to protect endangered animals. Well, you might ask, how do we do this ?",
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText3() {
      return Text(
        "In the Identify section of the application, users can take photos of animals that they see rarely in nature. Currently, the artificial intelligence we have developed can identify 12 of the most critical animals from the list of endangered animals shared by worldwildlife.org. You can see these 12 animals with their photos on the application's home page. \nIf the photo taken by the user is one of these 12 animals, the artificial intelligence detects the animal and informs the user about which animal it has found. In this way, we keep the data of this animal. In addition, the user can submit any extra information or comments via the comment section when sending this information to us. Apart from these, if users want to hold the photo of the animal they took, access it later and show it to other people, they can send the photo to us with the option to share it on their profile and share it on their own profile.",
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText4() {
      return Text(
          'Well, you may have a question in your mind, what will happen to this photo and location information we have sent');
    }

    Widget aboutUsText5() {
      return Text(
        'We will chart this data with its location and time and share it with the authorities and states in the world that show serious sensitivity about this issue. In this way, they will be able to make the effort required to protect these animals more easily.',
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText6() {
      return Text('Our purposes while developing this application;');
    }

    Widget aboutUsText7() {
      return Text(
        '1) We know that data on some endangered animals have been collected in some way. However, since these data are accumulated in different places, they cause confusion and lack of information. Therefore, instead of collecting these data separately, we want to combine them under a single roof ,and  to do this information collcting stage with the support of not only experts in the field but also the public.',
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText8() {
      return Text(
        "2) We also observed that there could be consequences that could harm animals due to the possibility of sharing publicly collected information with malicious people and organizations. In order to prevent this information from reaching the wrong people, we want to give this data to fully authorized and proven organizations and we want to be completely transparent about this process.",
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText9() {
      return Text(
        "3) Raising public awareness about endangered animals and motivating people to help them.",
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText10() {
      return Text(
        "We are aware that we have shortcomings and we continue to work to provide you with a better experience. ",
        style: TextStyle(fontSize: 17),
      );
    }

    Widget aboutUsText11() {
      return Text(
        "Thank you for helping to protect animals.",
        style: TextStyle(fontSize: 17),
      );
    }

    return Scaffold(
      key: _drawerKey,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 230,
                            ),
                            aboutUsText1(),
                            SizedBox(
                              height: 30,
                            ),
                            aboutUsText2(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText2_1(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText3(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText4(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText5(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText6(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText7(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText8(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText9(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText10(),
                            SizedBox(
                              height: 7,
                            ),
                            aboutUsText11()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            color: Color(0xFF93C8AC),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        ClipPath(
          clipper: CustomContainerShaper(),
          child: Container(
            height: 175,
            color: Color(0xFF103A3E),
            child: Column(children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      child: Icon(Icons.arrow_back),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF103A3E)),
                      ),
                      onPressed: () async {
                        int score = await Future.delayed(
                            const Duration(milliseconds: 1500), () => 42);
                        return Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUs()),
                        );
                      },
                    ),
                    SizedBox(width: 60),
                    Text("About Us",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              )
            ]),
          ),
        ),
      ]),
      endDrawer: settingsDrawer(),
    );
  }
}
