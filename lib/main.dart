import 'package:flutter/material.dart';

void main() {
  runApp(QuantumComputingSimulatorApp());
}

class QuantumComputingSimulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quantum Computing Simulator',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1E1E2C), // Dark background color
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: QuantumSimulatorHomePage(),
    );
  }
}

class QuantumSimulatorHomePage extends StatefulWidget {
  @override
  _QuantumSimulatorHomePageState createState() =>
      _QuantumSimulatorHomePageState();
}

class _QuantumSimulatorHomePageState extends State<QuantumSimulatorHomePage> {
  int qubit1 = 0;
  int qubit2 = 0;

  String algorithmResult = "";

  void applyHadamardGate(int qubitIndex) {
    setState(() {
      if (qubitIndex == 1) {
        qubit1 = qubit1 == 0 ? 1 : 0;
      } else if (qubitIndex == 2) {
        qubit2 = qubit2 == 0 ? 1 : 0;
      }
    });
  }

  void applyPauliXGate(int qubitIndex) {
    setState(() {
      if (qubitIndex == 1) {
        qubit1 = qubit1 == 0 ? 1 : 0;
      } else if (qubitIndex == 2) {
        qubit2 = qubit2 == 0 ? 1 : 0;
      }
    });
  }

  void applyCNOTGate() {
    setState(() {
      if (qubit1 == 1) {
        qubit2 = qubit2 == 0 ? 1 : 0;
      }
    });
  }

  void runDeutschJozsaAlgorithm() {
    setState(() {
      applyHadamardGate(1);
      applyHadamardGate(2);
      applyPauliXGate(2);
      applyHadamardGate(1);
      algorithmResult = qubit1 == 0 ? "Constant Function" : "Balanced Function";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF282846), // Matching dark color for the app bar
        title: Center(
          child: Text(
            'Quantum Computing Simulator',
            style: TextStyle(color: Colors.white), // Set the text color to white
          ),
        ),
      ),
      body: Center( // Center the entire content
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QubitVisualRepresentation(
                qubitState: qubit1,
                qubitLabel: 'Qubit 1',
              ),
              SizedBox(height: 10),
              QubitVisualRepresentation(
                qubitState: qubit2,
                qubitLabel: 'Qubit 2',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => applyHadamardGate(1),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3D3D65), // Button background color
                ),
                child: Text('Apply Hadamard Gate to Qubit 1'),
              ),
              ElevatedButton(
                onPressed: () => applyHadamardGate(2),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3D3D65),
                ),
                child: Text('Apply Hadamard Gate to Qubit 2'),
              ),
              ElevatedButton(
                onPressed: () => applyPauliXGate(1),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3D3D65),
                ),
                child: Text('Apply Pauli-X Gate to Qubit 1'),
              ),
              ElevatedButton(
                onPressed: () => applyPauliXGate(2),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3D3D65),
                ),
                child: Text('Apply Pauli-X Gate to Qubit 2'),
              ),
              ElevatedButton(
                onPressed: applyCNOTGate,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3D3D65),
                ),
                child: Text('Apply CNOT Gate'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: runDeutschJozsaAlgorithm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF5D5D85),
                ),
                child: Text('Run Deutsch-Jozsa Algorithm'),
              ),
              SizedBox(height: 20),
              Text(
                'Algorithm Result: $algorithmResult',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QubitVisualRepresentation extends StatelessWidget {
  final int qubitState;
  final String qubitLabel;

  QubitVisualRepresentation({required this.qubitState, required this.qubitLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          qubitLabel,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        CustomPaint(
          size: Size(100, 100),
          painter: QubitPainter(qubitState),
        ),
        SizedBox(height: 10),
        Text(
          '|${qubitState == 0 ? '0' : '1'}⟩',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ],
    );
  }
}

class QubitPainter extends CustomPainter {
  final int qubitState;

  QubitPainter(this.qubitState);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = qubitState == 0 ? Colors.blue : Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
