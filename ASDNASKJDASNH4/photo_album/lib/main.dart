import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'globals.dart' as globals;

void main() {
  runApp(const PhotoAlbum());
}

Future<String> createFolder(String cow) async {
  final dir = Directory((Platform.isAndroid
              ? await getExternalStorageDirectory() //FOR ANDROID
              : await getApplicationSupportDirectory() //FOR IOS
          )!
          .path +
      '/$cow');
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await dir.exists())) {
    return dir.path;
  } else {
    dir.create();
    return dir.path;
  }
}

enum ImageSourceType { gallery, camera }
var pics = "abd";
ImagePicker picker = ImagePicker();

class PhotoAlbum extends StatelessWidget {
  // This widget is the root of your application.
  const PhotoAlbum({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    createFolder("imgs").then((str) => {globals.img_dir = str});
    return MaterialApp(
      title: 'Photo Album',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Album 571"),
      ),
      body: Column(
        children: [
          Expanded(child: AlbumGrid()),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  GalleryButton(updateParent: refresh),
                  CameraButton(updateParent: refresh),
                ],
              ))
        ],
      ),
    );
  }

  refresh() {
    setState(() => {});
  }
}

class AlbumGrid extends StatefulWidget {
  const AlbumGrid({Key? key}) : super(key: key);

  @override
  State<AlbumGrid> createState() => _AlbumGridState();
}

class _AlbumGridState extends State<AlbumGrid> {
  void _handleTapImage(BuildContext context, var path) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ShowFullImage(path: path)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        children: List.generate(globals.pic_list.length, (index) {
          //return Center(child: Text(globals.pic_list[index]));
          File im = File(globals.pic_list[index]);
          return GestureDetector(
              onTap: () => {_handleTapImage(context, globals.pic_list[index])},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(im, fit: BoxFit.cover),
              ));
        }));
  }
}

class ShowFullImage extends StatefulWidget {
  final path;
  const ShowFullImage({Key? key, required this.path}) : super(key: key);

  @override
  State<ShowFullImage> createState() => _ShowFullImageState();
}

class _ShowFullImageState extends State<ShowFullImage> {
  var h;
  var w;
  var info_str;

  void initState() {
    super.initState();
    var img = Image(image: FileImage(File(widget.path)));
    img.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          w = info.image.width;
          h = info.image.height;
          info_str =
              "Image width:" + w.toString() + "  Image height:" + h.toString();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Full screen image")),
      /*body: Column(
          children: [
            Center(
                child: Expanded(
                    child: Image.file(File(widget.path), fit: BoxFit.contain))),
            //Image.file(File(widget.path), fit: BoxFit.fitHeight),
            const Text("Image width:"),
            Text(w.toString()),
            const Text("Image height"),
            Text(h.toString())
          ],
        )*/
      body: Column(
        children: [
          Expanded(child: Image.file(File(widget.path), fit: BoxFit.contain)),
          Align(alignment: Alignment.bottomCenter, child: Text(info_str))
        ],
      ),
    );
  }
}

class GalleryButton extends StatefulWidget {
  final Function() updateParent;
  const GalleryButton({Key? key, required this.updateParent}) : super(key: key);

  @override
  State<GalleryButton> createState() => _GalleryButtonState();
}

class _GalleryButtonState extends State<GalleryButton> {
  void _handleURLButtonPress(BuildContext context, Function() update) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowImage(updateParent: update)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 50,
      margin: const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 224, 224, 224),
              onPrimary: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            _handleURLButtonPress(context, widget.updateParent);
            widget.updateParent();
          },
          icon: const Icon(Icons.add_photo_alternate_outlined),
          label: const Text('Add from photo', style: TextStyle(fontSize: 13))),
    );
  }
}

class CameraButton extends StatefulWidget {
  final Function() updateParent;
  const CameraButton({Key? key, required this.updateParent}) : super(key: key);

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  void _handleURLButtonPress(BuildContext context, Function() update) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowCamImage(updateParent: update)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 154,
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              _handleURLButtonPress(context, widget.updateParent);
              widget.updateParent();
            },
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Use camera', style: TextStyle(fontSize: 13))));
  }
}

class ShowImage extends StatefulWidget {
  final Function() updateParent;
  const ShowImage({Key? key, required this.updateParent}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  var _image;
  var imagePicker;

  void initState() {
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image from Gallery")),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                XFile? image = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 100,
                    preferredCameraDevice: CameraDevice.front);
                if (image != null) {
                  _image = File(image.path);

                  String path = globals.img_dir + '/' + image.name;
                  await _image.copy(path);
                  globals.pic_list.add(path);
                }
                setState(() {
                  if (image != null) {
                    _image = File(image.path);
                    widget.updateParent();
                  }
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShowCamImage extends StatefulWidget {
  final Function() updateParent;
  const ShowCamImage({Key? key, required this.updateParent}) : super(key: key);

  @override
  State<ShowCamImage> createState() => _ShowCamImageState();
}

class _ShowCamImageState extends State<ShowCamImage> {
  var _image;
  var imagePicker;

  void initState() {
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image from Camera")),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                XFile? image = await imagePicker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 100,
                    preferredCameraDevice: CameraDevice.front);
                if (image != null) {
                  _image = File(image.path);

                  String path = globals.img_dir + '/' + image.name;
                  await _image.copy(path);
                  globals.pic_list.add(path);
                }
                setState(() {
                  if (image != null) {
                    _image = File(image.path);
                    widget.updateParent();
                  }
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
