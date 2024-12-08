import 'dart:io';
import 'package:budget/dialogs/fast_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageProviderService {
  // Method to pick an image and copy it to app's directory
  Future<String?> pickAndSaveImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker(); // Image picker instance
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery, // or ImageSource.camera
      );

      if (pickedFile != null) {
        return pickedFile.path;
      }
    } catch (e) {
      informationBar(context,'Error picking or saving image: $e');
    }
    // Return null if no image is picked or an error occurs
    return null;
  }

  Future<void> saveImageIntoFile(
      {required String path, required String? oldImage}) async {
    // Get the directory to save the file
    Directory appDir = await getApplicationDocumentsDirectory();
    // Get the file name from the picked file
    String fileName = basename(path);
    // Copy the file to the app directory
    await File(path).copy('${appDir.path}/$fileName');
    // Return the path to the saved image
    if(oldImage != null){
      File(oldImage).delete();
    }
  }
}
