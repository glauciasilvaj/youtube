import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/VideoView.dart';
import 'package:youtube/model/Video.dart';

class Inicio extends StatefulWidget {

  String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesquisa){
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  void initState() {
    super.initState();
    //print("Chamado 1 - InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //print("Chamado 2 - DidChance");
  }

  @override
  void didUpdateWidget(covariant Inicio oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    //print("Chamado 2 - DidUpdateWidget");
  }

  @override
  void dispose() {

    super.dispose();
    //print("Chamado 4 - Dispose");
  }

  @override
  Widget build(BuildContext context) {
    //print("Chamado 3 - Build");

    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasData){
              return ListView.separated(
                  itemBuilder: (context, index){
                    List<Video>? videos = snapshot.data;
                    Video video = videos![index];

                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoView(video.id.toString()),
                            )
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(video.imagem),
                                )
                            ),
                          ),
                          ListTile(
                            title: Text(video.titulo),
                            subtitle: Text(video.canal),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 3,
                    color: Colors.red,
                  ),
                  itemCount: snapshot.data?.length ?? 0
              );
            }else{
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}
