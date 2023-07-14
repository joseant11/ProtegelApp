import 'package:flutter/material.dart';

class SexualScreen extends StatefulWidget {
  const SexualScreen({super.key});

  @override
  State<SexualScreen> createState() => _SexualScreenState();
}

class _SexualScreenState extends State<SexualScreen> {
  late PageController _pageController;

  int _currentPageIndex = 0;
  List<String> _titles = ['Prioriza tu autocuidado', 'Preserva cualquier evidencia', 'Busca atención médica y apoyo emocional', 'Busca Ayuda Psicologica'];

  List<String> _texts = [
    'La recuperación de una agresión sexual puede llevar tiempo y es importante cuidar de ti misma durante este proceso. Prioriza tu salud mental, emocional y física. Busca actividades que te brinden bienestar, como practicar ejercicio, meditar, conectarte con la naturaleza o participar en actividades creativas. Recuerda que tu bienestar es primordial y tómate el tiempo necesario para sanar y reconstruirte.',
    'Si te encuentras en un entorno seguro, intenta preservar cualquier evidencia física que pueda respaldar tu caso, como la ropa que llevabas puesta durante la agresión. Evita lavar, cambiar o alterar cualquier evidencia hasta que puedas entregarla a las autoridades o profesionales especializados en recolección de pruebas.',
    'Después de una agresión sexual, es importante buscar atención médica lo antes posible. Acude a un centro de salud para recibir atención médica, evaluación de lesiones y pruebas forenses si es necesario. Además, busca apoyo emocional de personas de confianza o servicios especializados en violencia sexual para recibir apoyo y orientación en este proceso.',
    'El Ministerio de la Mujer ofrece lineas de apoyo Psicologico gratuitas,\ncontacte al siguiente numero (809-685-3755 ext. 4511)\no escriba al siguiente correo (prevencionyatencion@mujer.gob.do)',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPageIndex < _texts.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPageIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: Color(0xff5C4DB1),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset('images/Logo.png'),
                ),
                SizedBox(width: 10),
                Text(
                  'ProtegelApp',
                  style: TextStyle(
                      color: Color(0xff5C4DB1),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      wordSpacing: 2),
                ),
              ]),
            ),
            Container(
              width: double.infinity,
              child: Image.asset('images/Agresion.png'),
            ),
            Flexible(
                fit: FlexFit.loose,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20, left: 15),
                    decoration: BoxDecoration(
                        color: Color(0xff5C4DB1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 10),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3.3,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _texts.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(height: 16),
                                    Text(
                                      _titles[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      _texts[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onPageChanged: (index) {
                              setState(() {
                                _currentPageIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _nextPage,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Siguiente  ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffFFBF67),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ))
          ]),
        )
      );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _texts.length; i++) {
      indicators.add(
        Container(
          width: 7,
          height: 7,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPageIndex == i ? Colors.white : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
