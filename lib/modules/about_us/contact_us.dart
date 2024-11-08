import 'dart:convert';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../shared/components/components.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future sendMessage() async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_x8dbvjl';
    const templateId = 'template_8iu1mnc';
    const userId = '6BFUcroFvwiB0LsBg';
    final response = http
        .post(url,
            headers: {
              'origin': 'http://localhost',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              "service_id": serviceId,
              "template_id": templateId,
              "user_id": userId,
              "template_params": {
                "user_name": nameController.text,
                "user_subject": subjectController.text,
                "user_email": emailController.text,
                "user_message": messageController.text,
              }
            }))
        .then((value) => {print(value.body)})
        .catchError((error) {
      print(error.toString());
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Contact Us'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    child: const Center(
                      child: Image(
                        image: AssetImage('assets/images/logo_1.png'),
                        fit: BoxFit.cover,
                        height: 90.0,
                        width: 80.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defFormField(
                      context: context,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name field must be filled';
                        }
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defFormField(
                      context: context,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address field must be filled';
                        }
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defFormField(
                      context: context,
                      controller: subjectController,
                      keyboardType: TextInputType.text,
                      label: 'Subject',
                      prefix: Icons.subject,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Subject field must be filled';
                        }
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: messageController,
                    maxLines: 7,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      filled: true,
                      label: Text(
                        'Message',
                      ),
                      // prefixIcon: Icon(Icons.message),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Message field must be filled';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ConditionalBuilder(
                    condition: true,
                    builder: (context) => defButton(
                        text: "Submit",
                        function: () {
                          print(formKey.currentState);
                          if (formKey.currentState!.validate() == true) {
                            sendMessage();
                          }
                        }),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
