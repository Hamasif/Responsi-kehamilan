import 'package:flutter/material.dart';
import 'add_pregnancy_record.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pregnancyRecords = [
    {
      'name': 'Natasha Wilona',
      'month': 5,
      'babyWeight': 2.5,
    },
    {
      'name': 'Emily Brown',
      'month': 7,
      'babyWeight': 3.0,
    },
    {
      'name': 'Alicia Clark',
      'month': 9,
      'babyWeight': 3.5,
    },
  ];

  void _addOrEditRecord([Map<String, dynamic>? record, int? index]) async {
    final newRecord = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPregnancyRecord(
          record: record, // Pass the record for editing if provided
        ),
      ),
    );

    if (newRecord != null) {
      setState(() {
        if (index != null) {
          // Update record if editing
          pregnancyRecords[index] = newRecord;
        } else {
          // Add new record if creating
          pregnancyRecords.add(newRecord);
        }
      });
    }
  }

  void _deleteRecord(int index) {
    setState(() {
      pregnancyRecords.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Catatan Kehamilan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Calibri', // Set font Calibri
              color: Colors.white, // Placeholder color, akan tertutup oleh gradien
            ),
          ),
        ),
        elevation: 0, // Hapus bayangan AppBar untuk tampilan bersih
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: pregnancyRecords.length,
          itemBuilder: (context, index) {
            final record = pregnancyRecords[index];
            return Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ListTile(
                title: Text(
                  record['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri', // Set font Calibri untuk nama
                  ),
                ),
                subtitle: Text(
                  'Bulan: ${record['month']}',
                  style: TextStyle(
                    fontFamily: 'Calibri',
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _addOrEditRecord(record, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteRecord(index);
                      },
                    ),
                  ],
                ),
                leading: Text(
                  '${record['babyWeight']} kg',
                  style: TextStyle(
                    fontFamily: 'Calibri', // Font untuk berat bayi
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addOrEditRecord();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900], // Warna biru tua
      ),
    );
  }
}
