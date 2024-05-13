import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jp_text_recognizer/controller/main_controller.dart';
import 'package:jp_text_recognizer/helper/japanese_language_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JP Language'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MainController mainCon = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Identify Jp Character
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                controller: mainCon.textFieldCon,
                inputFormatters: const [
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value){
                  mainCon.historyList.clear();
                  setState(() {
                    JapaneseLanguageHelper().identifyJpCharacters(value);
                    JapaneseLanguageHelper().identifyJpCharacterType(value);
                    JapaneseLanguageHelper().identifySingleOrDoubleByteJpChar(value);
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    borderSide: const BorderSide(color: Colors.black), // Change the border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    borderSide: const BorderSide(color: Colors.blue), // Change the border color
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    borderSide: const BorderSide(color: Colors.red), // Change the border color
                  ), 
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    borderSide: const BorderSide(color: Colors.red), // Change the border color
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    borderSide: const BorderSide(color: Colors.black), // Change the border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    borderSide: const BorderSide(color: Colors.black), // Change the border color
                  ),
                ),
              ),
              //History of messages and on click clear button
              const SizedBox(height: 5.0), 
              const Divider(thickness: 0.0,height: 0.0),
              GestureDetector(
                onTap: ()async{
                  setState(() {
                    mainCon.historyList.clear();
                  });
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black),
                    color: Colors.amber,
                  ),
                  child: const Text('History')
                )
              ),
              const Divider(thickness: 0.0,height: 0.0),
              const SizedBox(height: 5.0),
              //List
              Expanded(
                child: GetBuilder<MainController>(
                  builder: (mainController){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: mainController.historyList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, index){
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:2.0,horizontal: 10.0),
                            child: Text('${mainController.historyList[index]}'),
                          ),
                        );
                      }
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
