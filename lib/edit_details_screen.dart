import 'package:flutter/material.dart';
import 'package:portfolio_app/models/Portfolio.dart';
import 'package:portfolio_app/shared_prefs/shared_pref.dart';

class EditDetails extends StatefulWidget {
  const EditDetails({super.key});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  final _portfolioPref = PortfolioPref();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    populateFields();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _nameController,
              ),
              const SizedBox(
                height: 32,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Email'),
                controller: _emailController,
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
                controller: _descController,
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: style,
                  onPressed: () {
                    _updatePortfolio(context);
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

  Future<void> _updatePortfolio(BuildContext context) async {
    Portfolio portfolio = Portfolio(_nameController.text, _emailController.text, _descController.text);

    _portfolioPref.savePortfolio(portfolio)
        .then((value) => {Navigator.pop(context, portfolio)});
  }

  void populateFields() async {
    final portfolio = await _portfolioPref.getPortfolio();
    setState(() {
      _nameController.text = portfolio.name;
      _emailController.text = portfolio.email;
      _descController.text = portfolio.shortDesc;
    });
  }
}
