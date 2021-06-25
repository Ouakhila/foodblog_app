import 'package:flutter/material.dart';
import 'package:foodblog_app/db_helper.dart';
import 'package:foodblog_app/blog_model.dart';
import 'package:foodblog_app/listOfBlogs.dart';
import 'package:foodblog_app/uploadPhoto.dart';
import 'package:share/share.dart';
import'uploadPhoto.dart';
import 'listOfBlogs.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {


  @override
   State <StatefulWidget> createState()
  {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
{
  List<ListOfBlogs>get listOfBlogs => [ ListOfBlogs(name: "Foodie", description: " How to eat healthy "),
                ListOfBlogs(name:"Foodie", description: " How to eat healthy "),
                ListOfBlogs(name:"Foodie", description: " How to eat healthy "),
    ListOfBlogs(name:"Foodie", description: " How to eat healthy "),
    ListOfBlogs(name:"Foodie", description: " How to eat healthy "),
  ];

  @override
  Widget build(BuildContext context )
  {
    return new Scaffold(
      appBar: new AppBar
        (
         title: new Text("blog food home"),
      ),

          body: Column

          // DISPLAYING LIST OF WRITTEN BLOGS
        (
            // ignore: non_constant_identifier_names
            children: listOfBlogs.map((ListOfBlogs listOfBlogs) => Card(
              child: ListTile (
                title: Text(listOfBlogs.name),
                subtitle: Text(listOfBlogs.description),
                onTap: () => share(context, listOfBlogs),
              ),
          ))
         .toList()

    ),
    bottomNavigationBar: new BottomAppBar(
    color: Colors.amber,

    child: new Container
  (
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
  child: new Row (
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,

    children: <Widget>
  [
    //ARTICLE ICON
   new IconButton
       (
       icon: new Icon(Icons.article_outlined),
       iconSize: 50,
       color: Colors.white,

       ),

     //PICK IMAGE ICON
     new IconButton
  (
        icon: new Icon(Icons.add_a_photo),
          iconSize: 40,
        color: Colors.white,
        onPressed: ()
        {
         Navigator.push
           (
           context, 
           MaterialPageRoute(builder:  (context)
           {
             return new UploadPhotoPage();
           })
         );
        },
        ),

    ],
    ),
    ),
    ),
    );

    //SHARING FEATURES
  }
  void share(BuildContext context, ListOfBlogs listOfBlogs){
    final RenderBox box = context.findRenderObject();
    final String text = "${listOfBlogs.name} - ${listOfBlogs.description}";
    

    Share.share(text, subject: listOfBlogs.description);
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size;
  }

}

