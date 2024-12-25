import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _analysis = "";
  String _recommendation = "";

  // Simulate code analysis
  void _analyzeCode() {
    if (_codeController.text.isNotEmpty) {
      setState(() {
        _analysis = "Analyse du code :\n- Détection de couplage élevé\n- Recommandation pour améliorer la flexibilité";
        _recommendation = "Patron recommandé : Singleton\nMotif : Réduire le couplage entre les composants.";
      });
    } else {
      setState(() {
        _analysis = "";
        _recommendation = "";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez entrer un code ou une description.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Générateur de Recommandations de Patrons'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Box for code or problem description
              _buildInputBox(),
              SizedBox(height: 20),

              // Analysis Box
              if (_analysis.isNotEmpty) _buildAnalysisBox(),
              SizedBox(height: 20),

              // Recommendation Box
              if (_recommendation.isNotEmpty) _buildRecommendationBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputBox() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.blueGrey[800],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entrez votre code ou la description du problème :',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _codeController,
              maxLines: 6,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey[600],
                border: OutlineInputBorder(),
                hintText: 'Exemple : Couplage trop élevé entre les modules...',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _analyzeCode,
              child: Text('Générer mon code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisBox() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analyse du code :',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              _analysis,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationBox() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.green[800],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patron de conception recommandé :',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              _recommendation,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
