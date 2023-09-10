import 'package:flutter/material.dart';
import '../screens/listcontato.dart';
import '../screens/list.dart';

class MenuOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuOptionsState();
  }
}

class MenuOptionsState extends State<MenuOptions> {
  int paginaAtual = 0;
  PageController? pc;

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [ListaTarefa(), ListaContato()],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: "Tarefas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Contatos")
        ],
        onTap: (pagina) {
          pc?.animateToPage(pagina,
              duration: Duration(microseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
