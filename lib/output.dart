import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:widget_assignment/bool_values.dart';
import 'package:widget_assignment/custom_elevated_button.dart';

class Output extends StatelessWidget {
  const Output(
      {super.key,
      required this.text,
      required this.image,
      required this.button,
      required this.noWidgets});

  final bool button;
  final bool image;
  final bool text;
  final bool noWidgets;

  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetSelectionModel>(
      builder: (context, widgetSelection, _) {
        Future<void> selectPicture() async {
          ImageSource source = ImageSource.gallery;

          final imagePicker = ImagePicker();
          final pickedImage = await imagePicker.pickImage(
            source: source,
            maxWidth: 600,
          );
          widgetSelection
              .selectImage(pickedImage != null ? File(pickedImage.path) : null);
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!text && !image && button && noWidgets)
              Text(
                "Add at-least a widget to save",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 7, 77, 9),
                ),
              ),
            if (!text && !image && !button)
              Text(
                "No Widget is added",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 7, 77, 9),
                ),
              ),
            if (text)
              TextFormField(
                initialValue: widgetSelection.text,
                decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Enter Text'),
                onChanged: (text) => widgetSelection.setText(text),
              ),
            if (image)
              GestureDetector(
                onTap: selectPicture,
                child: widgetSelection.selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          widgetSelection.selectedImage!,
                          width: double.infinity,
                          height: 190,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        color: Colors.grey[200],
                        width: 270,
                        height: 180,
                        child: const Center(child: Text("Select Image")),
                      ),
              ),
            if (button)
              widgetSelection.saving
                  ? CircularProgressIndicator()
                  : CustomElevatedButton(
                      text: 'Save',
                      onTapFunction: () async {
                        widgetSelection.toggleSaving(true);
                        widgetSelection.toggleNoWidgets(true);
                        File? pickedImage = widgetSelection.selectedImage;
                        if (pickedImage != null) {
                          final reference = FirebaseStorage.instance
                              .ref()
                              .child('assignments/${pickedImage.path}');
                          try {
                            await reference.putFile(File(pickedImage.path));
                            final downloadUrl =
                                await reference.getDownloadURL();
                            widgetSelection.setImageLink(downloadUrl);
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error uploading image: $error'),
                              ),
                            );
                          }
                        }
                        if ((widgetSelection.text != null &&
                                widgetSelection.text!.isNotEmpty) ||
                            widgetSelection.imageLink != null) {
                          final firestore = FirebaseFirestore.instance;
                          try {
                            final docRef = firestore
                                .collection('Widget')
                                .doc('Assignment');

                            await docRef.update({
                              'Text': widgetSelection.text,
                              'Image': widgetSelection.imageLink,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Data successfully uploaded to firebase')));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Error uploading data to Firebase: $e'),
                              ),
                            );
                          }
                        }
                        widgetSelection.toggleSaving(false);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
          ],
        );
      },
    );
  }
}
