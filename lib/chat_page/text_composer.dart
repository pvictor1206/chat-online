import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  bool _isComposer = false;

  final TextEditingController _controller = TextEditingController();

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
              onPressed:() async {
                final File imgfile =
                (await ImagePicker.platform.pickImage(source: ImageSource.gallery)) as File;
                if(imgfile == null) return;
                widget.sendMessage(imgFile: imgfile);

              },
              icon: Icon(Icons.photo_camera)
          ),
          Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration.collapsed(hintText: "Enviar Mensagem"),
                onChanged: (text){
                  // se o botão nao estiver vazio
                  setState(() {
                    _isComposer = text.isNotEmpty;
                  });

                },
                // Vai mandar o texto para onSubmitted
                onSubmitted: (text){
                  widget.sendMessage(text: text);
                  _reset();
                },
              )
          ),
          IconButton(
            // se tiver nulo, desabilita o botão
              onPressed: _isComposer ? (){
                widget.sendMessage(text: _controller.text);
                _reset();
              } : null,
              icon: Icon(Icons.send)
          ),
        ],
      ),
    );
  }
}
