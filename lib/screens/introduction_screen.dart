import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/slide.dart';
import 'login_screen.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

List slides = [
  Slide(
    title: 'Надежно',
    imgUrl: 'assets/icons/save.png',
  ),
  Slide(
    title: 'Выгодно',
    imgUrl: 'assets/icons/cost.png',
  ),
  Slide(
    title: 'Быстро',
    imgUrl: 'assets/icons/faster.png',
  ),
];

class _IntroductionScreenState extends State<IntroductionScreen> {
  int _currentIndex = 0;
  CarouselSlider carouselSlider;
  List<T> dots<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Hero(
                tag: 'tag1',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'PRO',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      'sto',
                      style: TextStyle(
                        color: Color(0xFFFF4C00),
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: GestureDetector(
                  onHorizontalDragStart: (DragStartDetails details) {
                    print(details);
                  },
                  child: Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 500),
                        top: _currentIndex != 0 ? 20 : 150,
                        bottom: _currentIndex == 0 ? 0 : 200,
                        left: _currentIndex == 0
                            ? MediaQuery.of(context).size.width / 2 - 75
                            : _currentIndex == 1
                                ? 40
                                : MediaQuery.of(context).size.width - 140,
                        child: Image.asset(
                          'assets/icons/save.png',
                        ),
                      ),
                      AnimatedPositioned(
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 500),
                        top: _currentIndex != 1 ? 20 : 150,
                        bottom: _currentIndex == 1 ? 0 : 200,
                        left: _currentIndex == 1
                            ? MediaQuery.of(context).size.width / 2 - 75
                            : _currentIndex == 2
                                ? 40
                                : MediaQuery.of(context).size.width - 140,
                        child: Image.asset(
                          'assets/icons/cost.png',
                        ),
                      ),
                      AnimatedPositioned(
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 500),
                        top: _currentIndex != 2 ? 20 : 150,
                        bottom: _currentIndex == 2 ? 0 : 200,
                        left: _currentIndex == 2
                            ? MediaQuery.of(context).size.width / 2 - 75
                            : _currentIndex == 0
                                ? 40
                                : MediaQuery.of(context).size.width - 140,
                        child: Image.asset(
                          'assets/icons/faster.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              carouselSlider = CarouselSlider(
                height: 60.0,
                viewportFraction: 1.0,
                initialPage: 0,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: slides.map((slide) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            slide.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 40.0,
                              color: Color(0xFFFF4C00),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Вход',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dots<Widget>(slides, (index, slide) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        carouselSlider.animateToPage(index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                        _currentIndex = index;
                      });
                    },
                    child: Container(
                      width: 14.0,
                      height: 14.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 3.0, vertical: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: Colors.teal,
                        ),
                        color: index == _currentIndex
                            ? Color(0xFFFF4C00)
                            : Colors.teal,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
