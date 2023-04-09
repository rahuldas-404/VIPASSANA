import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginPage file or replace with the actual name of your login page file
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');


class SignUpPage extends StatelessWidget {
  String? _selectedDisability; // Update type to String?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email', // Add email label
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Disability',
                border: OutlineInputBorder(),
              ),
              value: _selectedDisability,
              items: [
                DropdownMenuItem<String>(
                  child: Text('Deaf'),
                  value: 'Deaf',
                ),
                DropdownMenuItem<String>(
                  child: Text('Dumb'),
                  value: 'Dumb',
                ),
                DropdownMenuItem<String>(
                  child: Text('Both'),
                  value: 'Both',
                ),
              ],
              onChanged: (value) {
                _selectedDisability = value;
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Add sign-up logic here
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Already have an account? Login'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // TODO: Add forgot password logic here
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
