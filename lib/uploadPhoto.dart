import 'dart:core';
import 'package:flutter/material.dart';
import 'package:foodblog_app/homePage.dart';
import 'package:foodblog_app/utility.dart';
import 'package:intl/intl.dart';
import 'package:foodblog_app/db_helper.dart';
import 'package:foodblog_app/blog_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'homePage.dart';
import 'package:sqflite/sqflite.dart';
import 'utility.dart';
import 'package:flutter/cupertino.dart';



class UploadPhotoPage extends StatefulWidget
{
  Photo bphoto_name;

  UploadPhotoPage(): super();
  @override
  State<StatefulWidget> createState()
  {
    return _UploadPhotoPageState();
  }
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  //declaring images db
  File sampleImage;
  String _myValue;
  // String url;
  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;

  List<Photo> images;

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    refreshImage();
  }

  //refresh images
  refreshImage() {
    dbHelper.getPhotos().then((image) {
      setState(() {
        images.clear();
        images.addAll(image);
      });

    });
  }

  //pick image from gallery
  pickImageFromGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery)
        .then((imageFile) {
      String imageString = Utility.base64String(imageFile.readAsBytesSync());
      Photo bphoto = Photo(0, imageString);
      dbHelper.save(bphoto);
      refreshImage();
    });
  }

//pick image from camera
  pickImageFromCamera() {
    ImagePicker.pickImage(source: ImageSource.camera)
        .then((imageFile) {
      String imageString = Utility.base64String(imageFile.readAsBytesSync());
      Photo bphoto = Photo(0, imageString);
      dbHelper.save(bphoto);
      refreshImage();
    });
  }

// delete image

       Widget deleteButton() => IconButton(
             onPressed: () async {
             await dbHelper.delete(widget.bphoto_name);
      refreshImage();
      //Navigator.of(context).pop();
    },
            icon: Icon(Icons.delete, color: Colors.black,)//),
       );


// UI view of the uploaded images
  gridView() {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        mainAxisSpacing: 2.0,
         children: images.map ((bphoto) {
          return Utility.imageFromBase64String(bphoto.photo_name);
        }).toList(),
      ),
    );
  }


//UI of uploading image
  void goToHomePage(){
    Navigator.push
      (
      context,
      MaterialPageRoute(builder: (context)
          {
            return new HomePage();
          }
      )
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
      (
          appBar: new AppBar
            (
          title: new Text("Upload blog image "),
          centerTitle: true,
          ),
      floatingActionButton: new FloatingActionButton
        (
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
        // onPressed: getImage,
        onPressed: pickImageFromGallery,

      ),


      body: new Center
        (
        //child: sampleImage == null ? Text("Create your blog"): enableUpload(),
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           Flexible(
          child: gridView(),
                )
              ],
      ),
    ),
    );
  }
  Widget enableUpload()
  {
   return Container (
      child: new Form (
        key: formKey,
        child: Column
          (
          children: <Widget>
          [
            Image.file(sampleImage,height: 330.0, width: 660.0),

            SizedBox(height: 15.0),

            TextFormField
          (
              decoration: new InputDecoration(labelText: 'Description'),

              validator: (value)
              {
                return value.isEmpty ? 'Blog Description is required' : null;
              },

              onSaved: (value)
              {
                return _myValue = value;
              },
            ),
           SizedBox(height: 15.0,),
            
            // ignore: deprecated_member_use
            RaisedButton(
                elevation: 10.0,
               child: Text("Add a New Blog "),
              textColor: Colors.white,
              color: Colors.amber,
               onPressed: refreshImage,
              //onPressed: uploadImageStatus,
            )
          ],

        ),

      ),
   );
   }
  }
