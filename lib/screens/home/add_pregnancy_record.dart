import 'package:flutter/material.dart';

class AddPregnancyRecord extends StatefulWidget {
  final Map<String, dynamic>? record;

  AddPregnancyRecord({this.record}); // Tambahkan parameter opsional

  @override
  _AddPregnancyRecordState createState() => _AddPregnancyRecordState();
}

class _AddPregnancyRecordState extends State<AddPregnancyRecord> {
  final _nameController = TextEditingController();
  final _monthController = TextEditingController();
  final _babyWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.record != null) {
      // Jika sedang edit, isi field dengan data yang ada
      _nameController.text = widget.record!['name'];
      _monthController.text = widget.record!['month'].toString();
      _babyWeightController.text = widget.record!['babyWeight'].toString();
    }
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
            widget.record == null ? 'Tambah Catatan Kehamilan' : 'Edit Catatan Kehamilan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Calibri',
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0, // Hapus bayangan AppBar untuk tampilan bersih
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.deepOrange.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
              style: TextStyle(fontFamily: 'Calibri'), // Font Calibri
            ),
            TextField(
              controller: _monthController,
              decoration: InputDecoration(labelText: 'Bulan Kehamilan'),
              keyboardType: TextInputType.number,
              style: TextStyle(fontFamily: 'Calibri'), // Font Calibri
            ),
            TextField(
              controller: _babyWeightController,
              decoration: InputDecoration(labelText: 'Berat Bayi (kg)'),
              keyboardType: TextInputType.number,
              style: TextStyle(fontFamily: 'Calibri'), // Font Calibri
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newRecord = {
                  'name': _nameController.text,
                  'month': int.parse(_monthController.text),
                  'babyWeight': double.parse(_babyWeightController.text),
                };
                Navigator.pop(context, newRecord);
              },
              child: Text(widget.record == null ? 'Simpan' : 'Perbarui'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900], // Warna biru tua
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Calibri', // Font Calibri
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
