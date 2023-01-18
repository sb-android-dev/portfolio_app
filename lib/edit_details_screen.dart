import 'package:flutter/material.dart';
import 'package:portfolio_app/models/Portfolio.dart';

class EditDetails extends StatelessWidget {
  EditDetails({super.key, required this.portfolio});

  final Portfolio? portfolio;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = portfolio?.name ?? '';
    emailController.text = portfolio?.email ?? '';
    descController.text = portfolio?.shortDesc ?? '';

    final ButtonStyle style = ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Name'),
                controller: nameController,
              ),
              const SizedBox(
                height: 32,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Email'),
                controller: emailController,
              ),
              const SizedBox(
                height: 32,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter short description'),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                controller: descController,
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: style,
                  onPressed: () {
                    Portfolio portfolio = Portfolio(nameController.text,
                        emailController.text, descController.text);
                    Navigator.pop(context, portfolio);
                  },
                  child: const Text(
                    'Update Details',
                    style: TextStyle(fontSize: 16.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}