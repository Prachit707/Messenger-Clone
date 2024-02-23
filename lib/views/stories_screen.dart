import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_clone/services/database.dart';
import 'dart:convert';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  List<String> _stories = [];
  List<DateTime> _storyTimestamps = [];

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  void _loadStories() async {
    // Implement logic to fetch stories from Firestore
    // For now, I'm just setting some placeholder URLs and timestamps
    setState(() {
      _stories = [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
        // Add more story URLs here
      ];
      _storyTimestamps = [
        DateTime.now().subtract(Duration(hours: 3)), // Example timestamp
        DateTime.now().subtract(Duration(minutes: 30)), // Example timestamp
        // Add more timestamps here
      ];
    });
  }

  void _getImageAndUpload() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Valid file path obtained
      print('File Path: ${pickedFile.path}');

      // Check if the file exists
      File imageFile = File(pickedFile.path);
      if (await imageFile.exists()) {
        setState(() {
          _imageFile = imageFile;
        });

        String? downloadURL = await DatabaseMethods().uploadImage(_imageFile!);

        if (downloadURL != null) {
          // Image uploaded successfully
          print('Image uploaded. Download URL: $downloadURL');
          // Update the UI with the new story URL and timestamp
          setState(() {
            _stories.add(downloadURL);
            _storyTimestamps.add(DateTime.now());
          });
        } else {
          // Image upload failed
          print('Image upload failed.');
        }
      } else {
        // File does not exist
        print('Selected file does not exist.');
      }
    } else {
      // File picker returned null
      print('No file selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_storyTimestamps.isNotEmpty
            ? 'Stories (${_storyTimestamps.length}) - ${_storyTimestamps.first.hour}:${_storyTimestamps.first.minute}'
            : 'Stories'),
      ),
      body: _stories.isEmpty
          ? Center(
              child: Text('No stories available'),
            )
          : ListView.builder(
              itemCount: _stories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(_stories[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Show username only when a story is available
                      Text(
                        'My Story', // Display username or other info here
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageAndUpload,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
