import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(BancoDigitalApp());
}

class BancoDigitalApp extends StatelessWidget {
  const BancoDigitalApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco Jujubinha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        PrincipalScreen.routeName: (context) => PrincipalScreen(),
        CotacaoScreen.routeName: (context) =>
            CotacaoScreen(title: 'Conversor de Moeda'),
        TransferenciaScreen.routeName: (context) => TransferenciaScreen(),
        TransferenciaScreen2.routeName: (context) => TransferenciaScreen2(),
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png', // Certifique-se de ter uma imagem logo.png na pasta assets
                height: 150,
              ),
            ),
            SizedBox(height: 80),
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PrincipalScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 132, 1, 67),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 95,
                    vertical: 15,
                  ),
                ),
                child: Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrincipalScreen extends StatefulWidget {
  static const routeName = '/principal';

  @override
  _PrincipalScreenState createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  bool _showSaldo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(0xFF840143),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Conta',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Banco Jujubinha',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Text(
                  'Saldo em conta',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                Visibility(
                  visible: _showSaldo,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ 5000,00',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Rendendo 104% do CDI',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(177, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 30.0),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showSaldo = !_showSaldo;
                    });
                  },
                  icon: Icon(
                    _showSaldo
                        ? Icons.visibility_off
                        : Icons
                            .visibility, // Altera o ícone com base no estado _showSaldo
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .center, // Centraliza os elementos horizontalmente
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // Cor da caixa
                      borderRadius:
                          BorderRadius.circular(8), // Borda arredondada
                    ),
                    padding: EdgeInsets.all(15), // Espaçamento interno
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, CotacaoScreen.routeName);
                      },
                      icon: Icon(Icons.monetization_on),
                      color: Colors.white, // Cor do ícone
                    ),
                  ),
                  Text('Cotação', style: TextStyle(fontSize: 15)),
                ],
              ),
              SizedBox(width: 40), // Espaço entre os botões
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green, // Cor da caixa
                      borderRadius:
                          BorderRadius.circular(8), // Borda arredondada
                    ),
                    padding: EdgeInsets.all(15), // Espaçamento interno
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, TransferenciaScreen2.routeName);
                      },
                      icon: Icon(Icons.money),
                      color: Colors.white, // Cor do ícone
                    ),
                  ),
                  Text('Transferência', style: TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
          SizedBox(height: 150),
        ],
      ),
    );
  }
}

Future<Map> getData() async {
  var url =
      Uri.parse('https://api.hgbrasil.com/finance?format=json&key=611517b7');
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class CotacaoScreen extends StatefulWidget {
  static const routeName = '/cotacao';
  final String title;

  CotacaoScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<CotacaoScreen> createState() => _CotacaoScreenState();
}

class _CotacaoScreenState extends State<CotacaoScreen> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  double dolar = 0.0;
  double euro = 0.0;

  void _realChanged(String text) {
    if (text.isEmpty) return;
    try {
      double real = double.parse(text);
      dolarController.text = (real / dolar).toStringAsFixed(2);
      euroController.text = (real / euro).toStringAsFixed(2);
    } catch (e) {
      print("Erro ao converter o valor: $e");
    }
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) return;
    try {
      double dolar = double.parse(text);
      realController.text = (dolar * this.dolar).toStringAsFixed(2);
      euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    } catch (e) {
      print("Erro ao converter o valor: $e");
    }
  }

  void _euroChanged(String text) {
    if (text.isEmpty) return;
    try {
      double euro = double.parse(text);
      realController.text = (euro * this.euro).toStringAsFixed(2);
      dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    } catch (e) {
      print("Erro ao converter o valor: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 132, 1, 67),
        title: Align(
          alignment: const AlignmentDirectional(-0.3, 0),
          child: Text(
            'COTAÇÃO',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Aguarde...",
                  style: TextStyle(
                      color: Color.fromARGB(255, 132, 1, 67), fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                String? erro = snapshot.error.toString();
                return Center(
                  child: Text(
                    "Ops, houve uma falha ao buscar os dados : $erro",
                    style: TextStyle(
                        color: Color.fromARGB(255, 132, 1, 67), fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.attach_money,
                          size: 180.0, color: Color.fromARGB(255, 132, 1, 67)),
                      campoTexto("Reais", "R\$ ", realController, _realChanged),
                      Divider(),
                      campoTexto("Euros", "€ ", euroController, _euroChanged),
                      Divider(),
                      campoTexto(
                          "Dólares", "US\$ ", dolarController, _dolarChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget campoTexto(
      String label, String prefix, TextEditingController c, Function? f) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color.fromARGB(255, 171, 9, 90)),
        border: OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: TextStyle(color: Color.fromARGB(255, 17, 17, 17), fontSize: 25.0),
      onChanged: (value) => f!(value),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}

class TransferenciaScreen2 extends StatelessWidget {
  static const routeName = '/transferenciainicio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 132, 1, 67),
        title: Align(
          alignment: const AlignmentDirectional(-0.3, 0),
          child: Text(
            'TRANSFERÊNCIA',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Center(
        // Envolvendo o conteúdo em um Center para centralizar
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ajusta o tamanho da coluna ao conteúdo
            crossAxisAlignment: CrossAxisAlignment
                .center, // Centraliza os filhos horizontalmente
            children: [
              Text(
                'Você deseja transferir para:',
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Amandinha', // Substitua pelo nome real da pessoa
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Valor: R\$ 450,00',
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, TransferenciaScreen.routeName);
                },
                child: Text(
                  'Transferir',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 132, 1, 67),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransferenciaScreen extends StatelessWidget {
  static const routeName = '/transferencia';

  TransferenciaScreen({Key? key}) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _compartilhar(BuildContext context) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    final imagePath = await screenshotController.captureAndSave(directory,
        fileName: "comprovante.png");
    Share.shareXFiles([XFile(imagePath!)],
        text: 'Comprovante de Transferência');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 132, 1, 67),
        title: Align(
          alignment: const AlignmentDirectional(-0.3, 0),
          child: Text(
            'TRANSFERÊNCIA',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transferência Realizada',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Valor: R\$ 500,00',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 61, 61, 61),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Data: 29/05/2024',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 121, 25, 159),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _compartilhar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 132, 1, 67),
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 95,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('Compartilhar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
