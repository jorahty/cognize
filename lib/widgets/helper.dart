import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CognizeHelper extends StatefulWidget {
  const CognizeHelper({Key? key}) : super(key: key);

  @override
  State<CognizeHelper> createState() => _CognizeHelperState();
}

class _CognizeHelperState extends State<CognizeHelper> {
  late final TextEditingController promptController;
  String responseTxt = '';
  bool isRequesting = false;

  @override
  void initState() {
    promptController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          'Cognize Helper',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PromptBldr(responseTxt: responseTxt),
          TextFormFieldBldr(
            promptController: promptController,
            btnFun: () => isRequesting ? null : completionFun(),
          ),
        ],
      ),
    );
  }

  //Handles http API call for ChatGPT
  completionFun() async {
    setState(() {
      isRequesting = true;
      responseTxt = 'Loading...';
    });

    await Future.delayed(Duration(seconds: 5)); // Introduce a delay of 2 seconds

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['token']}'
      },
      body: jsonEncode(
        {
          "prompt": promptController.text,
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        },
      ),
    );

      if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse != null && jsonResponse.containsKey("choices")) {
      setState(() {
        responseTxt = jsonResponse["choices"][0]["text"];
        debugPrint(responseTxt);
        isRequesting = false;
      });
    } else {
      setState(() {
        responseTxt = 'Error: Unexpected response format';
        isRequesting = false;
      });
    }
  } else {
    setState(() {
      responseTxt = 'Error: ${response.statusCode}';
      isRequesting = false;
    });
  }
  }
}

class PromptBldr extends StatelessWidget{
  const PromptBldr({
    super.key,
    required this.responseTxt,
  });

  final String responseTxt;

  @override
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 1.35,
      color: const Color(0xff434654),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Text(
              responseTxt,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFieldBldr extends StatelessWidget{
  const TextFormFieldBldr(
    {super.key, required this.promptController, required this.btnFun});
  
  final TextEditingController promptController;
  final Function btnFun;

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                cursorColor: Colors.white,
                controller: promptController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff444653),
                    ),
                      borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff444653),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xff444653),
                  hintText: 'Ask me anything!',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              color: const Color(0xff19bc99),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: () => btnFun(),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class ResponseModel {
  final String id;
  final String object;
  final String model;
  final List choices;

  ResponseModel(
    this.id,
    this.object,
    this.model,
    this.choices,
  );

  ResponseModel copyWith({
    String? id,
    String? object,
    String? model,
    List? choices,
  }) {
    return ResponseModel(
      id ?? this.id,
      object ?? this.object,
      model ?? this.model,
      choices ?? this.choices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'model': model,
      'choices': choices,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      map['id'] as String,
      map['object'] as String,
      map['model'] as String,
      List.from(map['choices'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseModel(id: $id, object: $object, model: $model, choices: $choices)';
  }

  @override
  bool operator ==(covariant ResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.object == object &&
        other.model == model &&
        listEquals(other.choices, choices); // Use listEquals from flutter/foundation
  }

  @override
  int get hashCode {
    return id.hashCode ^ object.hashCode ^ model.hashCode ^ choices.hashCode;
  }
}
