import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(ShirasthraApp());
}

class ShirasthraApp extends StatelessWidget {
  const ShirasthraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shirasthra',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShirasthraHomePage(),
    );
  }
}

class ShirasthraHomePage extends StatefulWidget {
  const ShirasthraHomePage({super.key});

  @override
  _ShirasthraHomePageState createState() => _ShirasthraHomePageState();
}

class _ShirasthraHomePageState extends State<ShirasthraHomePage> {
  final AudioPlayer _player = AudioPlayer();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _sendMessage(String message) {
    // Implement the logic to send the message to the guardian's phone
    print('Message sent: $message');
  }

  void _playSiren() async {
    try {
      await _player.play(AssetSource('audio/Siren.mp3')); // Ensure correct path
    } catch (e) {
      print("Error playing siren: $e");
    }
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Guardian Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration:
                    const InputDecoration(labelText: 'Guardian Phone Number'),
              ),
              const SizedBox(height: 20),
              const Text('Emergency Numbers:'),
              const Text('Pink Police - 112'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shirasthra'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Shirasthra',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton('nervous-unaccompanied', Colors.yellow),
                _buildButton('creepy-stalker', Colors.orange),
                _buildButton('immediate help', Colors.red),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: _playSiren, // 🚨 Plays the siren when clicked
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text('Siren'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => _sendMessage(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
