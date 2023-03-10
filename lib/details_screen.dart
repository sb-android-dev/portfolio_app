import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio_app/change_image_screen.dart';
import 'package:portfolio_app/models/Portfolio.dart';
import 'package:portfolio_app/shared_prefs/shared_pref.dart';

import 'edit_details_screen.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  final _portfolioPref = PortfolioPref();

  Portfolio? _portfolio;

  bool isFromAsset = true;
  String assetImagePath = 'images/portfolio_icon.png';
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    populateFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Portfolio"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              padding: EdgeInsets.all(16.0),
              child: Text("Portfolio App",
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
            ),
            ListTile(
              title: const Text("Change Image"),
              onTap: () {
                Navigator.pop(context);
                _navigateAndGetImage(context);
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 320,
                child: isFromAsset ? Image.asset(assetImagePath, fit: BoxFit.contain,) : Image.file(File(imageFile!.path), fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(_portfolio?.name ?? '',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Text(_portfolio?.email ?? '',
                    style: const TextStyle(
                        fontSize: 16.0, fontStyle: FontStyle.italic)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Text(
                  _portfolio?.shortDesc ?? '',
                  style: const TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox.fromSize(size: const Size(80, 80),)
            ],
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateAndDisplayData(context);
          },
          child: const Icon(Icons.edit)),
    );
  }

  Future<void> _navigateAndDisplayData(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EditDetails()));

    if (!mounted) return;

    populateFields();
    // setState(() {
    //   _portfolio = result as Portfolio;
    // });
  }

  Future<void> _navigateAndGetImage(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeImage()));

    if(!mounted) return;

    setState(() {
      imageFile = result as XFile;
      isFromAsset = false;
    });
  }

  void populateFields() async {
    final portfolio = await _portfolioPref.getPortfolio();
    setState(() {
      _portfolio = portfolio;
    });
  }
}