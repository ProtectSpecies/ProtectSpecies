import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({Key key}) : super(key: key);

  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF103A3E),
          title: Text('LeaderBoard'),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  color: Color(0xFF93C8AC),
                ),
                SafeArea(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TopUsers(
                          number: 120,
                          dene: StackItem(
                            number: "1",
                            userID: "User 1",
                            points: "700",
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TopUsers(
                          number: 85,
                          dene: StackItem(
                            number: "2",
                            userID: "User 2",
                            points: "500",
                            color: Colors.blue,
                          ),
                        ),
                        TopUsers(
                          number: 85,
                          dene: StackItem(
                            number: "3",
                            userID: "User 3",
                            points: "300",
                            color: Colors.green,
                          ),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
            TabBar(
                indicatorWeight: 4,
                indicatorColor: Color(0xFF93C8AC),
                labelColor: Color(0xFF103A3E),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Total Score',
                  ),
                  Tab(
                    text: 'Taken Photos',
                  )
                ]),
            Expanded(
                child: TabBarView(children: [
              Container(
                height: 100,
                child: ListView.builder(
                  itemBuilder: (context, index) => UserItem(
                    index: index + 1,
                  ),
                  itemCount: foto.length,
                ),
              ),
              Container()
            ])),
          ],
        ),
      ),
    );
  }
}

class TopUsers extends StatelessWidget {
  const TopUsers({
    Key key,
    this.dene,
    this.number,
  }) : super(key: key);
  final Widget dene;
  final double number;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: number,
        height: number,
        child: Stack(
          children: [
            ClipPolygon(
              sides: 6,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(3.0),
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 8,
                  child: CircularProfileAvatar(
                      "https://pbs.twimg.com/profile_images/1223702174133174272/4cFG8h_Z.jpg"),
                ),
              ),
            ),
            dene
          ],
        ));
  }
}

class StackItem extends StatelessWidget {
  const StackItem({
    Key key,
    this.userID,
    this.number,
    this.points,
    this.color,
  }) : super(key: key);
  final String userID;
  final String number;
  final String points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Stack(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(
                number,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
              child: Text(
                userID,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              alignment: Alignment(0.2, 1.6)),
          Align(
              child: Text(
                points,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              alignment: Alignment(0.03, 2.1))
        ],
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({Key key, this.index, this.fotourl}) : super(key: key);
  final int index;
  final String fotourl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              '$index',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircularProfileAvatar(
              "https://pbs.twimg.com/profile_images/1223702174133174272/4cFG8h_Z.jpg",
              radius: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foto[index - 1],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(points[index - 1].toString()),
          )
        ],
      ),
    );
  }
}

List foto = ["user 1 ", "user 2", "hasan", "mehmet", "sadık", "hamdi"];
List points = [300, 100, 200, 500, 200, 500];
