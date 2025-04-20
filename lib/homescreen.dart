import 'package:flutter/material.dart';
import 'user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = User.fetchRandomUser();
  }

  void _refreshUser() {
    setState(() {
      _futureUser = User.fetchRandomUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Random User Info Viewer',
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          color: Colors.white, 
        ),
        ),
        backgroundColor: Colors.purple, 
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    infoRow(Icons.person, 'Gender: ${user.gender}'),
                    infoRow(Icons.flag, 'Nationality: ${user.nationality}'),
                    infoRow(Icons.location_city, 'Location: ${user.city}, ${user.country}'),
                    infoRow(Icons.email, 'Email: ${user.email}'),
                    infoRow(Icons.phone, 'Phone: ${user.phone}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _refreshUser,
                      child: const Text('Load Another User'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 10),
                  Text(
                    'Failed to load user!',
                    style: TextStyle(fontSize: 18, color: Colors.red[600]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _refreshUser,
                    child: const Text('Try Again'),
                  )
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
