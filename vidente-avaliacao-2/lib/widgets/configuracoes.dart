import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:vidente_app/controllers/cidade_controller.dart';
import 'package:vidente_app/controllers/tema_controller.dart';
import 'package:vidente_app/models/cidade.dart';
import 'package:vidente_app/models/tema.dart';
import 'package:vidente_app/services/cidade_service.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  List<Cidade> cidades;
  int valorTema;
  bool carregandoCidades;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    this.carregandoCidades = false;
    _controller = TextEditingController();
    carregarCidades();
  }

  void carregarCidades() async {
    CidadeService service = CidadeService();
    cidades = await service.recuperarCidades();
  }

  Iterable<Cidade> filtrarCidades(String consulta) {
    return this.cidades.where(
        (cidade) => cidade.nome.toLowerCase().contains(consulta.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    bool algumaCidadeEscolhida =
        CidadeController.instancia.cidadeEscolhida != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            algumaCidadeEscolhida ? "Configurações" : "Escolha uma cidade"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 60, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.brightness_6_outlined,
                  size: 24,
                ),
                VerticalDivider(),
                Text(
                  'Escolha o tema do app:',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: TemaController.instancia.temaEscolhido == null ||
                          TemaController.instancia.temaEscolhido.valorTema == 0
                      ? false
                      : true,
                  onChanged: (valor) {
                    this.valorTema = valor == false ? 0 : 1;
                    TemaController.instancia.trocarTema(Tema(valorTema));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TypeAheadField<Cidade>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Procurar cidade',
                ),
              ),
              suggestionsCallback: filtrarCidades,
              onSuggestionSelected: (sugestao) async {
                final String filtro = sugestao.nome + ' ' + sugestao.estado;
                this._controller.text = filtro;
              },
              itemBuilder: (context, sugestao) {
                return ListTile(
                  leading: Icon(Icons.place),
                  title: Text(sugestao.nome + " - " + sugestao.siglaEstado),
                  subtitle: Text(sugestao.estado),
                );
              },
              noItemsFoundBuilder: (context) => Container(
                child: Center(
                  child: Text(
                    'Nenhuma cidade encontrada',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                CidadeService service = CidadeService();

                TemaController.instancia.salvarTema(Tema(this.valorTema));

                if (this._controller.text != '') {
                  service.pesquisarCidade(this._controller.text).then(
                      (resultado) => Navigator.pushNamed(context, '/home'));
                  setState(() {
                    this.carregandoCidades = true;
                  });
                } else {
                  print("Selecione uma cidade");
                }
              },
              child: Text('Salvar', style: TextStyle(fontSize: 14)),
            ),
            this.carregandoCidades
                ? Column(
                    children: [
                      Padding(padding: EdgeInsets.all(20)),
                      Image(
                        image: AssetImage('images/loading.gif'),
                        width: 50,
                      )
                    ],
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
