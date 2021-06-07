import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({Key key}) : super(key: key);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  bool _isComposer = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.photo_camera)
          ),
          Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: "Enviar Mensagem"),
                onChanged: (text){
                  // se o botão nao estiver vazio
                  setState(() {
                    _isComposer = text.isNotEmpty;
                  });

                },
                onSubmitted: (text){

                },
              )
          ),
          IconButton(
            // se tiver nulo, desabilita o botão
              onPressed: _isComposer ? (){

              } : null,
              icon: Icon(Icons.send)
          ),
        ],
      ),
    );
  }
}
