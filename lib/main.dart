// lib/main.dart
import 'package:flutter/material.dart';

void main() => runApp(const OpenIMCIApp());

class OpenIMCIApp extends StatelessWidget {
  const OpenIMCIApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open IMCI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open IMCI'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, size: 100, color: Colors.teal),
            const SizedBox(height: 30),
            const Text(
              'Offline IMCI Assistant\nfor Community Health Workers',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AssessmentPage()),
              ),
              icon: const Icon(Icons.play_arrow, size: 32),
              label: const Text('Start New Assessment', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});
  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  String? ageGroup;
  final Map<String, bool> symptoms = {};

  final List<String> dangerSigns = [
    'Not able to drink or breastfeed',
    'Vomits everything',
    'Convulsions',
    'Lethargic or unconscious',
    'Chest indrawing',
    'Stridor in calm child',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Child Assessment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ageGroup == null ? _buildAgeSelection() : _buildSymptoms(),
      ),
    );
  }

  Widget _buildAgeSelection() {
    return Column(
      children: [
        const Text('Select age group', style: TextStyle(fontSize: 22)),
        const SizedBox(height: 30),
        _ageButton('< 2 months', 'young'),
        _ageButton('2 months – 5 years', 'older'),
      ],
    );
  }

  Widget _ageButton(String text, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => setState(() => ageGroup = value),
          child: Text(text, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  Widget _buildSymptoms() {
    return ListView(
      children: [
        Text('Age: ${ageGroup == 'young' ? '< 2 months' : '2 months – 5 years'}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Divider(),
        const Text('Check for DANGER SIGNS (any = RED)', style: TextStyle(fontSize: 20, color: Colors.red)),
        ...dangerSigns.map((sign) => CheckboxListTile(
              title: Text(sign),
              value: symptoms[sign] ?? false,
              onChanged: (val) => setState(() => symptoms[sign] = val!),
            )),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _showResult,
          child: const Text('CLASSIFY & TREAT', style: TextStyle(fontSize: 22)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.all(16)),
        ),
      ],
    );
  }

  void _showResult() {
    bool hasDanger = symptoms.values.contains(true);
    String classification = hasDanger
        ? 'VERY SEVERE DISEASE → URGENT REFERRAL'
        : 'No danger signs yet – continue assessment';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Classification'),
        content: Text(classification, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
