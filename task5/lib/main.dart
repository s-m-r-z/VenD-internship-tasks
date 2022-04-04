import 'package:flutter/material.dart';
import 'helper.dart';

void main(){
  runApp(const HorizonsApp());
}

class HorizonsApp extends StatelessWidget {
  const HorizonsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark(),

      title:'Weather Update',
      scrollBehavior: const ConstantScrollBehavior(),
      
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Weather Updates"),
          backgroundColor: Colors.teal,
        ),
        body: CustomScrollView(
          slivers:<Widget>[
            SliverAppBar(
              backgroundColor:Colors.teal,
              pinned: true,
              stretch: true,


              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Weather'),
                stretchModes:const <StretchMode> [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                collapseMode: CollapseMode.none,
                background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: <Color>[
                      Colors.teal[800]!,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Image.network(
                  headerImage,
                  fit: BoxFit.cover,
                ),
              ),
              ),
            ),
        const WeeklyForecast(),
        ]
        )
      ),
    );
  }
}

class WeeklyForecast extends StatelessWidget {
  const WeeklyForecast({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final DateTime cd=DateTime.now();
    final TextTheme textTheme=Theme.of(context).textTheme;

    return SliverList(
        delegate: SliverChildBuilderDelegate(
         (BuildContext context ,int index) {
          final DailyForecast dailyForecast=Server.getDailyForecastByID(index);
          return Card(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: <Color>[
                              Colors.grey[800]!,
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: Image.network(
                          dailyForecast.imageId,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Text(
                          dailyForecast.getDate(cd.day).toString(),
                          style: textTheme.headline2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dailyForecast.getWeekday(cd.weekday),
                          style: textTheme.headline4,
                        ),
                        const SizedBox(height: 10.0),
                        Text(dailyForecast.description),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                    style: textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          );
        },
          childCount: 7,

        ),
    );
  }
}






