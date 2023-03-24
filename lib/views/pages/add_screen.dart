import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/hotel_model.dart';
import 'package:flutter_firebase/services/hotel_service.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  HotelService service = HotelService();

  String name = "";
  String description = "";
  File? image;
  String fileName = "";
  bool loading = false;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      PlatformFile platformFile = result.files.first;
      setState(() {
        image = file;
        fileName = platformFile.name;
      });
    }
  }

  void onChangeName(String value) {
    setState(() {
      name = value;
    });
  }

  void onChangeDescription(String value) {
    setState(() {
      description = value;
    });
  }

  void handleSave() async {
    if (image != null) {
      setState(() {
        loading = true;
      });
      Uint8List fileBytes = image?.readAsBytesSync() as Uint8List;

      String link = await service.saveImage(fileName, fileBytes);
      await service.saveHotel(
        Hotel(
          title: name,
          description: description,
          image: link,
          favorite: false,
          creationDate: DateTime.now(),
        ),
      );
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Nom",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) => onChangeName(value),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Description",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 4,
            onChanged: (value) => onChangeDescription(value),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                pickFile();
              },
              child: const Text("Choose image"),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(fileName),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: loading ? null : () => handleSave(),
              child: loading ? const Text("Loading...") : const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
