import 'package:bmiapp/result_screen.dart';
import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'dart:math';
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heightValue = 172;
  int weight = 55;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Body Mass Index",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    m1Expanded(context, 'Male'),
                    const SizedBox(width: 15),
                    m1Expanded(context, 'Female'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:20 ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueGrey),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Height",style: Theme.of(context).textTheme.headline2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline:TextBaseline.alphabetic ,
                        children: [
                        Text(heightValue.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text("Cm",style: Theme.of(context).textTheme.bodyText1),
                      ],),
                      Slider(
                          value:heightValue,
                          onChanged: (val){
                            setState(() {
                              heightValue=val;
                            });
                          },
                          min:90,
                          max:220 ,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    m2Expanded(context, 'Weight'),
                    const SizedBox(width: 15),
                    m2Expanded(context, 'Age'),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.teal,
              width: double.infinity,
              height: MediaQuery.of(context).size.height/15,
              child: TextButton(
                  onPressed: (){
                    var res=weight/pow(heightValue/100,2);
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return ResultScreen(result: res, isMale: isMale, age: age);
                    }));
                  },
                  child:Text(
                    "Calculate",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded m1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = (type == 'Male') ? true : false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: (isMale && type == "Male") || (!isMale && type == "Female")
                  ? Colors.teal
                  : Colors.blueGrey),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(type == "Male" ? Icons.male : Icons.female,size: 90,),
              const SizedBox(
                height: 15,
              ),
              Text(
                type == "Male" ? "Male" : "Female",
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blueGrey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == "Age" ? "Age" : "Weight",
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              type == "Age" ? "$age" : "$weight",
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: (){
                    setState(() {
                      type=='Age'?age--:weight--;
                    });
                  },
                  heroTag:type == "Age" ?'age--':'weight--',
                  child:const Icon(Icons.remove),
                ),
                const SizedBox(width:10),
                FloatingActionButton(
                  mini: true,
                  onPressed: (){
                    setState(() {
                      type == "Age"?age++:weight++;
                    });
                  },
                  heroTag:type == "Age" ?'age++':'weight++',
                  child:const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
