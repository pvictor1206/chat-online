import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  Function(String) sendMessage;

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
              onPressed: (){

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
                  _reset();
                },
              )
          ),
          IconButton(
            // se tiver nulo, desabilita o botão
              onPressed: _isComposer ? (){
                widget.sendMessage(_controller.text);
                _reset();
              } : null,
              icon: Icon(Icons.send)
          ),
        ],
      ),
    );
  }
}
